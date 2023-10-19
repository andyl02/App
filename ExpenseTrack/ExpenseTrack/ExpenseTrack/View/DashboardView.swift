import SwiftUI

/// A SwiftUI view that displays a dashboard of the user's expenses.
///
/// This view displays a pie chart that shows the user's expenses by category. It also includes a button that navigates to the `ExpenseEntryView` for adding new expenses.
///
/// ## Topics
/// - Requires: `ExpenseManager` environment object.
///
/// ## Overview
/// The `DashboardView` is the main view where the user can see an overview of their expenses. It includes a pie chart and a list of remaining budgets for each category.
///
/// ## Usage
/// ```swift
/// DashboardView().environmentObject(ExpenseManager())
/// ```
struct DashboardView: View {
    
    /// An environment object that manages the user's expenses.
    @EnvironmentObject var expenseManager: ExpenseManager

    /// The main body of the `DashboardView`.
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(alignment: .leading, spacing: 20) {
                    Text("Dashboard")
                        .font(.largeTitle)
                        .bold()
                        .padding(.top)
                        .padding(.horizontal)
                    
                    // Pie Chart View
                    PieChartView(data: expenseManager.expensesByCategory)
                        .frame(height: 600)
                        .padding(.horizontal)
                        .background(Color.white)
                        .cornerRadius(15)
                        .shadow(color: Color.black.opacity(0.2), radius: 7, x: 0, y: 2)
                        .padding(.bottom, 100)
                    
                    // Card Layout for Remaining Budgets
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
                    .background(Color.white)
                    .cornerRadius(15)
                    .shadow(color: Color.black.opacity(0.2), radius: 7, x: 0, y: 2)
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

/// A SwiftUI view that displays the remaining budget for a category.
///
/// ## Topics
/// - Parameters:
///   - category: The category name.
///   - remainingBudget: The remaining budget for the category.
///
/// ## Overview
/// The `BudgetCardView` is a simple card view that displays the remaining budget for a given category.
///
/// ## Usage
/// ```swift
/// BudgetCardView(category: "Food", remainingBudget: 100.0)
/// ```
struct BudgetCardView: View {
    var category: String
    var remainingBudget: Double
    
    /// The main body of the `BudgetCardView`.
    var body: some View {
        HStack {
            Text(category)
                .font(.headline)
            Spacer()
            Text("$\(remainingBudget, specifier: "%.2f")")
                .font(.title)
        }
        .padding()
        .background(Color.gray.opacity(0.1))
        .cornerRadius(10)
    }
}
