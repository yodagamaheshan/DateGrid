//
//  WeekDaySymbols.swift
//  FlexibleCalender
//
//  Created by Heshan Yodagama on 10/30/20.
//

import SwiftUI

public struct WeekDaySymbols: View {
    
    public init() {}
    
    public var body: some View {
        HStack {
            ForEach(Calendar.current.veryShortWeekdaySymbols, id: \.self) { item in
                Spacer()
                Text(item)
                    .bold()
                Spacer()
                
            }
        }
    }
}

struct WeekDaySymbols_Previews: PreviewProvider {
    static var previews: some View {
        WeekDaySymbols()
    }
}
