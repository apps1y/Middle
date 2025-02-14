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
public struct ConfirmResertResponseModel: Decodable, Statusable {
    public var status: String
    public var token: String
    public var confirmed: Bool
}



// MARK: - updatePassword
/// тело запроса updatePassword
public struct UpdatePasswordRequestModel: Encodable {
    public let password: String
}

public struct UpdatePasswordResponseModel: Decodable, Statusable {
    public var status: String
    public var token: String
    public var confirmed: Bool
}



// MARK: - Protocols
public protocol NetworkRecoverProtocol: AnyObject {
    
    /// Отправка кода на почту пользователя
    /// - Parameters:
    ///   - email: почта юзера
    ///   - completion: возвращает httpCode при success
    func sendCode(email: String, completion: @escaping (ShortResult<None>) -> Void)
    
    /// Подтверждение сброса пароля
    /// - Parameters:
    ///   - email: почта юзера
    ///   - completion: возвращает токен при success
    func confirmResert(email: String, code: String,
                       completion: @escaping (ShortResult<ConfirmResertResponseModel>) -> Void)
    
    
    /// Установка нового пароля
    /// - Parameters:
    ///   - token: bearer token
    ///   - password: новый пароль
    ///   - completion: возвращает токен при success
    func updatePassword(token: String, password: String,
                        completion: @escaping (ShortResult<UpdatePasswordResponseModel>) -> Void)
}
