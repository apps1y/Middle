//
//  WeekCalendarDateModel.swift
//  AppUI
//
//  Created by Иван Лукъянычев on 17.08.2024.
//

import Foundation

/// Структура дня
/// - Parameters:
///   - numberOfDay: число
///   - dayOfWeek: сокращенный день недели дня
///   - monthName: название месяца дня
///   - dateString: day/month/year
public struct WeekCalendarDateModel {
    public let numberOfDay: String
    public let dayOfWeek: String
    public let monthName: String
    public let dateString: String
    public let date: Date
}

