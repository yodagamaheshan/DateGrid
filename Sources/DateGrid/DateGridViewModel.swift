//
//  FlexibleCalenderViewModel.swift
//  FlexibleCalender
//
//  Created by Heshan Yodagama on 10/25/20.
//

import SwiftUI

class DateGridViewModel {
    //Fixme: change var names "mode"
    init(interval: DateInterval, mode: CalenderMode) {
        self.interval = interval
        self.mode = mode
    }
    
    @Environment(\.calendar) var calendar
    let interval: DateInterval
    var mode: CalenderMode
    
    var months: [Date] {
        calendar.generateDates( inside: interval,matching: DateComponents(day: 1, hour: 0, minute: 0, second:0))
    }
    
    var weeks: [Date] {
        calendar.generateDates( inside: interval,matching: DateComponents(hour: 0, minute: 0, second:0, weekday: 2) )
    }
    
    func days(for month: Date) -> [Date] {
        guard
            let monthInterval = calendar.dateInterval(of: .month, for: month),
            let monthFirstWeek = calendar.dateInterval(of: .weekOfMonth, for: monthInterval.start),
            let monthLastWeek = calendar.dateInterval(of: .weekOfMonth, for: monthInterval.end)
        else { return [] }
        return calendar.generateDates( inside: DateInterval(start: monthFirstWeek.start, end: monthLastWeek.end), matching: DateComponents(hour: 0, minute: 0, second: 0)
        )
    }
    
    //fixme: change method signature to match aove
    func days(forWeek: Date) -> [Date] {
        guard
            let weekInterval = calendar.dateInterval(of: .weekOfMonth, for: forWeek)
        else { return [] }
        
        let days = calendar.generateDates( inside: DateInterval(start: weekInterval.start, end: weekInterval.end), matching: DateComponents(hour: 0, minute: 0, second: 0))
        return days
    }
}
