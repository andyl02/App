import SwiftUI

struct ExpenseEntryView: View {
    @EnvironmentObject var expenseManager: ExpenseManager
    @State private var amount = ""
    @State private var category = ""
    @State private var date = Date()

    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Expense Details")) {
                    HStack {
                        Text("$")
                        TextField("Amount", text: $amount)
                            .keyboardType(.decimalPad)
                    }
                    Picker("Category", selection: $category) {
                        ForEach(expenseManager.categories, id: \.self) { category in
                            Text(category)
                        }
                    }
                    DatePicker("Date", selection: $date, displayedComponents: .date)
                }

                Button(action: addExpense) {
                    Text("Add Expense")
                }
            }
            .navigationBarTitle("New Expense", displayMode: .inline)
        }
    }

    private func addExpense() {
        if let amountDouble = Double(amount), !category.isEmpty {
            let formattedAmount = Double(String(format: "%.2f", amountDouble))!
            let expense = Expense(category: category, amount: formattedAmount, date: date)
            expenseManager.addExpense(expense)
            amount = ""
            category = ""
            date = Date()
        }
    }
}
