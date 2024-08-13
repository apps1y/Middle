//
//  CompleteResult.swift
//  NetworkAPI
//
//  Created by Иван Лукъянычев on 13.08.2024.
//

import Foundation

/// `Result` с возвращением `String` в случае ошибки
public enum CompleteResult<Result: Decodable> {
    
    /// A success 200, storing a `Result` model
    case success200(data: Result)
    
    /// A success 401
    case unauthorized
    
    /// A success (400, 404), storing a `Status400` enum
    case success400(status: Status400)
    
    /// A failure, storing a `String` value.
    case failure(error: String)
}
