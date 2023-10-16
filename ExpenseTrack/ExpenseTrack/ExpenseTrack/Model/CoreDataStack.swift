import CoreData

/// A class that manages the Core Data stack for the application.
///
/// `CoreDataStack` is a singleton that manages the Core Data stack for the application. It provides a persistent container for Core Data, a managed object context associated with the persistent container, and methods to save changes to the context and perform CRUD operations on expenses.
class CoreDataStack {
    
    /// Singleton instance of `CoreDataStack`.
    static let shared = CoreDataStack()
    
    /// Private initializer to enforce singleton pattern.
    private init() {}
    
    /// The persistent container for Core Data.
    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "ExpenseTrack")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                // Instead of crashing, print the error for debugging purposes
                print("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    /// The managed object context associated with the persistent container.
    var context: NSManagedObjectContext {
        return persistentContainer.viewContext
    }
    
    /// Saves any changes to the managed object context.
    func saveContext() {
        if context.hasChanges {
            do {
                // Ensure the context is saved on the main thread
                if Thread.isMainThread {
                    try context.save()
                } else {
                    DispatchQueue.main.sync {
                        try? context.save()
                    }
                }
            } catch {
                let nserror = error as NSError
                // Instead of crashing, print the error for debugging purposes
                print("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
    
    // MARK: - CRUD Operations
    
    /// Adds a new expense to the Core Data store.
    /// - Parameters:
    ///   - amount: The amount of the expense.
    ///   - category: The category of the expense.
    func addExpense(amount: Double, category: String) {
        let expense = Expense(context: context)
        expense.amount = amount
        expense.category = category
        saveContext()
    }
    
    /// Fetches all expenses from the Core Data store.
    /// - Returns: An array of `Expense` objects.
    func fetchExpenses() -> [Expense] {
        let fetchRequest = NSFetchRequest<Expense>(entityName: "Expense")
        
        do {
            let expenses = try context.fetch(fetchRequest)
            return expenses
        } catch {
            print("Failed to fetch expenses: \(error)")
            return []
        }
    }
    
    /// Updates an existing expense in the Core Data store.
    /// - Parameters:
    ///   - expense: The `Expense` object to update.
    ///   - newAmount: The new amount for the expense.
    ///   - newCategory: The new category for the expense.
    func updateExpense(expense: Expense, newAmount: Double, newCategory: String) {
        expense.amount = newAmount
        expense.category = newCategory
        saveContext()
    }
    
    /// Deletes an expense from the Core Data store.
    /// - Parameter expense: The `Expense` object to delete.
    func deleteExpense(expense: Expense) {
        context.delete(expense)
        saveContext()
    }
}
