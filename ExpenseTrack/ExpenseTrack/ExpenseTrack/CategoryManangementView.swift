import SwiftUI

struct CategoryManagementView: View {
    @EnvironmentObject var expenseManager: ExpenseManager
    @State private var newCategory = ""

    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Add New Category")) {
                    TextField("Category Name", text: $newCategory)
                    Button(action: addCategory) {
                        Text("Add")
                    }
                }

                Section(header: Text("Existing Categories")) {
                    ForEach(expenseManager.categories, id: \.self) { category in
                        Text(category)
                    }
                    .onDelete(perform: deleteCategory)
                }
            }
            .navigationBarTitle("Manage Categories", displayMode: .inline)
        }
    }

    private func addCategory() {
        expenseManager.addCategory(newCategory)
        newCategory = ""
    }

    private func deleteCategory(at offsets: IndexSet) {
        for index in offsets {
            expenseManager.deleteCategory(at: index)
        }
    }
}
