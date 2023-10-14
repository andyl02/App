// ExpenseEntryView.swift
import SwiftUI

struct ExpenseEntryView: View {
    @EnvironmentObject var expenseManager: ExpenseManager
    @State private var category: String = ""
    @State private var amount: Double = 0.0
    @State private var date: Date = Date()
    
    var body: some View {
        Form {
            Section(header: Text("Expense Details")) {
                TextField("Category", text: $category)
                TextField("Amount", value: $amount, format: .currency(code: expenseManager.currencyCode))
                DatePicker("Date", selection: $date, displayedComponents: .date)
            }
            
            Button(action: addExpense) {
                Text("Add Expense")
            }
        }
        .navigationTitle("Expense Entry")
    }
    
    private func addExpense() {
        expenseManager.addExpense(Expense(category: category, amount: amount, date: date))
        category = ""
        amount = 0.0
        date = Date()
    }
}
