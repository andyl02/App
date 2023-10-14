// CategoryManagementView.swift

import SwiftUI

struct CategoryManagementView: View {
    @EnvironmentObject var expenseManager: ExpenseManager
    @State private var newCategory: String = ""
    
    var body: some View {
        VStack {
            List {
                ForEach($expenseManager.categories, id: \.self) { category in
                    Text(category)
                }
                .onDelete(perform: deleteCategory)
            }
            
            HStack {
                TextField("New Category", text: $newCategory)
                Button(action: addCategory) {
                    Text("Add")
                }
            }
            .padding()
        }
        .navigationTitle("Manage Categories")
    }
    
    private func addCategory() {
        $expenseManager.addCategory(newCategory)
        newCategory = ""
    }
    
    private func deleteCategory(at offsets: IndexSet) {
        $expenseManager.deleteCategory(at: offsets)
    }
}
