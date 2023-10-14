// ExpenseEntryView.swift

import SwiftUI

struct ExpenseEntryView: View {
    @EnvironmentObject var expenseManager: ExpenseManager
    @State private var category: String = ""
    @State private var amount: Double = 0.0
    @State private var feedback: String = ""  // Added feedback state
    
    var body: some View {
        Form {
            Section(header: Text("Expense Details")) {
                TextField("Category", text: $category)
                TextField("Amount", value: $amount, format: .currency(code: Locale.current.currency?.identifier ?? ""))
            }
            
            Button(action: addExpense) {
                Text("Save Expense")
            }
            
            if !feedback.isEmpty {
                Text(feedback)
                    .foregroundColor(.red)
            }
        }
        .navigationTitle("Add Expense")
    }
    
    private func addExpense() {
        if category.isEmpty || amount <= 0 {
            feedback = "Please enter valid details."
            return
        }
        
        let expense = Expense(category: category, amount: amount, date: Date())
        expenseManager.addExpense(expense)
        feedback = "Expense added successfully!"
    }
}
