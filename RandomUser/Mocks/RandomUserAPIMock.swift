//
//  RandomUserAPIMock.swift
//  RandomUser
//
//  Created by Anca Arhip on 02.08.2024.
//

import Foundation

final class RandomUserAPIMock: RandomUserAPIProtocol {
    
    func callAsFunction(page: Int, completion: (UsersListResults)) async throws {
        let users = [
            User(id: "id0", name: "Ion Popescu", email: "ion.popescu@test.ro", time: "+4:00"),
            User(id: "id1", name: "Maria Popescu", email: "maria.popescu@test.ro", time: "+1:00"),
            User(id: "id2", name: "Vasi Popescu", email: "vasi.popescu@test.ro", time: "+4:00"),
            User(id: "id3", name: "Alin Popescu", email: "alin.popescu@test.ro", time: "+2:00"),
            User(id: "id4", name: "Ana Popescu", email: "ana.popescu@test.ro", time: "+4:00"),
            User(id: "id5", name: "Ovi Popescu", email: "ovi.popescu@test.ro", time: "+5:00"),
            User(id: "id6", name: "Sorin Popescu", email: "sorin.popescu@test.ro", time: "-1:00"),
            User(id: "id7", name: "Elena Popescu", email: "elena.popescu@test.ro", time: "+3:00"),
            User(id: "id8", name: "Radu Popescu", email: "radu.popescu@test.ro", time: "-2:00")
        ]
        completion(.success(users))
    }
}
