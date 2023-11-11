//
//  APIService.swift
//  SeeReaURL
//
//  Created by Eric Lee on 11/11/23.
//

import Foundation
import Moya

enum APIService {
	case getExamination(parameter: [String: Any])
}

extension APIService: TargetType {
	var baseURL: URL {
		return URL(string: "baseURL")!
	}
	
	var path: String {
		switch self {
		case .getExamination:
			return "/path"
		}
	}
	
	var method: Moya.Method {
		switch self {
		case .getExamination:
			return .get
		}
	}
	
	var task: Moya.Task {
		switch self{
		case .getExamination(let parameter):
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
