import SwiftUI

/// `BudgetTrackingView` is a SwiftUI view that allows the user to track their budgets.
///
/// This view displays the budgets for each category and allows the user to update them.
///
/// - Requires: `ExpenseManager` environment object.
struct BudgetTrackingView: View {
    /// An environment object that manages the user's expenses.
    @EnvironmentObject var expenseManager: ExpenseManager
    
    /// The body of the `BudgetTrackingView`.
    var body: some View {
        NavigationView {
            List {
                ForEach(expenseManager.categories, id: \.self) { category in
                    HStack {
                        Text(category)
                        Spacer()
                        Text("$\(expenseManager.getBudget(for: category), specifier: "%.2f")")
                    }
                }
            }
            .navigationBarTitle("Budget Tracking", displayMode: .inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Save") {
                        expenseManager.saveBudgetsToCoreData()
                    }
                }
            }
        }
    }
}
