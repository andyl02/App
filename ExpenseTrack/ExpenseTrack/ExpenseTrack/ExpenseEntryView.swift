// ExpenseEntryView.swift

import SwiftUI

struct ExpenseEntryView: View {
    @EnvironmentObject var expenseManager: ExpenseManager
    @State private var selectedCategory: String = ""
    @State private var amount: String = ""
    @State private var date: Date = Date()
    @State private var showAlert: Bool = false

    var body: some View {
        VStack {
            Form {
                Section(header: Text("Expense Details")) {
                    Picker("Category", selection: $selectedCategory) {
                        ForEach(expenseManager.categories, id: \.self) { category in
                            Text(category).tag(category)
                        }
                    }
                    TextField("Amount", text: $amount)
                        .keyboardType(.decimalPad)
                    DatePicker("Date", selection: $date, displayedComponents: .date)
                }
            }
            Button("Add Expense") {
                if let amountDouble = Double(amount), !selectedCategory.isEmpty {
                    let expense = Expense(category: selectedCategory, amount: amountDouble, date: date)
                    if !expenseManager.addExpense(expense) {
                        showAlert = true
                    }
                } else {
                    showAlert = true
                }
            }
            .alert(isPresented: $showAlert) {
                Alert(title: Text("Error"), message: Text("Invalid input or budget exceeded."), dismissButton: .default(Text("OK")))
            }
            .padding()
        }
        .navigationTitle("Add Expense")
    }
}
