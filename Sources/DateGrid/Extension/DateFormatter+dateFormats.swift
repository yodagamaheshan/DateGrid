//
//  DateFormatter+dateFormats.swift
//  FlexibleCalender
//
//  Created by Heshan Yodagama on 10/25/20.
//

import Foundation

extension DateFormatter {
    
    public static var month: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMMM"
        return formatter
    }
    
    public static var monthAndYear: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMMM yyyy"
        return formatter
    }
}

