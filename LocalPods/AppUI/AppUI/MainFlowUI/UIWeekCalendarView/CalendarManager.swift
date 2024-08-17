//
//  CalendarManager.swift
//  AppUI
//
//  Created by Иван Лукъянычев on 17.08.2024.
//

import UIKit

class CalendarManager {
    
    /// Возвращает 10 дней до дня и 10 дней после
    /// - Parameters:
    ///   - date: центральный день на неделе
    func getWeekForCalendar(date: Date) -> [WeekCalendarDateModel] {
        var daysArray = [WeekCalendarDateModel]()
        for offset in -10...10 {
            let day = date.getDate(with: offset)
            daysArray.append(day.convertDateToModel())
        }
        return daysArray
    }
    
    /// Возвращает центральный день на текущей неделе
    /// - Parameter date: любой день на текущей неделе
    func getCenteredDate(with date: Date) -> Date {
        let numberOfWeekDay = date.getNumberOfWeekDay()
        let offset = 4 - numberOfWeekDay
        let centeredDate = date.getDate(with: offset)
        return centeredDate
    }
}


