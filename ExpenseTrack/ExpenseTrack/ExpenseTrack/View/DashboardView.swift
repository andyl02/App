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
                        .onAppear {
                            print("Pie chart data: \(expenseManager.expensesByCategory)")  // Debug print
                        }
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
