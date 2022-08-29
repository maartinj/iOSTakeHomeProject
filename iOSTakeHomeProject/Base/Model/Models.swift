//
//  Models.swift
//  iOSTakeHomeProject
//
//  Created by Marcin Jędrzejak on 31/07/2022.
//

// MARK: - User
struct User: Codable, Equatable {
    let id: Int
    let email, firstName, lastName: String
    let avatar: String
}

// MARK: - Support
struct Support: Codable, Equatable {
    let url: String
    let text: String
}
