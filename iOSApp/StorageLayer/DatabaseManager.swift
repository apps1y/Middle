//
//  PersistenceStorage.swift
//  iOSApp
//
//  Created by Иван Лукъянычев on 16.07.2024.
//

import UIKit

/// кеширование превьюшек сообщений
/// нужно при открытии
/// работа с базой данных
protocol DatabasePreviewsProtocol: AnyObject {
    
    /// подгрузка всех превью из кэша
    func fetch()
    
    /// удаление из кэша и добавление новых превью в кэш
    func update(with messages: [String])
}

/// кэширование деталей сообщений
protocol DatabaseDetailsProtocol: AnyObject {
    
    /// запрос на одно сообщение
    /// - Parameters:
    ///   - id: id сообщения
    func fetch(with id: String)
    
    /// очистить сообщение из списка
    /// - Parameters:
    ///   - id: id сообщения
    func remove(with id: String)
    
    /// сохранить сообщение
    // TODO: - заменить String на модельку сообщения
    /// - Parameters:
    ///   - message: в будущем моделька сообщения для хранения
    func save(message: String)
}

class DatabaseManager: DatabasePreviewsProtocol, DatabaseDetailsProtocol {
    func fetch() {
        
    }
    
    func update(with messages: [String]) {
        
    }
    
    func fetch(with id: String) {
        
    }
    
    func remove(with id: String) {
        
    }
    
    func save(message: String) {
        
    }
}
