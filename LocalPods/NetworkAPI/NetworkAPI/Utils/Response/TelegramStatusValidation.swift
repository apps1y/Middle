//
//  TelegramStatusValidation.swift
//  NetworkAPI
//
//  Created by Иван Лукъянычев on 17.08.2024.
//

import Foundation

public enum TelegramStatus {
    case sussess
    case invalidPassword
    case invalidCode
    case other
}

public class TelegramStatusValidation {
    public static func validate(stringStatus: String) -> TelegramStatus {
        if stringStatus == "SUCCESS" {
            return .sussess
        } else if stringStatus.contains("PHONE_CODE_INVALID") {
            return .invalidCode
        } else if stringStatus.contains("invalid password") || stringStatus.contains("password not defined") {
            return .invalidPassword
        } else {
            return .other
        }
    }
}
