import ProjectDescription
import ProjectDescriptionHelpers
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
	dependencies: [.target(name: extensionName)]
).makeAppExtensionTargets(
	name: extensionName,
	idSuffix: "StandByWidget.WidgetExtension",
	platform: .iOS,
	kind: .widgets)

let project = Project(
	name: "StandBy",
	organizationName: "Emilio Peláez",
	targets: builder.targets
)
