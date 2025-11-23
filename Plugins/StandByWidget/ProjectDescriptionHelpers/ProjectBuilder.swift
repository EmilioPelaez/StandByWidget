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
	
	var infoPlist: [String: Plist.Value] {
		[
			"CFBundleShortVersionString": .string(version),
			"CFBundleVersion": .string(build),
		]
	}
	
	var settings: Settings {
		.settings(
			base: SettingsDictionary()
				.automaticCodeSigning(devTeam: developmentTeam),
			configurations: []
		)
	}
	
	public func makeAppTargets(name: String,
														 platform: Platform,
														 dependencies: [TargetDependency] = []) -> ProjectBuilder {
		let mainTarget = Target.target(
			name: name,
			destinations: [.iPhone, .iPad],
			product: .app,
			bundleId: bundleIDPrefix + name,
			infoPlist: .extendingDefault(with: infoPlist),
			sources: ["Targets/\(name)/Sources/**"],
			resources: ["Targets/\(name)/Resources/**"],
			dependencies: dependencies,
			settings: settings
		)
		
		let testTarget = Target.target(
			name: "\(name)Tests",
			destinations: [.iPhone, .iPad],
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
		
		let mainTarget = Target.target(
			name: name,
			destinations: [.iPhone, .iPad],
			product: .appExtension,
			bundleId: bundleIDPrefix + (idSuffix ?? name),
			infoPlist: .extendingDefault(with: infoPlist),
			sources: ["Targets/\(name)/Sources/**"],
			resources: ["Targets/\(name)/Resources/**"],
			dependencies: dependencies,
			settings: settings
		)
		
		let testTarget = Target.target(
			name: "\(name)Tests",
			destinations: [.iPhone, .iPad],
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
