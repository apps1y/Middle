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
        func saveKey(_ value: String)
        
        /// Извлечение ключа
        func getKey() -> String?
        
        /// Удаление ключа
        func clearKey()
}

/// информация о пробной подписки
protocol KeychainSubscriptionProtocol: AnyObject {
    
}

final class KeychainManager {}

extension KeychainManager: KeychainBearerProtocol {
    func saveKey(_ value: String) {
        
    }
    
    func getKey() -> String? {
        ""
    }
    
    func clearKey() {
        
    }
}

extension KeychainManager: KeychainSubscriptionProtocol {
    
}
