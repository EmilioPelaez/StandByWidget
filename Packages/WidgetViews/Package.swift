// swift-tools-version: 5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
	name: "WidgetViews",
	platforms: [.iOS(.v17)],
	products: [
		.library(
			name: "WidgetViews",
			targets: ["WidgetViews"]),
	],
	targets: [
		.target(
			name: "WidgetViews"),
		.testTarget(
			name: "WidgetViewsTests",
			dependencies: ["WidgetViews"]),
	]
)
