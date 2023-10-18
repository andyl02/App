import SwiftUI

/// `BudgetTrackingView` is a SwiftUI view for tracking budgets.
///
/// This view displays the remaining budget for each category.
struct BudgetTrackingView: View {
    /// The environment object that manages the expenses.
    @EnvironmentObject var expenseManager: ExpenseManager

    /// The body of the `BudgetTrackingView`.
    var body: some View {
        NavigationView {
            List {
                ForEach(expenseManager.categories, id: \.self) { category in
                    HStack {
                        Text(category)
                        Spacer()
                        Text("$\(expenseManager.remainingBudget(for: category), specifier: "%.2f")")
                    }
                }
            }
            .navigationBarTitle("Budget Tracking")
            .onDisappear {
                expenseManager.saveContext()
            }
        }
    }
}
