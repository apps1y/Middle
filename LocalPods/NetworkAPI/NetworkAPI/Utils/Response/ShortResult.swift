//
//  AuthResult.swift
//  NetworkAPI
//
//  Created by Иван Лукъянычев on 05.08.2024.
//

import Foundation

/// `Result` с возвращением `String` в случае ошибки
public enum ShortResult<Result: Decodable> {
    
    /// A success 200, storing a `Result` model
    case success200(data: Result)
    
    /// A success (400, 401, 404), storing a `Status400` enum
    case success400(status: Status400)
    
    /// A failure, storing a `String` value.
    case failure(error: String)
}
