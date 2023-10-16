import SwiftUI

/// `BudgetTrackingView` is a SwiftUI view for tracking a user's budget.
///
/// This view displays the user's initial budget, allows them to set a new budget, and shows the remaining budget after expenses.
///
/// - Requires: `ExpenseManager` environment object.
struct BudgetTrackingView: View {
    /// An environment object that manages the user's expenses.
    @EnvironmentObject var expenseManager: ExpenseManager
    
    /// The user's initial budget.
    @State private var budget: Double = 1000.00
    
    /// A string representation of the budget that the user is currently editing.
    @State private var editingBudget: String = "1000.00"

    /// The user's remaining budget after subtracting their total expenses.
    var remainingBudget: Double {
        let totalExpenses = expenseManager.expenses.reduce(0) { $0 + $1.amount }
        return budget - totalExpenses
    }

    /// The body of the `BudgetTrackingView`.
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

        }
        .padding()
    }
}
