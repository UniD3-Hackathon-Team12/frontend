//
//  MoyaCacheablePlugin.swift
//  ShareExtension
//
//  Created by Eric Lee on 11/12/23.
//

import Foundation
import Moya

protocol MoyaCacheable {
	typealias MoyaCacheablePolicy = URLRequest.CachePolicy
	var cachePolicy: MoyaCacheablePolicy { get }
}

final class MoyaCacheablePlugin: PluginType {
	func prepare(_ request: URLRequest, target: TargetType) -> URLRequest {
		if let moyaCachableProtocol = target as? MoyaCacheable {
			var cachableRequest = request
			cachableRequest.cachePolicy = moyaCachableProtocol.cachePolicy
			return cachableRequest
		}
		return request
	}
}
