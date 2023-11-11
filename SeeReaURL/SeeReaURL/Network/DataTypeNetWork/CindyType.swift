//
//  CingyType.swift
//  SeeReaURL
//
//  Created by Eric Lee on 11/12/23.
//

import Foundation

enum validationImageName: String {
	case hide = "eye.trianglebadge.exclamationmark"
	case notOfficial = "exclamationmark.bubble.fill"
	case mask = "theatermasks.fill"
	case report = "light.beacon.max.fill"
	case other = "exclamationmark.triangle.fill"
}

struct WarningType {
	var imageName: validationImageName
	var content: String
}


struct urlSafeType {
	var isSafe: Bool
	var percent: Int
}
