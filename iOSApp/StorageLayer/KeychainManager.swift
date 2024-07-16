//
//  KeychainManager.swift
//  iOSApp
//
//  Created by Иван Лукъянычев on 16.07.2024.
//

import Foundation

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

class KeychainManager: KeychainBearerProtocol, KeychainSubscriptionProtocol {
    func saveKey(_ value: String) {
        
    }
    
    func getKey() -> String? {
        return ""
    }
    
    func clearKey() {
        
    }
}
