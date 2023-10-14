// ExpenseManager.swift

import Foundation

class ExpenseManager: ObservableObject {
    @Published var expenses: [Expense] = []
    @Published var categories: [String] = []
    @Published var budgets: [String: Double] = [:]  
    
    func addExpense(_ expense: Expense) {
        expenses.append(expense)
    }
    
    func deleteExpense(at index: Int) {
        expenses.remove(at: index)
    }
    
    func generateReport() -> String {
        // report generation logic
        var report = "Expense Report\n\n"
        for expense in expenses {
            report += "Category: \(expense.category), Amount: \(expense.amount), Date: \(expense.date)\n"
        }
        return report
    }
    
    func addCategory(_ category: String) {
        categories.append(category)
    }
    
    func deleteCategory(at index: Int) {
        categories.remove(at: index)
    }
    
    func setBudget(for category: String, amount: Double) {
        budgets[category] = amount
    }
    
    func getBudget(for category: String) -> Double? {
        return budgets[category]
    }
}
