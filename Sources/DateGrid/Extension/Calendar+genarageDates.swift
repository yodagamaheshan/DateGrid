//
//  Calendar+genarageDates.swift
//  FlexibleCalender
//
//  Created by Heshan Yodagama on 10/25/20.
//

import Foundation

extension Calendar {
    func generateDates(inside interval: DateInterval, matching components: DateComponents) -> [Date] {
        var dates: [Date] = []
        
        dates.append(interval.start)
        
        enumerateDates(startingAfter: interval.start, matching: components, matchingPolicy: .nextTime) { date, _, stop in
            
            if let date = date {
                if date < interval.end {
                    dates.append(date)
                    
                } else {
                    stop = true
                }
            }
        }
        return dates
    }
}

