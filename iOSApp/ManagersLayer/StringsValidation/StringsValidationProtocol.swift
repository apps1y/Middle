//
//  StringsValidationProtocol.swift
//  iOSApp
//
//  Created by Иван Лукъянычев on 01.08.2024.
//

import Foundation

protocol StringsValidationProtocol {
    
    /// проверка пароля на достоверность
    /// - Parameters:
    ///   - password: пароль
    /// - Returns: строку с ошибкой
    func validate(password: String) -> String?
    
    /// проверка почты на достоверность
    /// - Parameters:
    ///   - email: почта
    /// - Returns: строку с ошибкой
    func validate(email: String) -> String?
    
    /// проверка строки на пробелы и пустоту
    /// - Parameters:
    ///   - line: любая строка
    /// - Returns : `true`, если строка не содержит пробелов и не пустая, иначе `false`.
    func isValid(_ string: String) -> Bool
}
