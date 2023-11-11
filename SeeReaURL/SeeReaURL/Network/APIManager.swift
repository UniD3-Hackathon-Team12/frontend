//
//  APIManager.swift
//  SeeReaURL
//
//  Created by Eric Lee on 11/11/23.
//

import Foundation
import Moya

protocol APIManager {
	
	func getURLValidation(url: String) async throws -> ExamResponse
	
	func getAccountValidation(accountName: String) async throws -> Bool
	
	func getHotAccounts() async throws -> [String]
	func getHotURLs() async throws -> [String]
	
	func postSave(url: String) async throws
	func postReport(url: String) async throws
	
}

final class DefaultAPIManager: APIManager {
	func getAccountValidation(accountName: String) async throws -> Bool {
		let request: [String: Any] = try AccountRequestType(accountName: accountName).asDictionary()
		let response = try await APIService.request(target: APIService.getAccountValidation(parameter: request), dataType: CheckAccountResponse.self)
		if response.response == "공식 계정이 아닙니다." {
			return false
		} else {
			return true
		}
	}
	
	func getURLValidation(url: String) async throws -> ExamResponse {
		//구현 아직
		return ExamResponse()
	}
	
	func getHotAccounts() async throws -> [String] {
		var returnAccounts: [String] = []
		let response = try await APIService.request(
			target: APIService.getHotAccounts,
					dataType: AccountListResponse.self)
		if let accounts = response.top5Accounts {
			for account in accounts {
				returnAccounts.append( account.accountName ?? "테스트계정")
			}
			
		}
		return returnAccounts
	}
	
	func getHotURLs() async throws -> [String] {
		var returnURLs: [String] = []
		let response = try await APIService.request(
			target: APIService.getHotURLs,
					dataType: URLListResponse.self)
		if let urls = response.top5Urls {
			for url in urls {
				returnURLs.append( url.url ?? "opel-kako")
			}
			
		}
		return returnURLs
	}
	
	func postSave(url: String) async throws {
		let request: [String: Any] = try URLRequestType(url: url).asDictionary()
		let response = try await APIService.request(target: APIService.postSave(parameter: request))
	}
	
	func postReport(url: String) async throws {
		let request: [String: Any] = try URLRequestType(url: url).asDictionary()
		let response = try await APIService.request(target: APIService.postReport(parameter: request))
	}
	
	init() { }
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
