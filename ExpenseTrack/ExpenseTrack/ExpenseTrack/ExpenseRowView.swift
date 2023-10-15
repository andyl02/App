// ExpenseRowView.swift

import SwiftUI

struct ExpenseRowView: View {
    var expense: Expense
    
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

struct ExpenseRowView_Previews: PreviewProvider {
    static var previews: some View {
        ExpenseRowView(expense: Expense())
    }
}

