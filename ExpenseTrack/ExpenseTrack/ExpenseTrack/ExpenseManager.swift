import SwiftUI
import Combine
import CoreData

/// `ExpenseManager` is a class that manages all expense-related operations.
///
/// This class provides published properties for expenses, categories, budgets, and expenses by category. It also provides methods for fetching expenses and budgets from Core Data, adding and deleting expenses and categories, setting and getting budgets for categories, calculating total expenses for a category, calculating the remaining budget for a category, saving the Core Data context, and fetching data from an API.
struct APIExpense: Decodable {
    let amount: Double
    let category: String
}
/// Manages all expense-related operations.
class ExpenseManager: ObservableObject {
    /// An array of expenses.
        @Published var expenses: [Expense] = []
        
        /// An array of categories.
        @Published var categories: [String] = ["Food", "Transport", "Entertainment", "Utilities", "Rent", "Miscellaneous"]
        
        /// A dictionary of budgets keyed by category.
        @Published var budgets: [String: Double] = [:]
        
        /// A dictionary of expenses by category.
        @Published var expensesByCategory: [String: Double] = [:]
        
        /// The Core Data stack.
        var coreDataStack = CoreDataStack.shared
    
    /// Initializes the expense manager.
    init() {
        fetchExpenses()
        fetchBudgets()
        fetchDataFromAPI()
    }

    /// Fetches expenses from Core Data.
    func fetchExpenses() {
        let fetchRequest: NSFetchRequest<Expense> = Expense.fetchRequest()
        do {
            expenses = try coreDataStack.context.fetch(fetchRequest)
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
        }
    }
    
    /// Fetches budgets from Core Data.
    func fetchBudgets() {
        let fetchRequest: NSFetchRequest<Budget> = Budget.fetchRequest()
        do {
            let fetchedBudgets = try coreDataStack.context.fetch(fetchRequest)
            for budget in fetchedBudgets {
                if let category = budget.category {
                    budgets[category] = budget.amount
                }
            }
        } catch let error as NSError {
            print("Could not fetch budgets. \(error), \(error.userInfo)")
        }
    }

    /// Adds a new expense.
    /// - Parameter expense: The expense to add.
    func addExpense(_ expense: Expense) {
        expenses.append(expense)
        saveContext()
    }

    /// Deletes an expense.
    /// - Parameter offsets: The index set of the expense to delete.
    func deleteExpense(at offsets: IndexSet) {
        for index in offsets {
            let expense = expenses[index]
            coreDataStack.context.delete(expense)
        }
        saveContext()
        fetchExpenses()
    }

    /// Adds a new category.
    /// - Parameter category: The category to add.
    func addCategory(_ category: String) {
        categories.append(category)
        saveContext()
    }

    /// Deletes a category.
    /// - Parameter offsets: The index set of the category to delete.
    func deleteCategory(at offsets: IndexSet) {
        for index in offsets {
            let category = categories[index]
            categories.remove(at: index)
            budgets[category] = nil
        }
        saveContext()
    }
    
    /// Sets the budget for a category.
    /// - Parameters:
    /// - category: The category for which to set the budget.
    /// - amount: The budget amount.
    func setBudget(for category: String, amount: Double) {
        budgets[category] = amount
        saveContext()
    }
    
    /// Gets the budget for a category.
    /// - Parameter category: The category for which to get the budget.
    /// - Returns: The budget amount.
    func getBudget(for category: String) -> Double {
        return budgets[category] ?? 0.0
    }

    /// Calculates the total expenses for a category.
    /// - Parameter category: The category for which to calculate the total.
    /// - Returns: The total expenses for the category.
    func totalForCategory(_ category: String) -> Double {
        return expenses.filter { $0.category == category }.reduce(0) { $0 + $1.amount }
    }

    /// Calculates the remaining budget for a category.
    /// - Parameter category: The category for which to calculate the remaining budget.
    /// - Returns: The remaining budget for the category.
    func remainingBudget(for category: String) -> Double {
        let totalExpensesForCategory = expenses.filter { $0.category == category }.map { $0.amount }.reduce(0, +)
        let budgetForCategory = getBudget(for: category)
        return budgetForCategory - totalExpensesForCategory
    }

    /// Saves the Core Data context.
    func saveContext() {
        do {
            try coreDataStack.context.save()
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
        }
    }

    /// Fetches data from an API.
    func fetchDataFromAPI() {
        NetworkManager.shared.fetchJSONData(url: "https://api.example.com/data") { (decodedData: [APIExpense]?, error) in
            if let decodedData = decodedData {
                for _ in decodedData {
                }
            } else if let error = error {
                print("Error fetching data: \(error)")
            }
        }
    }
}
