//
//  APIManager.swift
//  SeeReaURL
//
//  Created by Eric Lee on 11/11/23.
//

import Foundation
import Moya

protocol APIManager {
	
	func checkURL(url: String) async throws -> ExamResponse
	
}

final class DefaultAPIManager: APIManager {
	
	init() { }
	
	func checkURL(url: String) async throws -> ExamResponse {
		let request: [String: Any] = try ExamRequest(url: url).asDictionary()
		let response = try await APIService.request(
			target: APIService.getMainResult(parameter: request),
			dataType: ExamResponse.self)
		return response
	}
}

//사용법
//let apiManager = DefaultAPIManager()
//
//func fetchURLSafeData(url: String) {
//	Task {
//		do {
//			let response = try await apiManager.checkURL(url: String)
//			print("response : -------")
//			print("dddd : \(response)")
//			print("----------------------------------")
//		} catch {
//			
//		}
//	}
//}
