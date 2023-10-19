import SwiftUI

/// `ReportGenerationView` is a SwiftUI view for generating an expense report.
///
/// This view displays a summary of the user's expenses, including the total expenses, average expense, expenses by category, and recent expenses.
///
/// - Requires: `ExpenseManager` environment object.
struct ReportGenerationView: View {
    
    /// The environment object that manages the expenses.
    @EnvironmentObject var expenseManager: ExpenseManager
    
    /// The selected start date for filtering expenses.
    @State private var startDate: Date = Date().addingTimeInterval(-7*24*60*60) // One week ago
    
    /// The selected end date for filtering expenses.
    @State private var endDate: Date = Date() // Today

    /// The main body of the `ReportGenerationView`.
    var body: some View {
        ScrollView {
            VStack(alignment: .leading) {
                // Date Picker Section
                CardView(title: "Select Date Range") {
                    DatePicker("Start Date", selection: $startDate, displayedComponents: .date)
                    DatePicker("End Date", selection: $endDate, displayedComponents: .date)
                }
                
                // Summary Section
                CardView(title: "Summary") {
                    Text("Total Expenses: $\(expenseManager.expenses.reduce(0, { $0 + $1.amount }), specifier: "%.2f")")
                        .font(.headline)
                    
                    Text("Average Expense: $\(expenseManager.expenses.isEmpty ? 0 : (expenseManager.expenses.reduce(0, { $0 + $1.amount }) / Double(expenseManager.expenses.count)), specifier: "%.2f")")
                        .font(.headline)
                }

                // Expenses by Category Section
                CardView(title: "Expenses by Category") {
                    ForEach(expenseManager.categories, id: \.self) { category in
                        let total = expenseManager.totalForCategory(category)
                        Text("\(category): $\(total, specifier: "%.2f")")
                            .font(.headline)
                    }
                }

                // Recent Expenses Section
                CardView(title: "Recent Expenses") {
                    ForEach(expenseManager.expenses.prefix(5)) { expense in
                        let formattedDate = expense.date != nil ? DateFormatter.shortDate.string(from: expense.date!) : "Unknown Date"
                        let category = expense.category ?? "Unknown Category"
                        Text("\(formattedDate): \(category) - $\(String(format: "%.2f", expense.amount))")
                            .font(.headline)
                    }
                }
            }
            .padding()
        }
    }
}

/// `CardView` is a SwiftUI view that represents a card layout.
///
/// - Parameters:
///   - title: The title of the card.
///   - content: The content of the card.
struct CardView<Content: View>: View {
    var title: String
    var content: Content

    init(title: String, @ViewBuilder content: () -> Content) {
        self.title = title
        self.content = content()
    }

    var body: some View {
        VStack(alignment: .leading) {
            Text(title)
                .font(.title2)
                .fontWeight(.bold)
                .padding(.vertical, 10)
                .foregroundColor(.black)
            
            VStack(alignment: .leading, spacing: 10) {
                content
            }
            .padding()
            .background(Color.gray.opacity(0.1))
            .cornerRadius(10)
        }
        .padding(.bottom, 20)
        .background(Color.white)
        .cornerRadius(15)
        .shadow(color: Color.black.opacity(0.2), radius: 7, x: 0, y: 2)
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
