//
//  RequestType.swift
//  ShareExtension
//
//  Created by Eric Lee on 11/12/23.
//

import Foundation

struct ExamRequest: Codable {
	var url: String
	
	init(url: String) {
		self.url = url
	}
}
