//
//  NetworkConfirmProtocol.swift
//  NetworkAPI
//
//  Created by Иван Лукъянычев on 24.07.2024.
//

import Foundation

// MARK: - sendCode
/// тело запроса confirm
public struct ValidateAccountRequestModel: Encodable {
    public let code: String
}


// MARK: - checkEmail
/// тело запроса register
public struct CheckEmailRequestModel: Encodable {
    let email: String
}


// MARK: - Protocols
public protocol NetworkValidationProtocol: AnyObject {
    /// Отправка кода на почту пользователя
    /// - Parameters:
    ///   - email: почта юзера
    ///   - completion: возвращает httpCode при success
    func validateAccount(token: String, code: String, completion: @escaping (ShortResult<None>) -> Void)
    
    
    /// Проверка, есть ли пользователь с такой почтой в системе
    /// - Parameters:
    ///   - email: почта юзера
    ///   - completion: блок с моделью или текстовой ошибкой
    func checkEmail(email: String, completion: @escaping (ShortResult<None>) -> Void)
}
