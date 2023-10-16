import Foundation
import CoreData

/// Represents a budget for a specific category.
public class Budget: NSManagedObject {
    
    /// The total amount allocated for this budget.
    @NSManaged public var amount: Double
        
    /// The category associated with this budget.
    @NSManaged public var category: String?
}

extension Budget {

    /// Fetches a budget request.
    static func fetchRequest() -> NSFetchRequest<Budget> {
        return NSFetchRequest<Budget>(entityName: "Budget")
    }
}
