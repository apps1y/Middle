//
//  UserModel.swift
//  iOSApp
//
//  Created by Иван Лукъянычев on 13.08.2024.
//

import Foundation

/// моделька используется:
/// - для передачи данных в пределах модуля настроек
/// - в репозитории кэширования
/// - для показа данных на ячейке

/// модель юзера в приложении
/// - Parameters:
///   - email: почта
struct UserModel: Hashable {
    let email: String
}


