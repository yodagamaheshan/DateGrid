//
//  Date+dateFormat.swift
//  FlexibleCalender
//
//  Created by Heshan Yodagama on 10/22/20.
//

import Foundation

extension Date {
    public var day: String {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "en_US_POSIX")
        formatter.dateFormat = "dd"
        return formatter.string(from: self)
    }
    
    public static func getDate(from dateString: String) -> Date? {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy MM dd"
        return formatter.date(from: dateString)
    }
}
