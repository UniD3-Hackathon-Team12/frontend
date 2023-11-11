//
//  ResponseType.swift
//  SeeReaURL
//
//  Created by Eric Lee on 11/11/23.
//

import Foundation

struct ExamResponse: Codable {
	var fraudPossibility: String?
}

// 조회수별 Account
struct AccountListResponse: Codable {
	let top5Accounts : [AccountResponse]?
}

struct URLListResponse: Codable {
	let top5Accounts : [AccountResponse]?
	let top5Urls: [CustomURLResponse]?
}

struct AccountResponse: Codable {
	let id: Int?
	let accountName: String?
	let isFraud: Bool?
	let view: Int?
	let report: Int?
}

struct CustomURLResponse: Codable {
	let id: Int?
	let url: String?
	let isFraud: Bool?
	let view: Int?
	let report: Int?
}

struct CheckAccountResponse: Codable {
	let response: String
}
