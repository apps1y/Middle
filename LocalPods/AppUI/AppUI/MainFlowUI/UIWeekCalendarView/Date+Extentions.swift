//
//  Date+Extentions.swift
//  AppUI
//
//  Created by Иван Лукъянычев on 17.08.2024.
//

import UIKit

public enum DateSide {
    case left
    case right
    case normal
}

extension Date {
    
    /// Прибавляет дни к текущему
    /// - Parameters:
    ///   - offset: кол-во дней для прибавления к текущему
    public func getDate(with offset: Int) -> Date {
        let offsetDate = Calendar.current.date(byAdding: .day, value: offset, to: self) ?? Date()
        return offsetDate
    }
    
    /// Конвертирует Date -> WeekCalendarDateModel
    public func convertDateToModel() -> WeekCalendarDateModel {
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
    public func dateFormatddMMyyyy() -> String {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "ru_RU")
        formatter.dateFormat = "dd/MM/yyyy"
        let format = formatter.string(from: self)
        return format
    }
    
    /// возвращает месяц и год
    public func dateFormatLLLLyyyy() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "ru_RU")
        dateFormatter.dateFormat = "LLLL yyyy"
        let monthAndYear = dateFormatter.string(from: self)
        return monthAndYear
    }
    
    /// возвращает номер дня недели ddMMyyyy из Date
    func getNumberOfWeekDay() -> Int {
        let calendar = Calendar.current
        let numberWeekOfDay = calendar.component(.weekday, from: self) - 1
        return numberWeekOfDay == 0 ? 7 : numberWeekOfDay
        
    }
    
    public func isInDiapazon(from firstDate: Date, to secondDate: Date) -> DateSide {
        let calendar = Calendar.current
        
        let isMoreThanFirst = (
            calendar.compare(self, to: firstDate, toGranularity: .day) == .orderedDescending ||
            calendar.compare(self, to: firstDate, toGranularity: .day) == .orderedSame
        )
        
        let isLessThanSecond = (
            calendar.compare(self, to: secondDate, toGranularity: .day) == .orderedAscending ||
            calendar.compare(self, to: secondDate, toGranularity: .day) == .orderedSame
        )
        
        if isLessThanSecond && !isMoreThanFirst {
            return .left
        } else if !isLessThanSecond && isMoreThanFirst {
            return .right
        } else {
            return .normal
        }
    }
}

