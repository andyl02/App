// DashboardView.swift

// DashboardView.swift

import SwiftUI

struct DashboardView: View {
    @EnvironmentObject var expenseManager: ExpenseManager

    var totalExpenses: Double {
        expenseManager.expenses.reduce(0) { $0 + $1.amount }
    }

    var body: some View {
        VStack {
            Text("Financial Overview")
                .font(.largeTitle)
                .padding()

            Text("Total Expenses: \(totalExpenses, specifier: "%.2f")")
                .font(.title2)
                .padding()

            PieChartView(data: expenseManager.expenses.map { $0.amount }, title: "Expenses Breakdown")
                .frame(height: 300)

            NavigationLink(destination: ExpenseEntryView()) {
                Text("Add New Expense")
                    .font(.title2)
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(10)
            }
            .padding(.top, 20)
        }
        .padding()
    }
}
