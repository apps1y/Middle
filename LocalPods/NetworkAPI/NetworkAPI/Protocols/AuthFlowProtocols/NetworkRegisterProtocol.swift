//
//  NetworkRegisterProtocol.swift
//  NetworkAPI
//
//  Created by Иван Лукъянычев on 24.07.2024.
//

import Foundation

// MARK: - register
/// тело запроса register
public struct RegisterRequestModel: Encodable {
    public let email: String
    public let password: String
}

/// парсинг запроса register
public struct RegisterResponseModel: Decodable, Statusable {
    public var status: String
    public let isActive: Bool
    public let token: String
}



// MARK: - checkEmail
/// тело запроса register
public struct CheckEmailRequestModel: Encodable {
    let email: String
}


// MARK: - Protocols
public protocol NetworkRegisterProtocol: AnyObject {
    
    /// Регистрация пользователя
    /// - Parameters:
    ///   - email: почта юзера
    ///   - password: пароль юзера
    ///   - completion: блок с моделью или текстовой ошибкой
    func register(email: String, password: String,
                  completion: @escaping (NResult<RegisterResponseModel>) -> Void)
    
    /// Проверка, есть ли пользователь с такой почтой в системе
    /// - Parameters:
    ///   - email: почта юзера
    ///   - completion: блок с моделью или текстовой ошибкой
    func checkEmail(email: String, completion: @escaping (NResult<None>) -> Void)
}
