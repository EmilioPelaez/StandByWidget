import ProjectDescription
import ProjectDescriptionHelpers
import MyPlugin

/*
 +-------------+
 |             |
 |     App     | Contains StandByWidget App target and StandByWidget unit-test target
 |             |
 +------+-------------+-------+
 |         depends on         |
 |                            |
 +----v-----+                   +-----v-----+
 |          |                   |           |
 |   Kit    |                   |     UI    |   Two independent frameworks to share code and start modularising your app
 |          |                   |           |
 +----------+                   +-----------+
 
 */

// MARK: - Project


// Creates our project using a helper function defined in ProjectDescriptionHelpers

let builder = ProjectBuilder(
	bundleIDPrefix: "com.emiliopelaez.",
	version: "1.0",
	build: "1"
).makeAppTargets(
	name: "StandByWidget",
	platform: .iOS
).makeAppExtensionTargets(
	name: "StandByWidgetExtension",
	platform: .iOS,
	kind: .widgets)

let project = Project(
	name: "StandBy",
	organizationName: "Emilio Peláez",
	targets: builder.targets
)
