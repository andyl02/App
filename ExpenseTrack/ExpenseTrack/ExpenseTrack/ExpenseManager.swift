import SwiftUI
import Combine
import CoreData

// New struct for decoding JSON data
struct APIExpense: Decodable {
    let amount: Double
    let category: String
}

class ExpenseManager: ObservableObject {
    @Published var expenses: [Expense] = []
    @Published var categories: [String] = ["Food", "Transport", "Entertainment", "Utilities", "Rent", "Miscellaneous"]
    @Published var budgets: [String: Double] = [:]
    @Published var expensesByCategory: [String: Double] = [:]

    var coreDataStack = CoreDataStack.shared

    init() {
        fetchExpenses()
        fetchBudgets()
        fetchDataFromAPI()
    }

    func fetchExpenses() {
        let fetchRequest: NSFetchRequest<Expense> = Expense.fetchRequest()
        do {
            expenses = try coreDataStack.context.fetch(fetchRequest)
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
        }
    }

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

    func addExpense(_ expense: Expense) {
        expenses.append(expense)
        saveContext()
    }

    func deleteExpense(at offsets: IndexSet) {
        for index in offsets {
            let expense = expenses[index]
            coreDataStack.context.delete(expense)
        }
        saveContext()
        fetchExpenses()
    }

    func addCategory(_ category: String) {
        categories.append(category)
        saveContext()
    }

    func deleteCategory(at offsets: IndexSet) {
        for index in offsets {
            let category = categories[index]
            categories.remove(at: index)
            budgets[category] = nil
        }
        saveContext()
    }

    func setBudget(for category: String, amount: Double) {
        budgets[category] = amount
        saveContext()
    }

    func getBudget(for category: String) -> Double {
        return budgets[category] ?? 0.0
    }

    func totalForCategory(_ category: String) -> Double {
        return expenses.filter { $0.category == category }.reduce(0) { $0 + $1.amount }
    }

    func remainingBudget(for category: String) -> Double {
        let totalExpensesForCategory = expenses.filter { $0.category == category }.map { $0.amount }.reduce(0, +)
        let budgetForCategory = getBudget(for: category)
        return budgetForCategory - totalExpensesForCategory
    }

    func saveContext() {
        do {
            try coreDataStack.context.save()
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
        }
    }

    // Networking code to fetch data from API
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
