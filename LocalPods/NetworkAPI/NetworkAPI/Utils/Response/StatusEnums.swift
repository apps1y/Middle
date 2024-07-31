//
//  NetworkResponseError.swift
//  NetworkAPI
//
//  Created by Иван Лукъянычев on 29.07.2024.
//

import Foundation

// MARK: success
enum Status200: String, CaseIterable {
    // PongStatus Response 200
    case PongStatus = "PONG"
    // AuthSentCode Response 200
    case AuthSentCode = "AUTH_SENT_CODE"
    // AuthConfirmed Response 200
    case AuthConfirmed = "AUTH_CONFIRMED"
    // Success Response 200
    case Success = "SUCCESS"
    
    static func withLabel(_ label: String) -> Status200? {
        return self.allCases.first{ $0.rawValue == label }
    }
}


/// 400, 401, 404
// MARK: logic errors
public enum Status400: String, CaseIterable {
    // уже существует Response 400
    case dataExists = "DATA_EXISTS"
    // уже подтвержден Response 400
    case alreadyConfirmed = "ALREADY_CONFIRMED"
    // не подтвержден Response 400
    case notConfirmed = "NOT_CONFIRMED"
    // InvalidJson Response 400
    case invalidJson = "INVALID_JSON"
    // InvalidEmail Response 400
    case invalidEmail = "INVALID_EMAIL"
    
    case invalidPassword = "INVALID_PASSWORD"
    
    // InvalidEmailCode Response 401
    case invalidEmailCode = "INVALID_EMAIL_CODE"
    // Unauthorized Response 401
    case unauthorized = "UNAUTHORIZED"
    
    // DbFetchError Response 404
    // данные не найдены
    case notFound = "NOT_FOUND"
    
    static func string(_ label: String) -> Status400? {
        return self.allCases.first{ $0.rawValue == label }
    }
    
    public var localizedDescription: String {
        switch self {
        case .dataExists:
            return "Такой аккаунт уже существует."
        case .alreadyConfirmed:
            return "Аккаунт уже подтвержден."
        case .notConfirmed:
            return "Аккаунт не подтвержден."
        case .invalidJson:
            return "Ошибка при запросе."
        case .invalidEmail:
            return "Неправильная почта."
        case .invalidEmailCode:
            return "Неверный код."
        case .unauthorized:
            return "Неверный пароль."
        case .notFound:
            return "Такого аккаунта не существует."
        case .invalidPassword:
            return "Пароль не соответствует критериям."
        }
    }
}


// MARK: internal error
enum Status500: String, CaseIterable {
    // HashingError Response 500
    case hashingError = "HASHING_ERROR"
    // EmailCheckError Response 500
    case emailCheckError = "EMAIL_CHECK_ERROR"
    // TokenSignError Response 500
    case tokenSignError = "TOKEN_SIGN_ERROR"
    // EmailSendError Response 500
    case emailSendError = "EMAIL_SEND_ERROR"
    // DbSaveError Response 500
    case dbSaveError = "DB_SAVE_ERROR"
    // DbRemoveError Response 500
    case dbRemoveError = "DB_REMOVE_ERROR"
    
    static func string(_ label: String) -> Status500? {
        return self.allCases.first{ $0.rawValue == label }
    }
    
    public var localizedDescription: String {
        switch self {
        case .hashingError:
            return "Ошибка при кэшировании."
        case .emailCheckError:
            return "Ошибка при проверки почты."
        case .tokenSignError:
            return "Ошибка при определении токена."
        case .emailSendError:
            return "Ошибка при отправке сообщения на почту."
        case .dbSaveError:
            return "Ошибка при созранении в базу данных."
        case .dbRemoveError:
            return "Ошибка при удалении из базы данных."
        }
    }
}
