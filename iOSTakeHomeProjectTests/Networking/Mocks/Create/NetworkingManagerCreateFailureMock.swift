//
//  NetworkingManagerCreateFailureMock.swift
//  iOSTakeHomeProjectTests
//
//  Created by Marcin Jędrzejak on 07/09/2022.
//

import Foundation
@testable import iOSTakeHomeProject

class NetworkingManagerCreateFailureMock: NetworkingManagerImpl {
    
    func request<T>(session: URLSession, _ endpoint: Endpoint, type: T.Type) async throws -> T where T : Decodable {
        return Data() as! T
    }
    
    func request(session: URLSession, _ endpoint: Endpoint) async throws {
        throw NetworkingManager.NetworkingError.invalidURL
    }
}
