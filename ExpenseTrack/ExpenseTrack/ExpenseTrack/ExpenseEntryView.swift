//
//  ExpenseEntryView.swift
//  ExpenseTrack
//

import SwiftUI

struct ExpenseEntryView: View {
    @EnvironmentObject var expenseManager: ExpenseManager
    @State private var category: String = ""
    @State private var amount: Double = 0.0
    
    var body: some View {
        Form {
            Section(header: Text("Expense Details")) {
                TextField("Category", text: $category)
                TextField("Amount", value: $amount, format: .currency(code: Locale.current.currency?.identifier ?? ""))
            }
            
            Button(action: addExpense) {
                Text("Save Expense")
            }
        }
        .navigationTitle("Add Expense")
    }
    
    private func addExpense() {
        let expense = Expense(category: category, amount: amount, date: Date())
        expenseManager.addExpense(expense)
        category = ""
        amount = 0.0
    }
}

struct ExpenseEntryView_Previews: PreviewProvider {
    static var previews: some View {
        ExpenseEntryView()
    }
}
