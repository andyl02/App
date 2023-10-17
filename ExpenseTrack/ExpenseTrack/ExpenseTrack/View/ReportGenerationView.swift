import SwiftUI

/// `ReportGenerationView` is a SwiftUI view for generating an expense report.
///
/// This view displays a summary of the user's expenses, including the total expenses, average expense, expenses by category, and recent expenses.
struct ReportGenerationView: View {
    /// The environment object that manages the expenses.
    @EnvironmentObject var expenseManager: ExpenseManager

    /// The body of the `ReportGenerationView`.
    var body: some View {
        ScrollView {
            VStack(alignment: .leading) {
                Text("Expense Report")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .padding(.bottom, 20)

                Text("Summary")
                    .font(.title2)
                    .fontWeight(.bold)
                    .padding(.vertical, 10)
                Text("Total Expenses: $\(self.expenseManager.expenses.reduce(0, { $0 + $1.amount }), specifier: "%.2f")")
                    .padding(.bottom, 5)
                Text("Average Expense: $\(self.expenseManager.expenses.isEmpty ? 0 : (self.expenseManager.expenses.reduce(0, { $0 + $1.amount }) / Double(self.expenseManager.expenses.count)), specifier: "%.2f")")
                    .padding(.bottom, 20)

                Text("Expenses by Category")
                    .font(.title2)
                    .fontWeight(.bold)
                    .padding(.vertical, 10)
                ForEach(self.expenseManager.categories, id: \.self) { category in
                    let total = self.expenseManager.totalForCategory(category)  // Make sure this method exists in ExpenseManager
                    Text("\(category): $\(total, specifier: "%.2f")")
                }
                .padding(.bottom, 20)

                Text("Recent Expenses")
                    .font(.title2)
                    .fontWeight(.bold)
                    .padding(.vertical, 10)
                ForEach(self.expenseManager.expenses.prefix(5)) { expense in
                    let formattedDate = expense.date != nil ? DateFormatter.shortDate.string(from: expense.date!) : "Unknown Date"
                    let category = expense.category ?? "Unknown Category"
                    Text("\(formattedDate): \(category) - $\(String(format: "%.2f", expense.amount))")
                }
                .padding(.bottom, 20)

                Spacer()
            }
            .padding()
        }
    }
}

/// `DateFormatter` extension that provides a short date formatter.
extension DateFormatter {
    static var shortDate: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        return formatter
    }
}

/// `ReportGenerationView_Previews` is a SwiftUI preview provider for the `ReportGenerationView`.
///
/// This struct generates a preview of the `ReportGenerationView`.
struct ReportGenerationView_Previews: PreviewProvider {
    static var previews: some View {
        ReportGenerationView().environmentObject(ExpenseManager())
    }
}
