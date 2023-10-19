import SwiftUI

/// `CategoryManagementView` is a SwiftUI view for managing expense categories.
///
/// This view displays a list of existing expense categories and allows the user to add new categories or delete existing ones.
///
/// - Requires: `ExpenseManager` environment object.
struct CategoryManagementView: View {
    /// An environment object that manages the user's expenses.
    @EnvironmentObject var expenseManager: ExpenseManager
    
    /// The name of the new category that the user is currently inputting.
    @State private var newCategory: String = ""

    /// The body of the `CategoryManagementView`.
    var body: some View {
        NavigationView {
            VStack {
                List {
                    ForEach(expenseManager.categories, id: \.self) { category in
                        Text(category)
                            .font(.headline)
                            .padding(.vertical, 8)
                    }
                    .onDelete(perform: deleteCategory)
                }
                .listStyle(InsetGroupedListStyle())

                HStack {
                    TextField("New Category", text: $newCategory)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .padding(.horizontal, 16)
                    Button(action: addCategory) {
                        Text("Add")
                            .font(.headline)
                            .foregroundColor(.white)
                            .padding(.horizontal, 16)
                            .padding(.vertical, 8)
                            .background(Color.blue)
                            .cornerRadius(8)
                    }
                }
                .padding(.horizontal)
            }
            .navigationTitle("Manage Categories")
            .navigationBarItems(trailing: EditButton())
        }
    }

    /// Adds a new category to the `ExpenseManager`.
    ///
    /// This function checks if the `newCategory` string is not empty, and if it's not, it adds the new category to the `ExpenseManager` and resets the `newCategory` string.
    func addCategory() {
        if !newCategory.isEmpty {
            expenseManager.addCategory(newCategory)
            newCategory = ""
        }
    }

    /// Deletes a category from the `ExpenseManager`.
    ///
    /// - Parameter offsets: The indices of the categories to delete.
    func deleteCategory(at offsets: IndexSet) {
        expenseManager.deleteCategory(at: offsets)
    }
}
