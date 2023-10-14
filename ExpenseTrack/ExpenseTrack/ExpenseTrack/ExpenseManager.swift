// ExpenseManager.swift

import SwiftUI
import Combine

class ExpenseManager: ObservableObject {
    @Published var expenses: [Expense] = []
    @Published var categories: [String] = ["Food", "Transport", "Entertainment", "Utilities", "Rent", "Miscellaneous"]
    @Published var budgets: [String: Double] = [:] // This dictionary will store budgets for each category

    // Computed property to get expenses grouped by category
    var expensesByCategory: [String: Double] {
        var totals: [String: Double] = [:]
        for expense in expenses {
            totals[expense.category, default: 0] += expense.amount
        }
        return totals
    }

    init() {
        // Sample data for testing
        expenses = [
            Expense(category: "Food", amount: 10.5, date: Date()),
            Expense(category: "Transport", amount: 2.5, date: Date()),
            Expense(category: "Entertainment", amount: 12.0, date: Date())
        ]
    }

    func addExpense(_ expense: Expense) {
        expenses.append(expense)
    }

    func deleteExpense(at offsets: IndexSet) {
        expenses.remove(atOffsets: offsets)
    }

    func addCategory(_ category: String) {
        categories.append(category)
    }

    func deleteCategory(at offsets: IndexSet) {
        categories.remove(atOffsets: offsets)
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
