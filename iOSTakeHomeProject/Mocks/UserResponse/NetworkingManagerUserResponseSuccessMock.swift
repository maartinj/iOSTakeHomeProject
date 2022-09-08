//
//  NetworkingManagerUserResponseSuccessMock.swift
//  iOSTakeHomeProjectTests
//
//  Created by Marcin Jędrzejak on 29/08/2022.
//
#if DEBUG
import Foundation

class NetworkingManagerUserResponseSuccessMock: NetworkingManagerImpl {
    
    func request<T>(session: URLSession, _ endpoint: iOSTakeHomeProject.Endpoint, type: T.Type) async throws -> T where T : Decodable, T : Encodable {
        return try StaticJSONMapper.decode(file: "UsersStaticData", type: UsersResponse.self) as! T
    }
    
    func request(session: URLSession, _ endpoint: iOSTakeHomeProject.Endpoint) async throws { }
}
#endif
