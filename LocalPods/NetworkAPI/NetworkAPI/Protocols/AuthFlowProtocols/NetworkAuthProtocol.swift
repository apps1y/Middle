//
//  NetworkAuthProtocol.swift
//  NetworkAPI
//
//  Created by Иван Лукъянычев on 24.07.2024.
//

import Foundation

// MARK: - login
/// тело запроса login
public struct LoginRequestModel: Encodable {
    public var email: String
    public var password: String
}

/// парсинг запроса login
public struct LoginResponseModel: Decodable, Statusable {
    public var confirmed: Bool
    public var status: String
    public var token: String
}


// MARK: - register
/// тело запроса register
public struct RegisterRequestModel: Encodable {
    public let email: String
    public let password: String
}

/// парсинг запроса register
public struct RegisterResponseModel: Decodable, Statusable {
    public var status: String
    public let confirmed: Bool
    public let token: String
}


// MARK: - Protocols
public protocol NetworkAuthProtocol: AnyObject {
    
    /// Вход пользователя
    /// - Parameters:
    ///   - email: почта юзера
    ///   - password: пароль юзера
    ///   - completion: блок с моделькой или текстовой ошибкой
    func login(email: String, password: String,
               completion: @escaping (ShortResult<LoginResponseModel>) -> Void)
    
    /// Регистрация пользователя
    /// - Parameters:
    ///   - email: почта юзера
    ///   - password: пароль юзера
    ///   - completion: блок с моделью или текстовой ошибкой
    func register(email: String, password: String,
                  completion: @escaping (ShortResult<RegisterResponseModel>) -> Void)
    
}
