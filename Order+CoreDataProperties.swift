//
//  Order+CoreDataProperties.swift
//  PizzOrder
//
//  Created by Yann Durand on 24/09/2020.
//
//

import Foundation
import CoreData


extension Order {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Order> {
        return NSFetchRequest<Order>(entityName: "Order")
    }

    @NSManaged public var pizzaType: String
    @NSManaged public var numberOfSlices: Int16
    @NSManaged public var uuid: UUID?
    @NSManaged public var tableNumber: String
    @NSManaged public var status: String
    
    var orderStatus: Status {
        set {status = newValue.rawValue}
        get {Status(rawValue: status) ?? .pending}
    }
}

enum Status: String {
    case pending = "Pending"
    case preparing = "Preparing"
    case completed = "Completed"
}


extension Order : Identifiable {

}
