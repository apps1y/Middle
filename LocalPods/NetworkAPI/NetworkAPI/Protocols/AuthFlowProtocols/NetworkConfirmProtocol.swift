//
//  NetworkConfirmProtocol.swift
//  NetworkAPI
//
//  Created by Иван Лукъянычев on 24.07.2024.
//

import Foundation

// MARK: - sendCode
/// тело запроса confirm
public struct ConfirmRequestModel: Encodable {
    public let code: String
}


// MARK: - Protocols
public protocol NetworkConfirmProtocol: AnyObject {
    /// Отправка кода на почту пользователя
    /// - Parameters:
    ///   - email: почта юзера
    ///   - completion: возвращает httpCode при success
    func confirm(token: String, code: String, completion: @escaping (NResult<None>) -> Void)
}
