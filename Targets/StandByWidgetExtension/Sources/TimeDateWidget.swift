//
//  TimeDateWidget.swift
//  StandByWidgetExtension
//
//  Created by Emilio Peláez on 11/9/23.
//  Copyright © 2023 Emilio Peláez. All rights reserved.
//

import Shared
import SwiftUI
import WidgetKit
import WidgetViews

struct TimeDateWidget: Widget {
	var body: some WidgetConfiguration {
		StaticConfiguration(kind: String(describing: type(of: self)), provider: Provider()) { entry in
			TimeDateWidgetView(date: entry.date)
		}
		.configurationDisplayName("Time and Date")
		.description("The current time and date!")
		.supportedFamilies([.systemSmall])
	}
}

extension TimeDateWidget {
	struct Provider: TimelineProvider {
		struct Entry: TimelineEntry {
			let date: Date
		}
		
		func placeholder(in context: Context) -> Entry {
			.init(date: .now)
		}
		
		func getSnapshot(in context: Context, completion: @escaping (Entry) -> Void) {
			completion(.init(date: .now))
		}
		
		func getTimeline(in context: Context, completion: @escaping (Timeline<Entry>) -> Void) {
			let initialDate = Date.now
			let previousMinute = initialDate.minuteStart
			let dates: [Date?] = [initialDate] + (0..<(60 * 5)).compactMap { previousMinute?.addingMinutes($0) }
			
			let entries = dates.compactMap { $0 }.map(Entry.init)
			
			completion(.init(entries: entries, policy: .atEnd))
		}
	}
}
