//
//  NetworkRequest.swift
//  NetworkAPI
//
//  Created by Иван Лукъянычев on 24.07.2024.
//

import Foundation


/// сборщик всех данных для запроса
public struct NetworkRequest {
    
    /// const адрес сервера для запроса
    private let baseUrl: String = "https://defer-api.linuxfight.me"
    
    public let stringURL: String  /// строковый готовый URL
    
    public let headers: [String : String]  /// заголовки
    public let httpMethod: HTTPMethod  /// http метод отправки запроса
    
    public let bearer: String?
    
    
    /// - Parameters:
    ///   - stringURL: нужный эндпоинт (без адреса)
    ///   - headers: заголовки
    ///   - httpMethod: метод запроса
    ///   - bearer: токен для запроса пользователя, не обязательно указывать
    public init(stringURL: String, headers: [String : String], httpMethod: HTTPMethod, bearer: String? = nil) {
        self.stringURL = baseUrl + stringURL
        self.headers = headers
        self.httpMethod = httpMethod
        self.bearer = bearer
    }
}

