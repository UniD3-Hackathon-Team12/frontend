//
//  RequestType.swift
//  SeeReaURL
//
//  Created by Eric Lee on 11/11/23.
//

import Foundation

struct ExamRequest: Codable {
	var url: String
	
	init(url: String) {
		self.url = url
	}
}
