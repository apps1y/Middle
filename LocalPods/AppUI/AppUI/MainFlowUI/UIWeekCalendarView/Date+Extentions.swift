//
//  Date+Extentions.swift
//  AppUI
//
//  Created by Иван Лукъянычев on 17.08.2024.
//

import UIKit

extension Date {
    
    /// Прибавляет дни к текущему
    /// - Parameters:
    ///   - offset: кол-во дней до искомого дня
    func getDate(with offset: Int) -> Date {
        let offsetDate = Calendar.current.date(byAdding: .day, value: offset, to: self) ?? Date()
        return offsetDate
    }
    
    /// Конвертирует Date -> WeekCalendarDateModel
    func convertDateToModel() -> WeekCalendarDateModel {
        let calendar = Calendar.current
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "ru_RU")
        formatter.dateFormat = "EEEEEE"
        
        let numberOfDay = calendar.component(.day, from: self)
        let dayOfWeek = formatter.string(from: self)
        
        return WeekCalendarDateModel(numberOfDay: String(numberOfDay), dayOfWeek: dayOfWeek, monthName: getMonthFromDate(), dateString: dateFormatddMMyyyy(), date: self)
    }
    
    /// возвращает месяц из Date
    private func getMonthFromDate() -> String {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "ru_RU")
        formatter.dateFormat = "MMMM"
        let monthName = formatter.string(from: self)
        return monthName
    }
    
    /// возвращает формат ddMMyyyy из Date
    private func dateFormatddMMyyyy() -> String {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "ru_RU")
        formatter.dateFormat = "dd/MM/yyyy"
        let format = formatter.string(from: self)
        return format
    }
    
    /// возвращает номер дня недели ddMMyyyy из Date
    func getNumberOfWeekDay() -> Int {
        let calendar = Calendar.current
        let numberWeekOfDay = calendar.component(.weekday, from: self)
        return numberWeekOfDay - 1
        
    }
}

