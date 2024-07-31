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

final class StringsValidationManager: StringsValidationProtocol {
    func validate(password: String) -> String? {
        let minLengthRegex = "^.{8,}$"
        let maxLengthRegex = "^.{0,30}$"
        let lowercaseRegex = ".*[a-z]+.*"
        let uppercaseRegex = ".*[A-Z]+.*"
        let digitRegex = ".*\\d+.*"
        let specialCharRegex = ".*[#$@!%&*?]+.*"
        let allowedCharsRegex = "^[A-Za-z\\d#$@!%&*?]+$"

        if !NSPredicate(format: "SELF MATCHES %@", minLengthRegex).evaluate(with: password) {
            return "Пароль должен быть от 8 символов."
        }
        if !NSPredicate(format: "SELF MATCHES %@", maxLengthRegex).evaluate(with: password) {
            return "Пароль должен быть до 12 символов."
        }
        if !NSPredicate(format: "SELF MATCHES %@", lowercaseRegex).evaluate(with: password) {
            return "Хотя бы одна строчная буква."
        }
        if !NSPredicate(format: "SELF MATCHES %@", uppercaseRegex).evaluate(with: password) {
            return "Хотя бы одна заглавная буква."
        }
        if !NSPredicate(format: "SELF MATCHES %@", digitRegex).evaluate(with: password) {
            return "Хотя бы одна цифра."
        }
        if !NSPredicate(format: "SELF MATCHES %@", specialCharRegex).evaluate(with: password) {
            return "Хотя бы один спецсимвол из #$@!%&*?"
        }
        if !NSPredicate(format: "SELF MATCHES %@", allowedCharsRegex).evaluate(with: password) {
            return "Используйте только буквы, цифры и допустимые спецсимволы: #$@!%&*?"
        }

        return nil
    }
    
    func validate(email: String) -> String? {
        let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        let emailTest = NSPredicate(format: "SELF MATCHES %@", emailRegex)
        return emailTest.evaluate(with: email) ? nil : "Введите существующую почту."
    }
    
    func isValid(_ string: String) -> Bool {
        return !string.isEmpty && !string.contains(" ")
    }
}
