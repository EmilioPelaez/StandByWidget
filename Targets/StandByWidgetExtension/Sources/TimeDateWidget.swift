//
//  TimeDateWidget.swift
//  StandByWidgetExtension
//
//  Created by Emilio Peláez on 11/9/23.
//  Copyright © 2023 Emilio Peláez. All rights reserved.
//

import SwiftUI
import WidgetKit

struct TimeDateWidget: Widget {
	var body: some WidgetConfiguration {
		StaticConfiguration(kind: String(describing: type(of: self)), provider: Provider()) { entry in
			ContentView(date: .now)
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
			completion(.init(entries: [.init(date: .now)], policy: .atEnd))
		}
	}
}
