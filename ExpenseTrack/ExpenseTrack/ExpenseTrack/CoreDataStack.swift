import CoreData

class CoreDataStack {
    static let shared = CoreDataStack()

    private init() {}  // This prevents others from using the default '()' initializer

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

    var context: NSManagedObjectContext {
        return persistentContainer.viewContext
    }

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
}

