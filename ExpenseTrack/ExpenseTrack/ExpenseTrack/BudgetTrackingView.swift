import SwiftUI

struct BudgetTrackingView: View {
    @EnvironmentObject var expenseManager: ExpenseManager
    @State private var budget: Double = 1000.00  // Example initial budget
    @State private var editingBudget: String = "1000.00"

    var remainingBudget: Double {
        let totalExpenses = expenseManager.expenses.reduce(0) { $0 + $1.amount }
        return budget - totalExpenses
    }

    var body: some View {
        VStack {
            Text("Budget Tracking")
                .font(.largeTitle)
                .padding()

            HStack {
                Text("Set Budget:")
                TextField("$", text: $editingBudget, onCommit: {
                    if let newBudget = Double(editingBudget) {
                        budget = newBudget
                    }
                })
                .keyboardType(.decimalPad)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .frame(width: 100)
            }
            .padding()

            Text("Initial Budget: $\(budget, specifier: "%.2f")")
                .font(.title2)
                .padding()

            Text("Remaining Budget: $\(remainingBudget, specifier: "%.2f")")
                .font(.title2)
                .padding()

            // You can add more UI elements or sections here as needed
        }
        .padding()
    }
}

