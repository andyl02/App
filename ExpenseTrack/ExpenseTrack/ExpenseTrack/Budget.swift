//  Budget.swift
import Foundation
import CoreData

public class Budget: NSManagedObject {
    @NSManaged public var amount: Double
    @NSManaged public var category: String?

}

extension Budget {
    static func fetchRequest() -> NSFetchRequest<Budget> {
        return NSFetchRequest<Budget>(entityName: "Budget")
    }
}
