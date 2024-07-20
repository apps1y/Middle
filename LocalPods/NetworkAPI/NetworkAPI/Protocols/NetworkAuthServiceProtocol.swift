//
//  NetworkAuthServiceProtocol.swift
//  NetworkAPI
//
//  Created by Иван Лукъянычев on 19.07.2024.
//

import Foundation

public protocol NetworkAuthServiceProtocol: AnyObject {
    
    /// Вход пользователя
    /// - Parameters:
    ///   - mail: почта юзера
    ///   - password: пароль юзера
    func login(with mail: String, password: String, completion: @escaping (Bool) -> Void)
}
