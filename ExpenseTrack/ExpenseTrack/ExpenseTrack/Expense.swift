import Foundation
import CoreData

@objc(Expense)
public class Expense: NSManagedObject, Identifiable {
    @NSManaged public var id: UUID?
    @NSManaged public var category: String
    @NSManaged public var amount: Double
    @NSManaged public var date: Date
}
