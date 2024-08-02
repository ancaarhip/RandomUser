//
//  GameEndpoints.swift
//  RandomUser
//
//  Created by Anca Arhip on 01.08.2024.
//

import Foundation

enum UserEndpoints {
    case list(page: Int)
}

extension UserEndpoints: EndpointsProtocol {
    
    var baseURLString: String {
        switch self {
        case .list(let page):
            return "https://randomuser.me/api/?page=\(page)&results=20"
        }
    }
}

protocol EndpointsProtocol {
    var baseURLString: String { get }
}

extension EndpointsProtocol {
    var url: String {
        return baseURLString
    }
}
