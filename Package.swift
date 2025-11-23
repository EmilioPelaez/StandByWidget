// swift-tools-version: 5.9
import PackageDescription

#if TUIST
    import struct ProjectDescription.PackageSettings

    let packageSettings = PackageSettings(
        productTypes: [:]
    )
#endif

let package = Package(
    name: "StandBy",
    dependencies: [
        .package(path: "Packages/Shared"),
        .package(path: "Packages/WidgetViews"),
    ],
    targets: []
)
