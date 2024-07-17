//
//  NetworkAuthService.swift
//  iOSApp
//
//  Created by Иван Лукъянычев on 17.07.2024.
//

import Foundation

protocol NetworkAuthServiceProtocol: AnyObject {
    
    /// Вход пользователя
    /// - Parameters:
    ///   - mail: почта юзера
    ///   - password: пароль юзера
    func login(with mail: String, password: String, completion: @escaping (NetworkResult<AuthModel>) -> ())
}

extension NetworkService: NetworkAuthServiceProtocol {
    func login(with mail: String, password: String, completion: @escaping (NetworkResult<AuthModel>) -> ()) {
        
    }
}
