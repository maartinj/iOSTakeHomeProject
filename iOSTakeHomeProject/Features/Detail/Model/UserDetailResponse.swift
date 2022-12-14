//
//  UserDetailResponse.swift
//  iOSTakeHomeProject
//
//  Created by Marcin Jędrzejak on 31/07/2022.
//

// MARK: - UserDetailResponse
struct UserDetailResponse: Codable, Equatable {
    let data: User
    let support: Support
}
