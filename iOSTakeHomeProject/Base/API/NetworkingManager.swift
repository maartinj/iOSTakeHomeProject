//
//  NetworkingManager.swift
//  iOSTakeHomeProject
//
//  Created by Marcin Jędrzejak on 07/08/2022.
//

import Foundation

// Impl - Implementation
protocol NetworkingManagerImpl {
    
    func request<T: Codable>(session: URLSession,
                             _ endpoint: Endpoint,
                             type: T.Type) async throws -> T
    
    func request(session: URLSession,
                 _ endpoint: Endpoint) async throws
}

final class NetworkingManager: NetworkingManagerImpl {
    
    static let shared = NetworkingManager()
    
    private init() {}
    
//    func request<T: Codable>(methodType: MethodType = .GET,
//                            _ absoluteURL: String,
//                             type: T.Type,
//                             completion: @escaping (Result<T, Error>) -> Void) { -> Old
    func request<T: Codable>(session: URLSession = .shared,
                             _ endpoint: Endpoint,
                             type: T.Type) async throws -> T {
//    func request<T: Codable>(_ endpoint: Endpoint,
//                             type: T.Type) async throws -> T { -> Old
        
//        guard let url = URL(string: absoluteURL) else { -> Old
        guard let url = endpoint.url else {
            throw NetworkingError.invalidURL
        }
        
//        let request = buildRequest(from: url, methodType: methodType) -> Old
        let request = buildRequest(from: url, methodType: endpoint.methodType)
        
//        let (data, response) = try await URLSession.shared.data(for: request) -> Old
        let (data, response) = try await session.data(for: request)
        
        guard let response = response as? HTTPURLResponse,
              (200...300) ~= response.statusCode else {
            let statusCode = (response as! HTTPURLResponse).statusCode
            throw NetworkingError.invalidStatusCode(statusCode: statusCode)
        }
        
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        let res = try decoder.decode(T.self, from: data)
        
        return res
    }
    
//    func request(methodType: MethodType = .GET,
//                _ absoluteURL: String,
//                 completion: @escaping (Result<Void, Error>) -> Void) { -> Old
//    func request(_ endpoint: Endpoint) async throws { -> Old
    func request(session: URLSession = .shared,
                 _ endpoint: Endpoint) async throws {
        
//        guard let url = URL(string: absoluteURL) else { -> Old
        guard let url = endpoint.url else {
            throw NetworkingError.invalidURL
        }
        
//        let request = buildRequest(from: url, methodType: methodType) -> Old
        let request = buildRequest(from: url, methodType: endpoint.methodType)
        
//        let (_, response) = try await URLSession.shared.data(for: request) -> Old
        let (_, response) = try await session.data(for: request)
        
        guard let response = response as? HTTPURLResponse,
              (200...300) ~= response.statusCode else {
            let statusCode = (response as! HTTPURLResponse).statusCode
            throw NetworkingError.invalidStatusCode(statusCode: statusCode)
        }
    }
}

extension NetworkingManager {
    enum NetworkingError: LocalizedError {
        case invalidURL
        case custom(error: Error)
        case invalidStatusCode(statusCode: Int)
        case invalidData
        case failedToDecode(error: Error)
    }
}

extension NetworkingManager.NetworkingError: Equatable {
    
    static func == (lhs: NetworkingManager.NetworkingError, rhs: NetworkingManager.NetworkingError) -> Bool {
        // lhs - left hand side, rhs - right hand side
        switch(lhs, rhs) {
        case (.invalidURL, .invalidURL):
            return true
        case (.custom(let lhsType), .custom(let rhsType)):
            return lhsType.localizedDescription == rhsType.localizedDescription
        case (.invalidStatusCode(let lhsType), .invalidStatusCode(let rhsType)):
            return lhsType == rhsType
        case(.invalidData, .invalidData):
            return true
        case (.failedToDecode(let lhsType), .failedToDecode(let rhsType)):
            return lhsType.localizedDescription == rhsType.localizedDescription
        default:
            return false
        }
    }
}

extension NetworkingManager.NetworkingError {
    
    var errorDescription: String? {
        switch self {
        case .invalidURL:
            return "URL isn't valid"
        case .invalidStatusCode:
            return "Stasus code falls into the wrong range"
        case.invalidData:
            return "Response data is invalid"
        case.failedToDecode:
            return "Failed to decode"
        case.custom(let err):
            return "Something went wrong \(err.localizedDescription)"
        }
    }
}

private extension NetworkingManager {
//    func buildRequest(from url: URL,
//                      methodType: MethodType) -> URLRequest { -> Old
    func buildRequest(from url: URL,
                      methodType: Endpoint.MethodType) -> URLRequest {
        var request = URLRequest(url: url)
        
        switch methodType {
        case .GET:
            request.httpMethod = "GET"
        case .POST(let data):
            request.httpMethod = "POST"
            request.httpBody = data
        }
        return request
    }
}
