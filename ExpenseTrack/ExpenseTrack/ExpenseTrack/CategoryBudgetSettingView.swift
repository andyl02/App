//  CategoryBudgetSettingView.swift

import SwiftUI

struct CategoryBudgetSettingView: View {
    @EnvironmentObject var expenseManager: ExpenseManager
    @State private var budgetInputs: [String: String] = [:]
    @State private var showMessage: Bool = false

    var body: some View {
        NavigationView {
            List(expenseManager.categories, id: \.self) { category in
                HStack {
                    Text(category)
                    Spacer()
                    TextField("Budget", text: Binding(
                        get: { self.budgetInputs[category] ?? "" },
                        set: { self.budgetInputs[category] = $0 }
                    ))
                        .keyboardType(.decimalPad)
                        .frame(width: 100)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                }
            }
            .navigationTitle("Set Category Budgets")
            .navigationBarItems(trailing: Button("Save") {
                saveBudgets()
            })
            .alert(isPresented: $showMessage) {
                Alert(title: Text("Saved"), message: Text("Budgets have been successfully saved."), dismissButton: .default(Text("OK")))
            }
        }
    }

    func saveBudgets() {
        for (category, input) in budgetInputs {
            if let amount = Double(input) {
                expenseManager.setBudget(for: category, amount: amount)
            }
        }
        expenseManager.saveContext()  // Save the updated budgets to Core Data
        showMessage = true  // Show the success message
    }
}

