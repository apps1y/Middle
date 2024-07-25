//
//  NetworkRegisterProtocol.swift
//  NetworkAPI
//
//  Created by Иван Лукъянычев on 24.07.2024.
//

import Foundation

/// тело запроса
public struct RegisterRequestModel: Encodable {
    let email: String
    let password: String
}

/// парсинг запроса
public struct RegisterResponseModel: Decodable {
    let status: String
    let token: String
}

public protocol NetworkRegisterProtocol: AnyObject {
    
    /// Регистрация пользователя
    /// - Parameters:
    ///   - email: почта юзера
    ///   - password: пароль юзера
    ///   - completion: блок с моделью или текстовой ошибкой
    func register(email: String, password: String,
                  completion: @escaping (NResult) -> Void)
}
