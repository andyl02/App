import SwiftUI

/// `ExpenseEntryView` is a SwiftUI view for entering a new expense.
struct ExpenseEntryView: View {
    /// An environment object that manages the user's expenses.
    @EnvironmentObject var expenseManager: ExpenseManager
    
    /// The amount of the new expense that the user is currently inputting.
    @State private var amount = ""
    
    /// The category of the new expense that the user is currently selecting.
    @State private var category = ""
    
    /// The date of the new expense that the user is currently selecting.
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
            let expense = Expense(context: expenseManager.coreDataStack.context)
            expense.category = category
            expense.amount = formattedAmount
            expense.date = date
            expense.id = UUID()
            expenseManager.expenses.append(expense)
            amount = ""
            category = ""
            date = Date()
        }
    }
}
