//
//  ExpenseManager.swift
//  ExpenseTrack
//


import Foundation

class ExpenseManager: ObservableObject {
    @Published var expenses: [Expense] = []
    
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
}
