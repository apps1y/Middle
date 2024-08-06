//
//  CoreDataService.swift
//  iOSApp
//
//  Created by Иван Лукъянычев on 06.08.2024.
//

import Foundation
import CoreData

final class CoreDataService: CoreDataProtocol {
    
    private let persistentContainer: NSPersistentContainer
    private var viewContext: NSManagedObjectContext {
        return persistentContainer.viewContext
    }
    
    init(persistentContainer: NSPersistentContainer) {
        self.persistentContainer = persistentContainer
    }
    
    convenience init() {
        let container = NSPersistentContainer(name: "iOSAppCoreData")
        container.loadPersistentStores(completionHandler: { _, _ in })
        self.init(persistentContainer: container)
    }
    
    func fetch<Entity: NSManagedObject, Model>(convertClosure: (Entity) -> Model) -> [Model] {
        var results: [Entity] = []
        viewContext.performAndWait {
            let fetchRequest = NSFetchRequest<Entity>()
            do {
                results = try fetchRequest.execute()
            } catch {
                print("fetch ERROR")
            }
        }
        return results.map(convertClosure)
    }
    
    func insert<Model, Entity: NSManagedObject>(models: [Model], convertClosure: (Model, Entity) -> Void) {
        viewContext.performAndWait {
            models.forEach { model in
                let entity = Entity(context: viewContext)
                convertClosure(model, entity)
            }
        }
        do {
            try viewContext.save()
        } catch {
            print("insert ERROR")
        }
    }
    
    func deleteAll<Entity: NSManagedObject>(_ type: Entity.Type) {
        viewContext.performAndWait {
            let fetchRequest = NSFetchRequest<Entity>()
            do {
                let results = try fetchRequest.execute()
                results.forEach { object in
                    viewContext.delete(object)
                }
                try viewContext.save()
            } catch {
                print("deleteAll ERROR")
            }
        }
    }
}
