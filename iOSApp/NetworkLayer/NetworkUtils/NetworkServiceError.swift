//
//  NetworkServiceError.swift
//  iOSApp
//
//  Created by Иван Лукъянычев on 16.07.2024.
//

import Foundation

public enum NetworkServiceError: Error {
    case invalidURL
    case noResponse
    case httpError(statusCode: Int)
    case decodingError(error: Error)
    case unknown(error: Error)
    case noData
    case networkError(error: Error)
    case timeout
    
    var localizedDescription: String {
        switch self {
        case .invalidURL:
            return "Неверный URL."
        case .noResponse:
            return "Нет ответа от сервера."
        case .httpError(let statusCode):
            return "HTTP ошибка со статусом: \(statusCode)."
        case .decodingError(let error):
            return "Ошибка в парсинге запроса: \(error.localizedDescription)."
        case .unknown(let error):
            return "Неизвестная ошибка: \(error.localizedDescription)."
        case .noData:
            return "Сервер не прислал данные."
        case .networkError(let error):
            return "Произошла сетевая ошибка: \(error.localizedDescription)."
        case .timeout:
            return "Время выполнения запроса истекло."
        }
    }
}


public enum NetworkResult<Success> {
    
    /// A success, storing a `Success` value.
    case success(Success)
    
    /// A failure, storing a `Failure` value.
    case failure(String)
}
