import SwiftUI

/// `CategoryBudgetSettingView` is a SwiftUI view for setting budgets for different expense categories.
///
/// This view displays a list of expense categories and allows the user to set a budget for each one. After the budgets are set, they are saved to Core Data.
///
/// - Requires: `ExpenseManager` environment object.
struct CategoryBudgetSettingView: View {
    /// An environment object that manages the user's expenses.
    @EnvironmentObject var expenseManager: ExpenseManager
    
    /// A dictionary that maps each category to the budget that the user has input.
    @State private var budgetInputs: [String: String] = [:]
    
    /// A Boolean value that determines whether a success message should be shown after the budgets are saved.
    @State private var showMessage: Bool = false

    /// The body of the `CategoryBudgetSettingView`.
    var body: some View {
        NavigationView {
            List(expenseManager.categories, id: \.self) { category in
                HStack {
                    Text(category)
                    Spacer()
                    TextField("Budget", text: Binding(
                        get: { self.budgetInputs[category] ?? "" },
                        set: { self.budgetInputs[category] = $0 }
                    ))
                        .keyboardType(.decimalPad)
                        .frame(width: 100)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                }
            }
            .navigationTitle("Set Category Budgets")
            .navigationBarItems(trailing: Button("Save") {
                saveBudgets()
            })
            .alert(isPresented: $showMessage) {
                Alert(title: Text("Saved"), message: Text("Budgets have been successfully saved."), dismissButton: .default(Text("OK")))
            }
        }
    }

    /// Saves the budgets that the user has input for each category.
    ///
    /// This function iterates over the `budgetInputs` dictionary and sets the budget for each category in the `ExpenseManager`. After all budgets are set, it saves the updated budgets to Core Data and shows a success message.
    func saveBudgets() {
        for (category, input) in budgetInputs {
            if let amount = Double(input) {
                expenseManager.setBudget(for: category, amount: amount)
            }
        }
        expenseManager.saveContext()  // Save the updated budgets to Core Data
        showMessage = true  // Show the success message
    }
}
