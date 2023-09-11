// swift-tools-version: 5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
	name: "Shared",
	platforms: [.iOS(.v17)],
	products: [
		.library(
			name: "Shared",
			targets: ["Shared"]),
	],
	targets: [
		.target(
			name: "Shared"),
		.testTarget(
			name: "SharedTests",
			dependencies: ["Shared"]),
	]
)
