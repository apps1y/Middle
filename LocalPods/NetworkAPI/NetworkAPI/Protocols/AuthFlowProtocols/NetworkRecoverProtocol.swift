//
//  NetworkRecoverProtocol.swift
//  NetworkAPI
//
//  Created by Иван Лукъянычев on 24.07.2024.
//

import Foundation

// MARK: - sendCode
/// тело запроса sendCode
public struct SendCodeRequestModel: Encodable {
    public let email: String
}



// MARK: - confirmResert
/// тело запроса confirmResert
public struct ConfirmResertRequestModel: Encodable {
    public let code: String
    public let email: String
}

/// парсинг запроса confirmResert
public struct ConfirmResertResponseModel: Decodable {
    public let token: String
}



// MARK: - updatePassword
/// тело запроса updatePassword
public struct UpdatePasswordRequestModel: Encodable {
    public let password: String
}



// MARK: - Protocols
public protocol NetworkRecoverProtocol: AnyObject {
    
    /// Отправка кода на почту пользователя
    /// - Parameters:
    ///   - email: почта юзера
    ///   - completion: возвращает httpCode при success
    func sendCode(email: String, completion: @escaping (NResult<None>) -> Void)
    
    /// Подтверждение сброса пароля
    /// - Parameters:
    ///   - email: почта юзера
    ///   - completion: возвращает токен при success
    func confirmResert(email: String, code: String,
                       completion: @escaping (NResult<ConfirmResertResponseModel>) -> Void)
    
    
    func updatePassword(token: String, password: String,
                        completion: @escaping (NResult<None>) -> Void)
}
