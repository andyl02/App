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
    
    /// Function to get the appropriate icon for each category.
    func icon(for category: String) -> String {
        switch category {
        case "Food":
            return "cart.fill"
        case "Travel":
            return "airplane"
        case "Shopping":
            return "bag.fill"
        case "Utilities":
            return "house.fill"
        default:
            return "folder.fill"
        }
    }
    
    /// The body of the `CategoryBudgetSettingView`.
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(alignment: .leading, spacing: 20) {
                    ForEach(expenseManager.categories, id: \.self) { category in
                        HStack {
                            Image(systemName: icon(for: category))
                                .foregroundColor(.blue)
                            Text(category)
                                .font(.headline)
                            Spacer()
                            TextField("Budget", value: Binding(
                                get: { self.tempBudgets[category] ?? self.expenseManager.getBudget(for: category) },
                                set: { self.tempBudgets[category] = $0 }
                            ), formatter: NumberFormatter())
                            .keyboardType(.decimalPad)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            .padding(.horizontal)
                        }
                        .padding()
                        .background(Color.gray.opacity(0.1))
                        .cornerRadius(10)
                        .shadow(color: Color.black.opacity(0.1), radius: 5, x: 0, y: 2)
                    }
                }
                .padding()
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
                    .padding()
                    .foregroundColor(.white)
                    .background(Color.blue)
                    .cornerRadius(10)
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
