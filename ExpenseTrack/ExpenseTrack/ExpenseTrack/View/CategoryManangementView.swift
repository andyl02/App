// CategoryManagementView.swift

import SwiftUI

struct CategoryManagementView: View {
    @EnvironmentObject var expenseManager: ExpenseManager
    @State private var newCategory: String = ""

    var body: some View {
        NavigationView {
            VStack {
                List {
                    ForEach(expenseManager.categories, id: \.self) { category in
                        Text(category)
                    }
                    .onDelete(perform: deleteCategory)
                }

                HStack {
                    TextField("New Category", text: $newCategory)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                    Button(action: addCategory) {
                        Text("Add")
                    }
                }
                .padding()
            }
            .navigationTitle("Manage Categories")
        }
    }

    func addCategory() {
        if !newCategory.isEmpty {
            expenseManager.addCategory(newCategory)
            newCategory = ""
        }
    }

    func deleteCategory(at offsets: IndexSet) {
        expenseManager.deleteCategory(at: offsets)
    }
}
