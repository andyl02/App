import SwiftUI

/// `DashboardView` is a SwiftUI view that displays a dashboard of the user's expenses.
///
/// This view displays a pie chart that shows the user's expenses by category. It also includes a button that navigates to the `ExpenseEntryView` for adding new expenses.
///
/// - Requires: `ExpenseManager` environment object.
struct DashboardView: View {
    /// An environment object that manages the user's expenses.
    @EnvironmentObject var expenseManager: ExpenseManager

    /// The body of the `DashboardView`.
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(alignment: .leading, spacing: 20) {
                    Text("Dashboard")
                        .font(.largeTitle)
                        .bold()
                        .padding(.top)
                    
                    // Pie Chart View
                    PieChartView(data: expenseManager.expensesByCategory)
                        .frame(height: 300)
                        .padding(.horizontal)
                    
                    // New Card Layout for Remaining Budgets
                    VStack {
                        Text("Remaining Budgets")
                            .font(.title2)
                            .bold()
                            .padding(.vertical, 10)
                        
                        ForEach(expenseManager.categories, id: \.self) { category in
                            let remainingBudget = expenseManager.remainingBudget(for: category)
                            BudgetCardView(category: category, remainingBudget: remainingBudget)
                        }
                    }
                    .padding(.horizontal)
                }
                .padding(.horizontal)
            }
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    NavigationLink(destination: ExpenseEntryView()) {
                        Image(systemName: "plus")
                    }
                }
            }
        }
    }
}

/// `BudgetCardView` is a SwiftUI view that displays the remaining budget for a category.
///
/// - Parameters:
///   - category: The category name.
///   - remainingBudget: The remaining budget for the category.
struct BudgetCardView: View {
    var category: String
    var remainingBudget: Double
    
    var body: some View {
        HStack {
            Text(category)
                .font(.headline)
            Spacer()
            Text("$\(remainingBudget, specifier: "%.2f")")
                .font(.title)
        }
        .padding()
        .background(Color.gray.opacity(0.2))
        .cornerRadius(10)
    }
}
