//
//  FlexibleCalenderView.swift
//  FlexibleCalender
//
//  Created by Heshan Yodagama on 10/22/20.
//

import SwiftUI

public struct DateGrid<DateView>: View where DateView: View {
    
    /// DateStack view
    /// - Parameters:
    ///   - interval:
    ///   - selectedMonth: date relevent to showing month, then you can extract the componnets
    ///   - content:
    public init(interval: DateInterval, selectedMonth: Binding<Date>, mode: CalenderMode, @ViewBuilder content: @escaping (Date) -> DateView) {
        self.viewModel = .init(interval: interval, mode: mode)
        self._selectedMonth = selectedMonth
        self.content = content
    }
    
    //TODO: make Date generator class
    var viewModel: DateGridViewModel
    let content: (Date) -> DateView
    @Binding var selectedMonth: Date
    @State private var calculatedCellSize: CGSize = .init(width: 1, height: 1)
    
    public var body: some View {
        
        TabView(selection: $selectedMonth) {
            
            MonthsOrWeeks(viewModel: viewModel, calculatedCellSize: $calculatedCellSize, content: content)
        }
        .frame(height: tabViewHeight, alignment: .center)
        .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
    }
    
    //MARK: constant and supportive methods
    private let numberOfDayasInAWeek = 7
    private var tabViewHeight: CGFloat {
        let calculatedTabViewHeightByCalculatedCellHeight = viewModel.mode.calculatedheight(calculatedCellSize.height)
        return max(viewModel.mode.estimateHeight, calculatedTabViewHeightByCalculatedCellHeight)
    }
}

struct CalendarView_Previews: PreviewProvider {
    
    @State static var selectedMonthDate = Date()
    
    static var previews: some View {
        VStack {
            Text(selectedMonthDate.description)
            WeekDaySymbols()
            
            DateGrid(interval: .init(start: Date.getDate(from: "2020 01 11")!, end: Date.getDate(from: "2020 12 11")!), selectedMonth: $selectedMonthDate, mode: .month(estimateHeight: 400)) { date in
                
                NoramalDayCell(date: date)
            }
        }
        
    }
}


//Key
fileprivate struct MyPreferenceKey: PreferenceKey {
    static var defaultValue: MyPreferenceData = MyPreferenceData(size: CGSize.zero)
    
    
    static func reduce(value: inout MyPreferenceData, nextValue: () -> MyPreferenceData) {
        value = nextValue()
    }
    
    typealias Value = MyPreferenceData
}

//Value
fileprivate struct MyPreferenceData: Equatable {
    let size: CGSize
    //you can give any name to this variable as usual.
}

struct MonthsOrWeeks<DateView>: View where DateView: View {
    let viewModel: DateGridViewModel
    @Binding var calculatedCellSize: CGSize
    let content: (Date) -> DateView
    
    var body: some View {
        ForEach(viewModel.monthsOrWeeks, id: \.self) { monthOrWeek in
            
            VStack {
                
                LazyVGrid(columns: Array(repeating: GridItem(.flexible()), count: numberOfDayasInAWeek), spacing: 0) {
                    
                    ForEach(viewModel.days(for: monthOrWeek), id: \.self) { date in
                        if viewModel.calendar.isDate(date, equalTo: monthOrWeek, toGranularity: .month) {
                            content(date).id(date)
                                .background(
                                    GeometryReader(content: { (proxy: GeometryProxy) in
                                        Color.clear
                                            .preference(key: MyPreferenceKey.self, value: MyPreferenceData(size: proxy.size))
                                    }))
                            
                        } else {
                            content(date).hidden()
                        }
                    }
                }
                .onPreferenceChange(MyPreferenceKey.self, perform: { value in
                    calculatedCellSize = value.size
                })
                .tag(monthOrWeek)
                //Tab view frame alignment to .Top didnt work dtz y
                Spacer()
            }
        }
    }
    
    //MARK: constant and supportive methods
    private let numberOfDayasInAWeek = 7
}
