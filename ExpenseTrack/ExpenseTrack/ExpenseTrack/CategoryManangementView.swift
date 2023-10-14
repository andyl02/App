// CategoryManagementView.swift

import SwiftUI

struct CategoryManagementView: View {
    @EnvironmentObject var expenseManager: ExpenseManager
    @State private var newCategory: String = ""
    @State private var showAlert: Bool = false

    var body: some View {
        VStack {
            Form {
                Section(header: Text("Add New Category")) {
                    TextField("Category Name", text: $newCategory)
                    Button("Add") {
                        if !newCategory.isEmpty && !expenseManager.categories.contains(newCategory) {
                            expenseManager.addCategory(newCategory)
                            newCategory = ""
                        } else {
                            showAlert = true
                        }
                    }
                    .alert(isPresented: $showAlert) {
                        Alert(title: Text("Error"), message: Text("Invalid category name or category already exists."), dismissButton: .default(Text("OK")))
                    }
                }
                Section(header: Text("Existing Categories")) {
                    ForEach(expenseManager.categories, id: \.self) { category in
                        Text(category)
                    }
                    .onDelete { indexSet in
                        expenseManager.deleteCategories(at: indexSet)
                    }
                }
            }
        }
        .navigationTitle("Manage Categories")
    }
}
