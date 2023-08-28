//
//  CategoryManangementView.swift
//  ExpenseTrack
//


import SwiftUI

struct CategoryManagementView: View {
    @EnvironmentObject var expenseManager: ExpenseManager
    @State private var newCategory: String = ""
    
    var body: some View {
        VStack {
            List {
                ForEach(expenseManager.expenses, id: \.id) { expense in
                    Text(expense.category)
                }
                .onDelete(perform: deleteExpense)
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
        expenseManager.addExpense(Expense(category: newCategory, amount: 0.0, date: Date()))
        newCategory = ""
    }
    
    private func deleteExpense(at offsets: IndexSet) {
        expenseManager.deleteExpense(at: offsets.first ?? 0)
    }
}

struct CategoryManagementView_Previews: PreviewProvider {
    static var previews: some View {
        CategoryManagementView()
    }
}
