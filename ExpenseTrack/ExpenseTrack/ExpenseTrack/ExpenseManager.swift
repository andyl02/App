import SwiftUI
import Combine
import CoreData

class ExpenseManager: ObservableObject {
    @Published var expenses: [Expense] = []
    @Published var categories: [String] = ["Food", "Transport", "Entertainment", "Utilities", "Rent", "Miscellaneous"]
    @Published var budgets: [String: Double] = [:]

    private var coreDataStack = CoreDataStack.shared

    init() {
        fetchExpenses()
    }

    func fetchExpenses() {
        let fetchRequest: NSFetchRequest<Expense> = Expense.fetchRequest()
        do {
            expenses = try coreDataStack.context.fetch(fetchRequest)
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
        }
    }

    func addExpense(_ expense: Expense) {
        expenses.append(expense)
        coreDataStack.saveContext()
    }

    func deleteExpense(at offsets: IndexSet) {
        for index in offsets {
            let expense = expenses[index]
            coreDataStack.context.delete(expense)
        }
        coreDataStack.saveContext()
        fetchExpenses()
    }

    func addCategory(_ category: String) {
        categories.append(category)
    }

    func deleteCategory(at offsets: IndexSet) {
        for index in offsets {
            let category = categories[index]
            categories.remove(at: index)
            budgets[category] = nil
        }
    }

    func setBudget(for category: String, amount: Double) {
        budgets[category] = amount
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
}
