// ReportGenerationView.swift

import SwiftUI

struct ReportGenerationView: View {
    @EnvironmentObject var expenseManager: ExpenseManager

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
                    let total = self.expenseManager.totalForCategory(category)
                    Text("\(category): $\(total, specifier: "%.2f")")
                }
                .padding(.bottom, 20)

                Text("Recent Expenses")
                    .font(.title2)
                    .fontWeight(.bold)
                    .padding(.vertical, 10)
                ForEach(self.expenseManager.expenses.prefix(5)) { expense in
                    Text("\(expense.date, formatter: DateFormatter.shortDate): \(expense.category) - $\(expense.amount, specifier: "%.2f")")
                }
                .padding(.bottom, 20)

                Spacer()
            }
            .padding()
        }
    }
}

extension DateFormatter {
    static var shortDate: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        return formatter
    }
}

struct ReportGenerationView_Previews: PreviewProvider {
    static var previews: some View {
        ReportGenerationView()
    }
}

