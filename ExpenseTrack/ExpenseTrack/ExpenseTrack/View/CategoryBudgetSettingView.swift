import SwiftUI

/// `CategoryBudgetSettingView` is a SwiftUI view that allows the user to set budgets for each category.
///
/// This view displays a list of categories and allows the user to set a budget for each one.
///
/// - Requires: `ExpenseManager` environment object.
struct CategoryBudgetSettingView: View {
    /// An environment object that manages the user's expenses.
    @EnvironmentObject var expenseManager: ExpenseManager
    
    /// A dictionary that holds the temporary budgets for each category.
    @State private var tempBudgets: [String: Double] = [:]
    
    /// A state variable to show an alert when the budget is saved.
    @State private var showingAlert = false
    
    /// The body of the `CategoryBudgetSettingView`.
    var body: some View {
        NavigationView {
            List {
                ForEach(expenseManager.categories, id: \.self) { category in
                    HStack {
                        Text(category)
                        Spacer()
                        TextField("Budget", value: Binding(
                            get: { self.tempBudgets[category] ?? self.expenseManager.getBudget(for: category) },
                            set: { self.tempBudgets[category] = $0 }
                        ), formatter: NumberFormatter())
                        .keyboardType(.decimalPad)
                    }
                }
            }
            .navigationBarTitle("Set Category Budget", displayMode: .inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Save") {
                        for (category, budget) in tempBudgets {
                            expenseManager.setBudget(for: category, amount: budget)
                        }
                        expenseManager.saveBudgetsToCoreData()
                        showingAlert = true // Show alert when the budget is saved
                    }
                }
            }
            .alert(isPresented: $showingAlert) {
                Alert(title: Text("Saved"), message: Text("Your budgets have been saved."), dismissButton: .default(Text("OK")))
            }
        }
        .onAppear {
            tempBudgets = expenseManager.budgets // Load budgets from Core Data
        }
    }
}
