//
//  Expense+CoreDataProperties.swift
//  ExpenseTrack
//
//  Created by Lili Duong on 15/10/2023.
//
//

import Foundation
import CoreData


extension Expense {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Expense> {
        return NSFetchRequest<Expense>(entityName: "Expense")
    }

    @NSManaged public var amount: Double
    @NSManaged public var category: String?
    @NSManaged public var date: Date?
    @NSManaged public var id: UUID?

}

extension Expense : Identifiable {

}
