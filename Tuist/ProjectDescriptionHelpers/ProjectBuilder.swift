//
//  ProjectBuilder.swift
//  ProjectDescriptionHelpers
//
//  Created by Emilio Peláez on 11/9/23.
//

import ProjectDescription

public struct ProjectBuilder {
	
	public let developmentTeam: String
	public let bundleIDPrefix: String
	public let version: String
	public let build: String
	
	public private(set) var targets: [Target]
	
	public init(developmentTeam: String, bundleIDPrefix: String, version: String, build: String) {
		self.developmentTeam = developmentTeam
		self.bundleIDPrefix = bundleIDPrefix
		self.version = version
		self.build = build
		self.targets = []
	}
	
	var infoPlist: [String: InfoPlist.Value] {
		[
			"CFBundleShortVersionString": .string(version),
			"CFBundleVersion": .string(build),
		]
	}
	
	var settings: SettingsDictionary {
		SettingsDictionary()
			.automaticCodeSigning(devTeam: developmentTeam)
	}
	
	public func makeAppTargets(name: String,
														 platform: Platform,
														 dependencies: [TargetDependency] = []) -> ProjectBuilder {
		let mainTarget = Target(
			name: name,
			platform: platform,
			product: .app,
			bundleId: bundleIDPrefix + name,
			infoPlist: .extendingDefault(with: infoPlist),
			sources: ["Targets/\(name)/Sources/**"],
			resources: ["Targets/\(name)/Resources/**"],
			dependencies: dependencies,
			settings: .settings(base: settings, configurations: [])
		)
		
		let testTarget = Target(
			name: "\(name)Tests",
			platform: platform,
			product: .unitTests,
			bundleId: bundleIDPrefix + name + "Tests",
			infoPlist: .default,
			sources: ["Targets/\(name)/Tests/**"],
			dependencies: [.target(name: "\(name)")]
		)
		
		var copy = self
		copy.targets.append(contentsOf: [mainTarget, testTarget])
		return copy
	}
	
	public func makeAppExtensionTargets(name: String,
																			idSuffix: String? = nil,
																			platform: Platform,
																			kind: AppExtensionKind,
																			dependencies: [TargetDependency] = []) -> ProjectBuilder {
		var infoPlist = self.infoPlist
		infoPlist["NSExtension"] = .dictionary(["NSExtensionPointIdentifier": .string(kind.rawValue)])
		
		let mainTarget = Target(
			name: name,
			platform: platform,
			product: .appExtension,
			bundleId: bundleIDPrefix + (idSuffix ?? name),
			infoPlist: .extendingDefault(with: infoPlist),
			sources: ["Targets/\(name)/Sources/**"],
			resources: ["Targets/\(name)/Resources/**"],
			dependencies: dependencies,
			settings: .settings(base: settings, configurations: [])
		)
		
		let testTarget = Target(
			name: "\(name)Tests",
			platform: platform,
			product: .unitTests,
			bundleId: bundleIDPrefix + name + "Tests",
			infoPlist: .default,
			sources: ["Targets/\(name)/Tests/**"],
			dependencies: [.target(name: "\(name)")]
		)
		
		var copy = self
		copy.targets.append(contentsOf: [mainTarget])
		return copy
	}
	
}
