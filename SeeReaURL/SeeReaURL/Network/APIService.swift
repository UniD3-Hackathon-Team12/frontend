//
//  APIService.swift
//  SeeReaURL
//
//  Created by Eric Lee on 11/11/23.
//

import Foundation
import Moya

enum APIService {

	case getHotAccounts
	case getHotURLs
	
	case getURLValidation(parameter: [String: Any])
	case getAccountValidation(parameter: [String: Any])
	case postSave(parameter: [String: Any])
	case postReport(parameter:[String: Any])
	
}

extension APIService: TargetType {
	var baseURL: URL {
		return URL(string: "http://172.20.10.4:8080/")!
	}
	
	var path: String {
		switch self {

		case .getHotAccounts:
			return "fraud/account/view"
		case .getHotURLs:
			return "fraud/url/view"
		case .getURLValidation:
			return "fraud/checkUrl"
		case .getAccountValidation:
			return "fraud/checkAccount"
		case .postSave:
			return "fraud"
		case .postReport:
			return "fraud/report/url"
		}
	}
	
	var method: Moya.Method {
		switch self {
		case .getHotAccounts:
			return .get
		case .getHotURLs:
			return .get
		case .getURLValidation:
			return .get
		case .getAccountValidation:
			return .get
		case .postSave:
			return .post
		case .postReport:
			return .post
		}
	}
	
	var task: Moya.Task {
		switch self {
		case .getHotAccounts:
			return .requestPlain
		case .getHotURLs:
			return .requestPlain
		case .getURLValidation(let parameter):
			return .requestParameters(parameters: parameter, encoding: URLEncoding.queryString)
		case .getAccountValidation(parameter: let parameter):
			return .requestParameters(parameters: parameter, encoding: URLEncoding.queryString)
		case .postSave(let parameter):
			return .requestParameters(parameters: parameter, encoding: URLEncoding.queryString)
		case .postReport(parameter: let parameter):
			return .requestParameters(parameters: parameter, encoding: URLEncoding.queryString)
		}
	}
	
	var headers: [String : String]? {
		return ["Content-Type": "application/json"]
	}
	
}

extension APIService {
	static public func request<T: Decodable>(target: APIService, dataType: T.Type) async throws -> T {
		return try await withCheckedThrowingContinuation { continuation in
			let provider = MoyaProvider<APIService>()
			provider.request(target) { result in
				switch result {
				case .success(let response):
					print("request 1 didFinishRequest URL [\(response.request?.url?.absoluteString ?? "")]")
					do {
						let data = try JSONDecoder().decode(T.self, from: response.data)
						continuation.resume(returning: data)
					} catch {
						continuation.resume(throwing: error)
					}
				case .failure(let error):
					continuation.resume(throwing: error)
				}
			}
		}
	}
	
	static public func request(target: APIService) async throws -> Response {
		return try await withCheckedThrowingContinuation { continuation in
			let provider = MoyaProvider<APIService>(plugins: [MoyaCacheablePlugin()])
			provider.request(target) { result in
				switch result {
				case .success(let response):
					print("request 2 didFinishRequest URL [\(response.request?.url?.absoluteString ?? "")]")
					continuation.resume(returning: response)
				case .failure(let error):
					continuation.resume(throwing: error)
				}
			}
		}
	}
}
