import SwiftUI

/// Represents a row view for displaying an expense.
struct ExpenseRowView: View {
    
    /// The expense to display.
    var expense: Expense
    
    /// The body of the expense row view.
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text(expense.category ?? "Unknown Category")
                    .font(.headline)
                Text(expense.date != nil ? DateFormatter.shortDate.string(from: expense.date!) : "Unknown Date")
                    .font(.subheadline)
            }
            
            Spacer()
            
            Text("$\(expense.amount, specifier: "%.2f")")
                .font(.headline)
        }
    }
}

/// Provides a preview of the expense row view.
struct ExpenseRowView_Previews: PreviewProvider {
    
    /// Generates a preview of the expense row view.
    static var previews: some View {
        ExpenseRowView(expense: Expense())
    }
}
