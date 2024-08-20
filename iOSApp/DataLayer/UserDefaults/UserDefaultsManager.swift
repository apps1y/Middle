//
//  UserDefaultsManager.swift
//  iOSApp
//
//  Created by Иван Лукъянычев on 16.07.2024.
//

import Foundation

protocol UserDefaultsProtocol: AnyObject {
    
    /// выгрузка объекта
    /// - Parameter key: ключ объекта
    func fetch(key: String) -> String?
    
    /// создание объекта
    /// - Parameters:
    ///   - key: ключ объекта
    ///   - object: текст для сохранения
    func set(key: String, object: String)
    
    /// удаление объекта
    /// - Parameter key: ключ объекта
    func delete(key: String)
}

class UserDefaultsManager: UserDefaultsProtocol {
    
    private let defaults = UserDefaults.standard
    
    func fetch(key: String) -> String? {
        if let oblect = defaults.string(forKey: key) {
            return oblect
        }
        return nil
    }
    
    func set(key: String, object: String) {
        defaults.setValue(object, forKey: key)
    }
    
    func delete(key: String) {
        defaults.removeObject(forKey: key)
    }
}
