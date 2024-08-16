//
//  TelegramAccount+CoreDataProperties.swift
//  
//
//  Created by Иван Лукъянычев on 06.08.2024.
//
//

import Foundation
import CoreData

protocol EntityNamed {
    static var entityName: String { get }
}


@objc(TelegramAccountStorage)
public class TelegramAccountStorage: NSManagedObject, EntityNamed {
    static var entityName: String = "TelegramAccountStorage"
}


extension TelegramAccountStorage {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<TelegramAccountStorage> {
        return NSFetchRequest<TelegramAccountStorage>(entityName: "TelegramAccountStorage")
    }

    @NSManaged public var name: String
    @NSManaged public var phone: String

}
