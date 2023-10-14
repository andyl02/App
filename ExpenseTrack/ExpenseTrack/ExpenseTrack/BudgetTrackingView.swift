// BudgetTrackingView.swift

import SwiftUI

struct BudgetTrackingView: View {
    @EnvironmentObject var expenseManager: ExpenseManager
    @State private var selectedCategory: String = ""
    @State private var budgetAmount: Double = 0.0
    
    var body: some View {
        VStack {
            List {
                ForEach(expenseManager.categories, id: \.self) { category in
                    HStack {
                        Text(category)
                        Spacer()
                        Text("\(expenseManager.getBudget(for: category) ?? 0.0, specifier: "%.2f")")
                    }
                }
            }
            
            Picker("Category", selection: $selectedCategory) {
                ForEach(expenseManager.categories, id: \.self) { category in
                    Text(category).tag(category)
                }
            }
            .padding()
            
            TextField("Budget Amount", value: $budgetAmount, format: .currency(code: Locale.current.currency?.identifier ?? ""))
            .padding()
            
            Button(action: setBudget) {
                Text("Set Budget")
            }
            .padding()
        }
        .navigationTitle("Budget Tracking")
    }
    
    private func setBudget() {
        expenseManager.setBudget(for: selectedCategory, amount: budgetAmount)
    }
}
