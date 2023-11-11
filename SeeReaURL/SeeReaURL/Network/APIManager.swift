//
//  APIManager.swift
//  SeeReaURL
//
//  Created by Eric Lee on 11/11/23.
//

import Foundation
import Moya

protocol APIManager {
	
	func getURLValidation(url: String) async throws -> (urlSafeType, [WarningType])
	
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
	
	func getURLValidation(url: String) async throws -> (urlSafeType, [WarningType]) {
		//구현 아직
		let request: [String: Any] = try URLRequestType(url: url).asDictionary()
		
		let response = try await APIService.request(target: APIService.getURLValidation(parameter: request), dataType: ExamResponse.self)
		
		var urlSafeType : urlSafeType = urlSafeType(isSafe: false, percent: 0)
		var warnTypes: [WarningType] = []
		
		
		if let content = response.fraudPossibility?.replacingOccurrences(of: "\\", with: "") {
			
			// 확률 가져오기
			let pattern = "\\b(\\d{1,2})\\."
			
			
			if let match = try NSRegularExpression(pattern: pattern, options: []).firstMatch(in: content, range: NSRange(location: 0, length: content.utf16.count)) {
				if let range = Range(match.range(at: 1), in: content) {
					let numberString = String(content[range])
					if let number = Int(numberString) {
						urlSafeType.percent = number
						
					}
				}
				
			}
			
			
			
			if content.contains("unsafe") {
				urlSafeType.isSafe = false
			} else if content.contains("safe") {
				urlSafeType.isSafe = true
			}
			
			if content.contains("등록 기간") {
				warnTypes.append(WarningType(imageName: .other, content: "등록기간이 짧은 링크입니다."))
			}
			
			if content.contains("카카오톡") {
				warnTypes.append(WarningType(imageName: .notOfficial, content: "공식 카카오 오픈 채팅방 링크가 아닙니다."))
			}
			
			if content.contains("네이버 밴드") {
				warnTypes.append(WarningType(imageName: .notOfficial, content: "네이버 공식 밴드 링크가 아닙니다. "))
			}
			
			if content.contains("사칭 계정") {
				warnTypes.append(WarningType(imageName: .mask, content: "사칭 계정으로 홍보되고 있는 링크입니다."))
			}
			
			if content.contains("신고") {
				warnTypes.append(WarningType(imageName: .mask, content: "위험 신고가 누적된 링크입니다."))
			}
			
		}
		
		
		return (urlSafeType, warnTypes)
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
