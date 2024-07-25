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

public struct NetworkRequest<RequestModel: Encodable, ResponseModel: Decodable> {
    
    /// const адрес сервера для запроса
    private let baseUrl: String = "https://prodcontest-ios.ru"
    
    let stringURL: String  /// строковый готовый URL
    
    let headers: [String : String]  /// заголовки
    let httpMethod: HTTPMethod  /// http метод отправки запроса
    
    /// модели на запрос и парсинг
    var requestModel: RequestModel?
    var responseModel: ResponseModel?
    
    
    /// - Parameters:
    ///   - path: путь до эндпоинта без url
    ///   - queryParams: передаваемые параметры
    ///   - httpMethod: метод запроса
    init(stringURL: String, headers: [String : String], httpMethod: HTTPMethod, requestModel: RequestModel? = nil, responseModel: ResponseModel? = nil) {
        self.stringURL = stringURL
        self.headers = headers
        self.httpMethod = httpMethod
        self.requestModel = requestModel
        self.responseModel = responseModel
    }
}
