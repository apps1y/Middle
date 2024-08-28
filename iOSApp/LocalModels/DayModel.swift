//
//  DayModel.swift
//  iOSApp
//
//  Created by Иван Лукъянычев on 21.08.2024.
//

import Foundation

/// структура одного дня
/// - Parameters:
///   - messages: список сообщений
///   - date: дата дня
struct DayModel {
    let messages: [MessagePreviewModel]
    let date: Date
}
