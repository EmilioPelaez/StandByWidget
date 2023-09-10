//
//  ProjectBuilder.swift
//  ProjectDescriptionHelpers
//
//  Created by Emilio Peláez on 11/9/23.
//

import ProjectDescription

public struct ProjectBuilder {
	
	public let bundleIDPrefix: String
	public let version: String
	public let build: String
	
	public let targets: [Target]
	
	public init(bundleIDPrefix: String, version: String, build: String) {
		self.bundleIDPrefix = bundleIDPrefix
		self.version = version
		self.build = build
		self.targets = []
	}
	
	init(bundleIDPrefix: String, version: String, build: String, targets: [Target]) {
		self.bundleIDPrefix = bundleIDPrefix
		self.version = version
		self.build = build
		self.targets = targets
	}
	
	var infoPlist: [String: InfoPlist.Value] {
		[
			"CFBundleShortVersionString": .string(version),
			"CFBundleVersion": .string(build),
		]
	}
	
	public func makeAppTargets(name: String, platform: Platform, dependencies: [TargetDependency] = []) -> ProjectBuilder {
		let mainTarget = Target(
			name: name,
			platform: platform,
			product: .app,
			bundleId: bundleIDPrefix + name,
			infoPlist: .extendingDefault(with: infoPlist),
			sources: ["Targets/\(name)/Sources/**"],
			resources: ["Targets/\(name)/Resources/**"],
			dependencies: dependencies
		)
		
		let testTarget = Target(
			name: "\(name)Tests",
			platform: platform,
			product: .unitTests,
			bundleId: bundleIDPrefix + name + "Tests",
			infoPlist: .default,
			sources: ["Targets/\(name)/Tests/**"],
			dependencies: [
				.target(name: "\(name)")
			])
		
		return .init(bundleIDPrefix: bundleIDPrefix,
								 version: version,
								 build: build,
								 targets: targets + [mainTarget, testTarget])
	}
	
	public func makeAppExtensionTargets(name: String, platform: Platform, kind: AppExtensionKind, dependencies: [TargetDependency] = []) -> ProjectBuilder {
		var infoPlist = self.infoPlist
		infoPlist["NSExtension"] = .dictionary(["NSExtensionPointIdentifier": .string(kind.rawValue)])
		
		let mainTarget = Target(
			name: name,
			platform: platform,
			product: .appExtension,
			bundleId: bundleIDPrefix + name,
			infoPlist: .extendingDefault(with: infoPlist),
			sources: ["Targets/\(name)/Sources/**"],
			resources: ["Targets/\(name)/Resources/**"],
			dependencies: dependencies
		)
		
		let testTarget = Target(
			name: "\(name)Tests",
			platform: platform,
			product: .unitTests,
			bundleId: bundleIDPrefix + name + "Tests",
			infoPlist: .default,
			sources: ["Targets/\(name)/Tests/**"],
			dependencies: [
				.target(name: "\(name)")
			])
		
		return .init(bundleIDPrefix: bundleIDPrefix,
								 version: version,
								 build: build,
								 targets: targets + [mainTarget])
	}
	
}
