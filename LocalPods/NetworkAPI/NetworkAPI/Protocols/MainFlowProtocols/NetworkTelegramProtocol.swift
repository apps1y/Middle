//
//  NetworkTelegramProtocol.swift
//  NetworkAPI
//
//  Created by Иван Лукъянычев on 13.08.2024.
//

import Foundation

// MARK: - getUserTelegramSessions
// response
public struct UserSessionsResponseModel: Statusable, Decodable {
    public var Sessions: [UserTelegramSession]?
    public var status: String
    
    public struct UserTelegramSession: Decodable {
        public var name: String
        public var phone: String
    }
}

// MARK: - universal request model
// request
public struct TelegramRequestModel: Encodable {
    public let code: String
    public let password: String
    public let phone_number: String
}

public protocol NetworkTelegramProtocol: AnyObject {
    func getUserTelegramSessions(token: String, completion: @escaping (CompleteResult<UserSessionsResponseModel>) -> Void)
    
    func addTelegramAccount(token: String, code: String, password: String, phoneNumber: String, completion: @escaping (CompleteResult<None>) -> Void)
    
    func removeTelegramSession(token: String, phoneNumber: String, completion: @escaping (CompleteResult<None>) -> Void)
    
    func sendTelegramCode(token: String, phoneNumber: String, completion: @escaping (CompleteResult<None>) -> Void)
}
