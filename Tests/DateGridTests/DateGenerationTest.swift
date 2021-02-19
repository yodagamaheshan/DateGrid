
//  Created by Heshan Yodagama on 2021-02-19.
//

import XCTest
@testable import DateGrid

final class DateGenerationTest: XCTestCase {

    func testNumberOfWeeks() {
        let calendar = Calendar(identifier: .indian)
        var weeks = calendar.generateDates( inside: .init(start: Date.getDate(from: "2020 01 11")!, end: Date.getDate(from: "2020 01 12")!), matching: DateComponents(hour: 0, minute: 0, second:0, weekday: 2) )
        XCTAssertEqual(1, weeks.count)
    }
}
