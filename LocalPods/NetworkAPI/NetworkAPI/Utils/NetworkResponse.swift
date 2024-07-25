//
//  NetworkResponse.swift
//  NetworkAPI
//
//  Created by Иван Лукъянычев on 24.07.2024.
//

import Foundation

/// возвращение модели запроса и статуса кода
public struct NetworkResponse<Model: Decodable> {
    public let httpCode: Int
    public let data: Model?
}
