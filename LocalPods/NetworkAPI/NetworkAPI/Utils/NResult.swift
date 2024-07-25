//
//  NetworkResult.swift
//  NetworkAPI
//
//  Created by Иван Лукъянычев on 24.07.2024.
//

import Foundation

/// `Result` с возвращением `String` в случае ошибки
public enum NResult<Result: Decodable> {
    
    /// A success, storing a `Decodable` value and httpCode `Int` value
    case success(data: Result?, httpCode: Int)
    
    /// A failure, storing a `String` value.
    case failure(String)
}


