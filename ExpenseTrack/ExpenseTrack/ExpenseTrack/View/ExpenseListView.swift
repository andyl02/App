import SwiftUI

/// `ExpenseListView` is a SwiftUI view that displays a list of expenses.
///
/// This view shows all the expenses that have been added, including their amounts, categories, and notes.
///
/// - Requires: `ExpenseManager` environment object.
struct ExpenseListView: View {
    /// An environment object that manages the user's expenses.
    @EnvironmentObject var expenseManager: ExpenseManager
    
    /// The body of the `ExpenseListView`.
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(alignment: .leading, spacing: 20) {
                    ForEach(expenseManager.expenses, id: \.self) { expense in
                        VStack(alignment: .leading, spacing: 10) {
                            HStack {
                                Image(systemName: "dollarsign.circle.fill")
                                    .foregroundColor(.green)
                                Text("Amount: $\(expense.amount, specifier: "%.2f")")
                                    .font(.headline)
                            }
                            
                            HStack {
                                Image(systemName: "folder.fill")
                                    .foregroundColor(.blue)
                                Text("Category: \(expense.category ?? "Unknown")")
                                    .font(.subheadline)
                            }
                            
                            if let note = expense.note, !note.isEmpty {
                                HStack {
                                    Image(systemName: "note.text")
                                        .foregroundColor(.orange)
                                    Text("Note: \(note)")
                                        .font(.subheadline)
                                }
                            }
                        }
                        .padding()
                        .background(Color.gray.opacity(0.1))
                        .cornerRadius(10)
                        .shadow(color: Color.black.opacity(0.1), radius: 5, x: 0, y: 2)
                    }
                }
                .padding()
            }
            .navigationBarTitle("Expenses", displayMode: .inline)
        }
    }
}
