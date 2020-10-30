//
//  NoramalDayCell.swift
//  FlexibleCalender
//
//  Created by Heshan Yodagama on 10/30/20.
//

import SwiftUI

public struct NoramalDayCell: View {
    public init(date: Date) {
        self.date = date
    }
    
    private var date: Date
    public var body: some View {
        Text(date.day)
            .padding(8)
            .background(Color.blue)
            .cornerRadius(8)
            .padding([.bottom], 10)
    }
}

struct NoramalDayCell_Previews: PreviewProvider {
    static var previews: some View {
        NoramalDayCell(date: Date())
    }
}

