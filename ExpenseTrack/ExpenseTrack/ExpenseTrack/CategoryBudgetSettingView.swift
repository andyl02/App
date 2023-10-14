//  CategoryBudgetSettingView.swift

import SwiftUI

struct CategoryBudgetSettingView: View {
    @EnvironmentObject var expenseManager: ExpenseManager
    @State private var budgetInputs: [String: String] = [:]

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
        }
    }

    func saveBudgets() {
        for (category, input) in budgetInputs {
            if let amount = Double(input) {
                expenseManager.setBudget(for: category, amount: amount)
            }
        }
    }
}
