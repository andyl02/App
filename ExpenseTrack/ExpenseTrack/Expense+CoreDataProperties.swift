//  Expense+CoreDataProperties.swift

import Foundation
import CoreData


extension ExpenseTrack.Expense {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<ExpenseTrack.Expense> {
        return NSFetchRequest<ExpenseTrack.Expense>(entityName: "Expense")
    }

    @NSManaged public var amount: Double
    @NSManaged public var category: String?
    @NSManaged public var date: Date?
    @NSManaged public var id: UUID?

}

extension ExpenseTrack.Expense : Identifiable {

}
