//
//  NetworkProfileProtocol.swift
//  NetworkAPI
//
//  Created by Иван Лукъянычев on 13.08.2024.
//

import Foundation

public struct ProfileResponseModel: Decodable, Statusable {
    
    public var status: String
    public var data: ProfoleData
    
    public struct ProfoleData: Decodable {
        public var confirmed: Bool
        public var created_at: String
        public var email: String
        public var updated_at: String
    }
}



public protocol NetworkProfileProtocol: AnyObject {
    
    /// Получение данных о пользователе
    /// - Parameters:
    ///   - token: bearer токен аккаунта
    ///   - completion: возвращает httpCode при success
    func profile(token: String, completion: @escaping (CompleteResult<ProfileResponseModel>) -> Void)
}
