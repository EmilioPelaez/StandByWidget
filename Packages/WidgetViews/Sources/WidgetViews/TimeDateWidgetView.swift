//
//  TimeDateWidgetContentView.swift
//  StandByWidgetExtension
//
//  Created by Emilio Peláez on 11/9/23.
//  Copyright © 2023 Emilio Peláez. All rights reserved.
//

import SwiftUI
import WidgetKit

public struct TimeDateWidgetView: View {
	public let date: Date
	
	public init(date: Date) {
		self.date = date
	}
	
	public var body: some View {
		VStack(alignment: .leading) {
			Color.clear.overlay(alignment: .leading) {
				Text(date.formatted(date: .omitted, time: .shortened))
					.font(.system(size: 2000))
					.fontWeight(.medium)
					.minimumScaleFactor(0.01)
					.fontDesign(.rounded)
					.contentTransition(.numericText())
			}
			VStack(alignment: .leading) {
				Text(date.formatted(Date.FormatStyle().month(.wide)))
					.font(.body.smallCaps())
					.fontWeight(.semibold)
					.foregroundColor(.secondary)
				Text(date.formatted(Date.FormatStyle().weekday(.wide)))
					.font(.title3)
					.fontWeight(.medium)
					.foregroundColor(.red)
				Text(date.formatted(Date.FormatStyle().day(.defaultDigits)))
					.font(.largeTitle)
					.fontDesign(.rounded)
					.contentTransition(.numericText())
			}
		}
		.frame(maxWidth: .infinity, alignment: .center)
		.containerBackground(for: .widget) {
			Color.clear
		}
	}
}

#Preview {
	TimeDateWidgetView(date: .now)
}
