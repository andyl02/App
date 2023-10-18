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
    
    /// The body of the `CategoryBudgetSettingView`.
    var body: some View {
        NavigationView {
            List {
                ForEach(expenseManager.categories, id: \.self) { category in
                    HStack {
                        Text(category)
                        Spacer()
                        TextField("Budget", value: $tempBudgets[category], formatter: NumberFormatter())
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
                    }
                }
            }
        }
        .onAppear {
            tempBudgets = expenseManager.budgets
        }
    }
}
