//
//  KeychainProtocols.swift
//  iOSApp
//
//  Created by Иван Лукъянычев on 01.08.2024.
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
    func save(token: String)
    
    /// Извлечение ключа
    func getToken() -> String?
    
    /// Удаление ключа
    func clearToken()
}

/// информация о пробной подписки
protocol KeychainSubscriptionProtocol: AnyObject {
    
}
