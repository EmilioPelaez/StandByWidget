//
//  Created by Emilio Peláez on 11/9/23.
//

import Foundation

public extension Date {
	var minuteStart: Date? {
		Calendar.current.date(bySetting: .second, value: 0, of: self)
	}
	
	var nextMinute: Date? {
		Calendar.current.date(byAdding: .minute, value: 1, to: self)
	}
	
	func addingMinutes(_ minutes: Int) -> Date? {
		Calendar.current.date(byAdding: .minute, value: minutes, to: self)
	}
}
