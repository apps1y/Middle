//
//  NetworkUtils.swift
//  iOSApp
//
//  Created by Иван Лукъянычев on 16.07.2024.
//

import UIKit

public enum HTTPMethod: String {
    case get = "GET"
    case post = "POST"
    case put = "PUT"
    case delete = "DELETE"
    case patch = "PATCH"
}

public struct NetworkRequest {
    
    let baseUrl: String = "https://prodcontest-ios.ru"
    let queryParams: [String : String]
    let stringURL: String
    let httpMethod: HTTPMethod
    
    /// - Parameters:
    ///   - path: путь до эндпоинта без url
    ///   - queryParams: передаваемые параметры
    ///   - httpMethod: метод запроса
    public init(path: String, queryParams: [String : String], httpMethod: HTTPMethod) {
        self.queryParams = queryParams
        self.httpMethod = httpMethod
        self.stringURL = baseUrl + path
        
        
    }
}
