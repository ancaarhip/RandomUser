//
//  User.swift
//  RandomUser
//
//  Created by Anca Arhip on 31.07.2024.
//

import Foundation
import SwiftData

@Model
final class User {
    var id: String
    var name: String
    var email: String
    var time: String
    var photoURL: URL?
    
    init(id: String, name: String, email: String, time: String, photoURL: URL? = nil) {
        self.id = id
        self.name = name
        self.email = email
        self.time = time
        self.photoURL = photoURL
    }
}
