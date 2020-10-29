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
    
    var viewModel: DateGridViewModel
    let content: (Date) -> DateView
    @Binding var selectedMonth: Date
    @State private var calculatedCellSize: CGSize = .init(width: 1, height: 1)
    
    public var body: some View {
        
        Group {
            if case .month( _) = viewModel.mode {
                
                TabView(selection: $selectedMonth) {
                    
                    ForEach(viewModel.months, id: \.self) { month in
                        
                        VStack {
                            
                            LazyVGrid(columns: Array(repeating: GridItem(.flexible()), count: numberOfDayasInAWeek), spacing: 0) {
                                
                                ForEach(viewModel.days(for: month), id: \.self) { date in
                                    if viewModel.calendar.isDate(date, equalTo: month, toGranularity: .month) {
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
                            .tag(month)
                            //Tab view frame alignment to .Top didnt work dtz y
                            Spacer()
                        }
                    }
                }
                .frame(height: monthContentHeight, alignment: .center)
                .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
                
            } else {
                
                VStack {
                    
                    TabView(selection: $selectedMonth) {
                        
                        ForEach(viewModel.weeks, id: \.self) { week in
                            
                            LazyVGrid(columns: Array(repeating: GridItem(.flexible()), count: numberOfDayasInAWeek)) {
                                
                                ForEach(viewModel.days(forWeek: week), id: \.self) { date in
                                    if viewModel.calendar.isDate(date, equalTo: week, toGranularity: .month) {
                                        content(date).id(date)
                                            .background(
                                                GeometryReader(content: { (proxy: GeometryProxy) in
                                                    Color.clear
                                                        .preference(key: MyPreferenceKey.self, value: MyPreferenceData(size: proxy.size))
                                                }))
                                    } else {
                                        content(date)
                                            .opacity(0.5)
                                    }
                                }
                            }
                            .onPreferenceChange(MyPreferenceKey.self, perform: { value in
                                calculatedCellSize = value.size
                            })
                            .tag(week)
                        }
                    }
                    .frame(height: weekContentHeight, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                    .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
                }
            }
        }
    }
    
    //MARK: constant and supportive methods
    let numberOfDayasInAWeek = 7
    var monthContentHeight: CGFloat {
        return max(viewModel.mode.estimateHeight, calculatedCellSize.height * 6)
    }
    
    var weekContentHeight: CGFloat {
        return max(viewModel.mode.estimateHeight, calculatedCellSize.height * 1)
    }
}

struct CalendarView_Previews: PreviewProvider {
    
    @State static var selectedMonthDate = Date()
    
    static var previews: some View {
        VStack {
            Text(selectedMonthDate.description)
            HStack {
                ForEach(Calendar.current.veryShortWeekdaySymbols, id: \.self) { item in
                    Spacer()
                    Text(item)
                        .bold()
                    Spacer()
                    
                }
            }
            
            DateGrid(interval: .init(start: Date.getDate(from: "2020 01 11")!, end: Date.getDate(from: "2020 12 11")!), selectedMonth: $selectedMonthDate, mode: .month(estimateHeight: 400)) { date in
                
                Text(date.day)
                    .padding(8)
                    .background(Color.blue)
                    .cornerRadius(8)
                    .padding([.bottom], 10)
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
