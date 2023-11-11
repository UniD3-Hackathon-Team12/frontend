//
//  RequestType.swift
//  SeeReaURL
//
//  Created by Eric Lee on 11/11/23.
//

import Foundation

// URL 위험성 조사 parameter
struct URLRequestType: Codable {
	var url: String
	
	init(url: String) {
		self.url = url
	}
}

// 계정유효성
struct AccountRequestType: Codable {
	var accountName: String
	
	init(accountName: String) {
		self.accountName = accountName
	}
}

