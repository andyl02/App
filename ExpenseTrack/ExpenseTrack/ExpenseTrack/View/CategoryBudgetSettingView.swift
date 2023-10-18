import SwiftUI

/// `CategoryBudgetSettingView` is a SwiftUI view for setting budgets for categories.
///
/// This view allows the user to set a budget for each category.
struct CategoryBudgetSettingView: View {
    /// The environment object that manages the expenses.
    @EnvironmentObject var expenseManager: ExpenseManager
    
    /// Local state to hold temporary budgets
    @State private var tempBudgets: [String: Double] = [:]

    /// The body of the `CategoryBudgetSettingView`.
    var body: some View {
        NavigationView {
            List {
                ForEach(expenseManager.categories, id: \.self) { category in
                    HStack {
                        Text(category)
                        Spacer()
                        TextField("Budget", value: Binding(
                            get: { self.tempBudgets[category, default: self.expenseManager.budgets[category, default: 0.0]] },
                            set: { self.tempBudgets[category] = $0 }
                        ), format: .number)
                            .keyboardType(.decimalPad)
                    }
                }
            }
            .navigationBarTitle("Set Category Budget")
            .onAppear {
                self.tempBudgets = expenseManager.budgets
            }
            .onDisappear {
                expenseManager.budgets = tempBudgets
                expenseManager.saveContext()
            }
        }
    }
}
