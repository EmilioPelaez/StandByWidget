import ProjectDescription

let localPackages = [
	"Shared",
	"WidgetViews",
]

let dependencies = Dependencies(
	swiftPackageManager: .init(localPackages.map { Package.local(path: "Packages/\($0)") }),
	platforms: [.iOS]
)
