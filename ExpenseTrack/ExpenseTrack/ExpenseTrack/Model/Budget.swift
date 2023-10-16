import Foundation
import CoreData

/// A class that represents a budget for a specific category in the Core Data store.
///
/// `Budget` is a subclass of `NSManagedObject` and represents a budget for a specific category in the Core Data store. It includes properties for the total amount allocated for the budget and the category associated with the budget.
public class Budget: NSManagedObject {
    
    /// The total amount allocated for this budget.
    @NSManaged public var amount: Double
        
    /// The category associated with this budget.
    @NSManaged public var category: String?
}

/// An extension to add a fetch request for `Budget` objects.
extension Budget {

    /// Fetches a budget request.
    static func fetchRequest() -> NSFetchRequest<Budget> {
        return NSFetchRequest<Budget>(entityName: "Budget")
    }
}
