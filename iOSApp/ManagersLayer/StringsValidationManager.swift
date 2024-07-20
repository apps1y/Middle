//
//  StringsValidationManager.swift
//  iOSApp
//
//  Created by Иван Лукъянычев on 16.07.2024.
//

import Foundation

protocol StringsValidationProtocol {
    
    /// проверка пароля на достоверность
    /// - Parameters:
    ///   - password: пароль
    func validate(password: String) -> String?
    
    /// проверка почты на достоверность
    /// - Parameters:
    ///   - email: почта
    func validate(email: String) -> String?
}

class StringsValidationManager: StringsValidationProtocol {
    func validate(password: String) -> String? {
        /// проверка на длину не меньше 6
        guard password.count >= 6  else {
            return "Пароль должен быть от 6 знаков."
        }
        
        /// проверка на длину не больше 12
        guard password.count <= 12 else {
            return "Пароль должен быть до 12 знаков."
        }
        
        /// Проверка на наличие хотя бы одной буквы
        let containsLetterRegex = ".*[A-Za-z]+.*"
        let containsLetterTest = NSPredicate(format: "SELF MATCHES %@", containsLetterRegex)
        if !containsLetterTest.evaluate(with: password) {
            return "Должна быть хотя бы одна букву."
        }
        
        /// Проверка на наличие хотя бы одной цифры
        let containsDigitRegex = ".*\\d+.*"
        let containsDigitTest = NSPredicate(format: "SELF MATCHES %@", containsDigitRegex)
        if !containsDigitTest.evaluate(with: password) {
            return "Должна быть хотя бы одна цифра."
        }
        
        /// Проверка на отсутствие пробелов
        let containsWhitespaceRegex = ".*\\s+.*"
        let containsWhitespaceTest = NSPredicate(format: "SELF MATCHES %@", containsWhitespaceRegex)
        if containsWhitespaceTest.evaluate(with: password) {
            return "Не должны быть пробелы."
        }
        
        /// Проверка на допустимые символы (буквы и цифры)
        let validCharactersRegex = "^[A-Za-z\\d]+$"
        let validCharactersTest = NSPredicate(format: "SELF MATCHES %@", validCharactersRegex)
        if !validCharactersTest.evaluate(with: password) {
            return "Используйте только буквы и цифры."
        }
        
        return nil
    }
    
    func validate(email: String) -> String? {
        let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        let emailTest = NSPredicate(format: "SELF MATCHES %@", emailRegex)
        return emailTest.evaluate(with: email) ? nil : "Введите настоящую почту."
    }
    
}
