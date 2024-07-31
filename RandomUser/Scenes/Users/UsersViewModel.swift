//
//  UsersViewModel.swift
//  RandomUser
//
//  Created by Anca Arhip on 31.07.2024.
//

import Foundation

@MainActor
final class UsersViewModel: ObservableObject {
    
    @Published private(set) internal var users: [User] = []
    
    init() {
        getUsers()
    }
    
    func getUsers() {
        Task {
            users = [
//                User(name: "\(Int.random(in: 1..<1000))", imageURL: "https://randomuser.me/api/portraits/thumb/women/88.jpg"),
//                User(name: "\(Int.random(in: 1..<1000))", imageURL: "https://randomuser.me/api/portraits/thumb/women/88.jpg"),
//                User(name: "\(Int.random(in: 1..<1000))", imageURL: "https://randomuser.me/api/portraits/thumb/women/88.jpg"),
//                User(name: "\(Int.random(in: 1..<1000))", imageURL: ""),
//                User(name: "\(Int.random(in: 1..<1000))", imageURL: "https://randomuser.me/api/portraits/thumb/women/88.jpg")
            ]
        }
    }
    
    func searchedUsers(text: String) -> [User] {
        if text.isEmpty {
            return self.users
        } else {
            return self.users.filter { $0.name.lowercased().contains(text.lowercased()) }
        }
    }
}
