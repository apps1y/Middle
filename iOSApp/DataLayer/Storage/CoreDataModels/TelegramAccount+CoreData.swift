//
//  TelegramAccount+CoreDataProperties.swift
//  
//
//  Created by Иван Лукъянычев on 06.08.2024.
//
//

import Foundation
import CoreData


@objc(TelegramAccount)
public class TelegramAccount: NSManagedObject {

}


extension TelegramAccount {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<TelegramAccount> {
        return NSFetchRequest<TelegramAccount>(entityName: "TelegramAccount")
    }

    @NSManaged public var name: String
    @NSManaged public var image: Data?

}
