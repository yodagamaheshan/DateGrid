//
//  FlexibleCalendarView.swift
//  FlexibleCalender
//
//  Created by Heshan Yodagama on 10/22/20.
//

import SwiftUI

public struct DateGrid<DateView>: View where DateView: View {
    
    /// DateStack view
    /// - Parameters:
    ///   - interval:
    ///   - selectedMonth: date relevant to showing month, then you can extract the components
    ///   - content:
    public init(interval: DateInterval, selectedMonth: Binding<Date>, mode: CalendarMode, @ViewBuilder content: @escaping (DateGridDate) -> DateView) {
        self.viewModel = .init(interval: interval, mode: mode)
        self._selectedMonth = selectedMonth
        self.content = content
    }
    
    //TODO: make Date generator class
    private let viewModel: DateGridViewModel
    private let content: (DateGridDate) -> DateView
    @Binding var selectedMonth: Date
    
    public var body: some View {
        
        TabView(selection: $selectedMonth) {
            
            MonthsOrWeeks(viewModel: viewModel, content: content)
        }
        .frame(height: viewModel.mode.estimateHeight, alignment: .center)
        .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
    }
    
    //MARK: constant and supportive methods
}

struct CalendarView_Previews: PreviewProvider {
    
    @State static var selectedMonthDate = Date()
    
    static var previews: some View {
        VStack {
            Text(selectedMonthDate.description)
            WeekDaySymbols()
            
            DateGrid(interval: .init(start: Date.getDate(from: "2020 01 11")!, end: Date.getDate(from: "2020 12 11")!), selectedMonth: $selectedMonthDate, mode: .month(estimateHeight: 400)) { dateGridDate in
                
                NormalDayCell(date: dateGridDate.date)
            }
        }
        
    }
}

struct MonthsOrWeeks<DateView>: View where DateView: View {
    let viewModel: DateGridViewModel
    let content: (DateGridDate) -> DateView
    
    var body: some View {
        ForEach(viewModel.monthsOrWeeks, id: \.self) { monthOrWeek in
            
            VStack {
                
                LazyVGrid(columns: Array(repeating: GridItem(.flexible()), count: numberOfDaysInAWeek), spacing: 0) {
                    
                    ForEach(viewModel.days(for: monthOrWeek), id: \.self) { date in
                        let dateGridDate = DateGridDate(date: date, currentMonth: monthOrWeek)
                        if viewModel.calendar.isDate(date, equalTo: monthOrWeek, toGranularity: .month) {
                            content(dateGridDate)
                                .id(date)
                            
                        } else {
                            content(dateGridDate)
                                .hidden()
                        }
                    }
                }
                .tag(monthOrWeek)
                //Tab view frame alignment to .Top didn't work dtz y
                Spacer()
            }
        }
    }
    
    //MARK: constant and supportive methods
    private let numberOfDaysInAWeek = 7
}
