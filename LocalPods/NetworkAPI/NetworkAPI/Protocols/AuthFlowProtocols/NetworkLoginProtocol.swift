//
//  NetworkAuthProtocol.swift
//  NetworkAPI
//
//  Created by Иван Лукъянычев on 24.07.2024.
//

import Foundation

/// тело запроса
public struct LoginRequestModel: Encodable {
    let email: String
    let password: String
}

/// парсинг запроса
public struct LoginResponseModel: Decodable {
    let status: String
    let token: String
}

public protocol NetworkLoginProtocol: AnyObject {
    
    /// Вход пользователя
    /// - Parameters:
    ///   - email: почта юзера
    ///   - password: пароль юзера
    ///   - completion: блок с моделькой или текстовой ошибкой
    func login(email: String, password: String,
               completion: @escaping (NResult) -> Void)
    
}
