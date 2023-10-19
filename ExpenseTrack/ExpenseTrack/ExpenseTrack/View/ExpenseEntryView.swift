import SwiftUI

/// `ExpenseEntryView` is a SwiftUI view that allows the user to add new expenses.
///
/// This view provides input fields for the user to enter the expense amount, select a category, and add a note. It also includes a Save button to add the expense.
///
/// - Requires: `ExpenseManager` environment object.
struct ExpenseEntryView: View {
    /// An environment object that manages the user's expenses.
    @EnvironmentObject var expenseManager: ExpenseManager
    
    /// The amount of the new expense.
    @State private var amount: String = ""
    
    /// The category of the new expense.
    @State private var selectedCategory: String = ""
    
    /// A note for the new expense.
    @State private var note: String = ""
    
    /// State variable to control the display of the alert.
    @State private var showingAlert = false
    
    /// The body of the `ExpenseEntryView`.
    var body: some View {
        NavigationView {
            VStack {
                Text("Add Expense")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .padding(.bottom, 20)
                
                Form {
                    Section(header: Text("Expense Details").font(.headline)) {
                        HStack {
                            Image(systemName: "dollarsign.circle.fill")
                                .foregroundColor(.green)
                            TextField("Amount", text: $amount)
                                .keyboardType(.decimalPad)
                        }
                        
                        Picker("Category", selection: $selectedCategory) {
                            ForEach(expenseManager.categories, id: \.self) {
                                Text($0)
                            }
                        }
                        .pickerStyle(MenuPickerStyle())
                        
                        HStack {
                            Image(systemName: "pencil.circle.fill")
                                .foregroundColor(.blue)
                            TextField("Note (optional)", text: $note)
                        }
                    }
                }
                
                Button("Save") {
                    if let amountDouble = Double(amount), !selectedCategory.isEmpty {
                        expenseManager.addExpense(amount: amountDouble, category: selectedCategory, note: note)
                        showingAlert = true  // Show the alert
                    }
                }
                .font(.headline)
                .foregroundColor(.white)
                .padding()
                .background(Color.blue)
                .cornerRadius(10)
                .alert(isPresented: $showingAlert) {
                    Alert(title: Text("Expense Added"), message: Text("Your expense has been successfully added."), dismissButton: .default(Text("OK")))
                }
                .padding(.top, 20)
            }
            .padding()
        }
    }
}
