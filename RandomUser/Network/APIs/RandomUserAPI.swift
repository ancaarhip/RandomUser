//
//  RandomUserAPI.swift
//  RandomUser
//
//  Created by Anca Arhip on 01.08.2024.
//

import Foundation

protocol RandomUserAPIProtocol {
    typealias UsersListResults = (Result<[User], NetworkError>) -> Void
    
    func callAsFunction(page: Int, completion: (UsersListResults)) async throws
}

final class RandomUserAPI: RandomUserAPIProtocol {
    let networkManager = NetworkManager.shared
    
    func callAsFunction(page: Int, completion: (UsersListResults)) async throws {
        let urlString = UserEndpoints.list(page: page).url
        
        do {
            let users = try await networkManager.makeRequest(type: UsersListDTO.self, urlString: urlString)
            completion(.success(users()))
        } catch let error as NetworkError {
            completion(.failure(error))
        }
    }
}
