//
//  NetworkServiceError.swift
//  NetworkAPI
//
//  Created by Иван Лукъянычев on 24.07.2024.
//

import Foundation

/// обработка ошибок при запросе
public enum NetworkServiceError: Error {
    case invalidURL
    case noResponse
    case httpError(statusCode: Int)
    case encodingError(error: Error)
    case parsingError(error: Error)
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
        case .encodingError(let error):
            return "Ошибка компиляции json из структуры: \(error.localizedDescription)."
        case .parsingError(let error):
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
