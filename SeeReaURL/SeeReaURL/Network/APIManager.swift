//
//  APIManager.swift
//  SeeReaURL
//
//  Created by Eric Lee on 11/11/23.
//

import Foundation
import Moya

protocol APIManager {
	
	func checkURL() async throws -> ExamResponse
	
}

final class DefaultAPIManager: APIManager {
	
	init() { }
	
	func checkURL() async throws -> ExamResponse {
		let request: [String: Any] = try ExamRequest(url: "검사하고 싶은 URL").asDictionary()
		
		let response = try await APIService.request(
			target: APIService.getExamination(parameter: request),
			dataType: ExamResponse.self)
		
	return ExamResponse(isSafe: false)
	}
}
