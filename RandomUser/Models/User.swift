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
    var name: String
    var imageURL: String
    
    init(name: String, imageURL: String) {
        self.name = name
        self.imageURL = imageURL
    }
}
