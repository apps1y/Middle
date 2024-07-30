//
//  NetworkResponse.swift
//  NetworkAPI
//
//  Created by Иван Лукъянычев on 24.07.2024.
//

import Foundation

/// протокол для валидации ошибок из статуса, который приходят с бека
public protocol Statusable {
    var status: String { get set }
}

/// возвращение модели запроса и статуса кода
public struct NetworkResponse<Model: Decodable> {
    public let httpCode: Int
    public let status: String
    public let data: Model?
}
