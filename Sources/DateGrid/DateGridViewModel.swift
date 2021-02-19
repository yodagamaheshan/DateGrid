//
//  FlexibleCalendarViewModel.swift
//  FlexibleCalender
//
//  Created by Heshan Yodagama on 10/25/20.
//

import SwiftUI

class DateGridViewModel: ObservableObject {
    //FIXME: change var names "mode"
    init(interval: DateInterval, mode: CalendarMode) {
        self.interval = interval
        self.mode = mode
    }
    
    @Environment(\.calendar) var calendar
    let interval: DateInterval
    var mode: CalendarMode
    
    //total dates belong to month(inDate+ outDate) or week
    var monthsOrWeeks: [Date] {
        switch mode {
        case .month(estimateHeight: _):
           return months
        case .week(estimateHeight: _):
           return weeks
        }
    }
    
    private var months: [Date] {
        calendar.generateDates( inside: interval,matching: DateComponents(day: 1, hour: 0, minute: 0, second:0))
    }
    
    private var weeks: [Date] {
        calendar.generateDates( inside: interval,matching: DateComponents(hour: 0, minute: 0, second:0, weekday: 2) )
    }
    
    func days(for monthOrWeek: Date) -> [Date] {
        switch mode {
        case .month(estimateHeight: _):
           return days(forMonth: monthOrWeek)
        case .week(estimateHeight: _):
           return days(forWeek: monthOrWeek)
        }
    }
    
    private func days(forMonth: Date) -> [Date] {
        guard
            let monthInterval = calendar.dateInterval(of: .month, for: forMonth),
            let monthFirstWeek = calendar.dateInterval(of: .weekOfMonth, for: monthInterval.start),
            let monthLastWeek = calendar.dateInterval(of: .weekOfMonth, for: monthInterval.end)
        else { return [] }
        return calendar.generateDates( inside: DateInterval(start: monthFirstWeek.start, end: monthLastWeek.end), matching: DateComponents(hour: 0, minute: 0, second: 0)
        )
    }
    
    //FIXME: change method signature to match above
    private func days(forWeek: Date) -> [Date] {
        guard
            let weekInterval = calendar.dateInterval(of: .weekOfMonth, for: forWeek)
        else { return [] }
        
        let days = calendar.generateDates( inside: DateInterval(start: weekInterval.start, end: weekInterval.end), matching: DateComponents(hour: 0, minute: 0, second: 0))
        return days
    }
}
