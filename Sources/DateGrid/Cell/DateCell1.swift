//
//  DateCell1.swift
//  FlexibleCalender
//
//  Created by Heshan Yodagama on 10/25/20.
//

import SwiftUI

public struct DateCell1: View {
    
    public init(date: Date) {
        self.date = date
    }
    
    @State private var isShown = false
    private let date: Date
    
    public var body: some View {
        Group {
            if isShown {
                Text(date.day)
                    .padding(8)
                    .background(Color.purple)
                    .cornerRadius(20)
                    .padding(.bottom, 10)
                    .transition(AnyTransition.scale.animation(Animation.spring().delay(Double(date.day)!/30)))
                
            } else {
                Text("")
                    .onAppear(perform: {
                        withAnimation {
                            isShown = true
                        }
                    })
            }
        }
    }
}

struct DateCell1_Previews: PreviewProvider {
    static var previews: some View {
        DateCell1(date: Date())
            .background(Color.red)
    }
}
