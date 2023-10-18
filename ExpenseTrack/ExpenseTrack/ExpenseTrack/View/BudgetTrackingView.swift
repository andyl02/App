import SwiftUI

/// `BudgetTrackingView` is a SwiftUI view that allows the user to track budgets.
///
/// This view provides a list of categories and their corresponding budgets. The user can update the budget for each category and save the changes. The view also displays the remaining budget for each category.
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
                        Text(String(format: "%.2f", expenseManager.getBudget(for: category)))
                    }
                }
                .onDelete(perform: expenseManager.deleteCategory)
            }
            .navigationBarTitle("Budget Tracking")
            .navigationBarItems(trailing: Button("Save Budgets") {
                self.expenseManager.saveBudgetsToCoreData()  // Corrected method call
            })
        }
    }
}
