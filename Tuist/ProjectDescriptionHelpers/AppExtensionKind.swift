//
//  AppExtensionKind.swift
//  ProjectDescriptionHelpers
//
//  Created by Emilio Peláez on 11/9/23.
//

import ProjectDescription

public enum AppExtensionKind: String {
	case intents = "com.apple.intents-service"
	case intentsUI =	"com.apple.intents-ui-service"
	case notificationService = "com.apple.usernotifications.service"
	case widgets = "com.apple.widgetkit-extension"
}
