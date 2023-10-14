// ExpenseManager.swift

import Foundation

class ExpenseManager: ObservableObject {
    @Published var expenses: [Expense] = []
    @Published var categories: [String] = []
    
    func addExpense(_ expense: Expense) {
        expenses.append(expense)
    }
    
    func deleteExpense(at index: Int) {
        expenses.remove(at: index)
    }
    
    func generateReport() -> String {
        // Placeholder implementation for generating a report
        return "Expense Report"
    }
    
    // Added methods to manage categories
    func addCategory(_ category: String) {
        categories.append(category)
    }
    
    func deleteCategory(at indexSet: IndexSet) {
        for index in indexSet {
            categories.remove(at: index)
        }
    }
}
