//
//  KeychainManager.swift
//  iOSApp
//
//  Created by Иван Лукъянычев on 16.07.2024.
//

import Foundation

/// KeychainManager нужен в двух случаях:
///  - запись Bearer токена
///  - отслеживание пробной подписки
///
///  Записи Bearer токена доступна через AuthManager (авотматически меняется статус)

/// доступ к этим функциям только в AuthManager
protocol KeychainBearerProtocol: AnyObject {
    /// Сохранение ключа
    /// - Parameters:
    ///   - value: ключ для сохранения
    func saveKey(_ value: String)
    
    /// Извлечение ключа
    func getKey() -> String?
    
    /// Удаление ключа
    func clearKey()
}

/// информация о пробной подписки
protocol KeychainSubscriptionProtocol: AnyObject {
    
}

final class KeychainManager {
    private var string: String? = nil
}

extension KeychainManager: KeychainBearerProtocol {
    
    func saveKey(_ value: String) {
        string = value
    }
    
    func getKey() -> String? {
        string
    }
    
    func clearKey() {
        string = nil
    }
}

extension KeychainManager: KeychainSubscriptionProtocol {
    
}
