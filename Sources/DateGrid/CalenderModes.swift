//
//  CalenderModes.swift
//  FlexibleCalender
//
//  Created by Heshan Yodagama on 10/22/20.
//

import SwiftUI

public enum CalenderMode {
    case month(estimateHeight: CGFloat)
    case week(estimateHeight: CGFloat)
    
    var estimateHeight: CGFloat {
        switch self {
        case .month(estimateHeight: let estimateHeight):
            return estimateHeight
        case .week(estimateHeight: let estimateHeight):
            return estimateHeight
        }
    }
    
    func calculatedheight(_ cellHeight: CGFloat) -> CGFloat {
        switch self {
        case .month(estimateHeight: _):
            return cellHeight * 7
        case .week(estimateHeight: _):
            return cellHeight * 1
        }
    }
}
