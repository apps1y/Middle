//
//  StorageProtocol.swift
//  iOSApp
//
//  Created by Иван Лукъянычев on 06.08.2024.
//

import Foundation
import CoreData

protocol CoreDataProtocol: AnyObject {
        
    /// Извлекает модели из ДБ
    /// - Parameters:
    ///   - storedId: индификатор хранения
    ///   - convertClosure: блок для преобразования ДБ модели в обычную
    func fetch<Entity: NSManagedObject & EntityNamed, Model>(convertClosure: (Entity) -> Model) -> [Model]
    
    /// Вставляет модели в БД
    /// - Parameters:
    ///   - models: модели для сохранения
    ///   - convertClosure: блок для преобразования ДБ модели в обычную
    func insert<Model, Entity: NSManagedObject>(models: [Model], convertClosure: (Model, Entity) -> Void)
    
    /// Удаляет модели из БД
    /// - Parameters:
    ///   - models: модели для сохранения
    ///   - convertClosure: блок для преобразования ДБ модели в обычную
    func deleteAll<Entity: NSManagedObject & EntityNamed>(_ type: Entity.Type)
}
