//
//  BudgetTrackingView.swift
//  ExpenseTrack
//


import SwiftUI

// BudgetTrackingView.swift

struct BudgetTrackingView: View {
    @EnvironmentObject var expenseManager: ExpenseManager
    @State private var budgets: [String: Double] = [:]
    
    var body: some View {
        VStack {
            List {
                ForEach(budgets.sorted(by: { $0.key < $1.key }), id: \.key) { category, amount in
                    HStack {
                        Text(category)
                            .font(.headline)
                        Spacer()
                        Text("\(amount, specifier: "%.2f")")
                            .font(.headline)
                    }
                }
            }
            .listStyle(InsetGroupedListStyle())
            
            Button(action: calculateBudgets) {
                Text("Calculate Budgets")
            }
            .padding()
        }
        .navigationTitle("Budget Tracking")
        .onAppear {
            calculateBudgets()
        }
    }
    
    private func calculateBudgets() {
        budgets = [:]
        
        for expense in expenseManager.expenses {
            if let currentAmount = budgets[expense.category] {
                budgets[expense.category] = currentAmount + expense.amount
            } else {
                budgets[expense.category] = expense.amount
            }
        }
    }
}
