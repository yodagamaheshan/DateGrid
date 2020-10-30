//
//  File.swift
//  
//
//  Created by Heshan Yodagama on 10/30/20.
//

import Foundation

struct DateGridDate {
    let date: Date
    let dateType: DateGridDateType
}

enum DateGridDateType {
    case inDate
    case monthDate
    case outDate
}
