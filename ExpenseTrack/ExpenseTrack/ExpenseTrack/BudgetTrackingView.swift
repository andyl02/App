// BudgetTrackingView.swift

import SwiftUI

struct BudgetTrackingView: View {
    @EnvironmentObject var expenseManager: ExpenseManager
    @State private var selectedCategory: String = ""
    @State private var budgetAmount: String = ""
    @State private var showAlert: Bool = false

    var body: some View {
        VStack {
            Form {
                Section(header: Text("Set Budget")) {
                    Picker("Category", selection: $selectedCategory) {
                        ForEach(expenseManager.categories, id: \.self) { category in
                            Text(category).tag(category)
                        }
                    }
                    TextField("Budget Amount", text: $budgetAmount)
                        .keyboardType(.decimalPad)
                    Button("Set Budget") {
                        if let amountDouble = Double(budgetAmount), !selectedCategory.isEmpty {
                            expenseManager.setBudget(for: selectedCategory, amount: amountDouble)
                            budgetAmount = ""
                        } else {
                            showAlert = true
                        }
                    }
                    .alert(isPresented: $showAlert) {
                        Alert(title: Text("Error"), message: Text("Invalid input."), dismissButton: .default(Text("OK")))
                    }
                }
                Section(header: Text("Existing Budgets")) {
                    ForEach(expenseManager.categories, id: \.self) { category in
                        HStack {
                            Text(category)
                            Spacer()
                            Text("\(expenseManager.getBudget(for: category), specifier: "%.2f")")
                        }
                    }
                }
            }
        }
        .navigationTitle("Budget Tracking")
    }
}
