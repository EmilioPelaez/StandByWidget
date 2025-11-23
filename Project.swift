import ProjectDescription
import MyPlugin

let appName = "StandByWidget"
let extensionName = "StandByWidgetExtension"

let builder = ProjectBuilder(
	developmentTeam: "FS696NSBK7",
	bundleIDPrefix: "com.emiliopelaez.",
	version: "1.0",
	build: "1"
).makeAppTargets(
	name: appName,
	platform: .iOS,
	dependencies: [
		.target(name: extensionName),
		.package(product: "Shared"),
	]
).makeAppExtensionTargets(
	name: extensionName,
	idSuffix: "StandByWidget.WidgetExtension",
	platform: .iOS,
	kind: .widgets,
	dependencies: [
		.package(product: "Shared"),
		.package(product: "WidgetViews"),
	]
)

let project = Project(
	name: "StandBy",
	organizationName: "Emilio Peláez",
	packages: [
		.local(path: "Packages/Shared"),
		.local(path: "Packages/WidgetViews"),
	],
	targets: builder.targets
)
