import Foundation
import CoreData

/// An extension to add Core Data properties to the `Expense` class.
///
/// This extension adds properties for the amount, category, date, and unique identifier of an expense. It also adds a fetch request for `Expense` objects and conformance to the `Identifiable` protocol.
extension ExpenseTrack.Expense {
    
    /// Fetch request for `Expense` objects.
    /// - Returns: An `NSFetchRequest` for `Expense` objects.
    @nonobjc public class func fetchRequest() -> NSFetchRequest<ExpenseTrack.Expense> {
        return NSFetchRequest<ExpenseTrack.Expense>(entityName: "Expense")
    }
    
    /// The amount of the expense.
    @NSManaged public var amount: Double
    
    /// The category of the expense.
    @NSManaged public var category: String?
    
    /// The date the expense was made.
    @NSManaged public var date: Date?
    
    /// The unique identifier for the expense.
    @NSManaged public var id: UUID?
}

/// Conformance to `Identifiable` protocol.
extension ExpenseTrack.Expense : Identifiable {
    // Automatically conforms to `Identifiable` through `id` property.
}
