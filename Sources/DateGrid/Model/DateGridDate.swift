//
//  File.swift
//  
//
//  Created by Heshan Yodagama on 10/30/20.
//

import Foundation

struct DateGridDate {
    init(date: Date, currentMonth: Date) {
        self.date = date
        self.currentMonth = currentMonth
    }
    
    let date: Date
    private var currentMonth: Date
    var dateType: DateGridDateType {
        getDateGridDateType(for: date, of: currentMonth)
    }
    
    private func getDateGridDateType(for date: Date, of month: Date) -> DateGridDateType {
        //TODO: implement
        return .monthDate
    }
}

enum DateGridDateType {
    case inDate
    case monthDate
    case outDate
}
