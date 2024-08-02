//
//  GameListResponse.swift
//  RandomUser
//
//  Created by Anca Arhip on 01.08.2024.
//

import Foundation

struct UsersListDTO: Codable {
    let results: [UserDTO]
    
    func callAsFunction() -> [User] {
        results.map { $0() }
    }
}

struct UserDTO: Codable, Equatable {
    let name: NameDTO?
    let email: String?
    let timezone: TimezoneDTO?
    let photo: ImageDTO?
    
    private enum CodingKeys: String, CodingKey {
        case name, email, timezone
        case photo = "picture"
    }
    
    func callAsFunction() -> User {
        User(
            id: UUID().uuidString,
            name: (name?.first ?? "") + " " + (name?.last ?? ""),
            email: email ?? "",
            time: timezone?.offset?.timeWithGMTOffset() ?? "",
            photoURL: URL(string: photo?.thumbnail ?? "")
        )
    }
}

struct NameDTO: Codable, Equatable {
    let first: String?
    let last: String?
}

struct TimezoneDTO: Codable, Equatable {
    let offset: String?
}

struct ImageDTO: Codable, Equatable {
    let thumbnail: String?
}
