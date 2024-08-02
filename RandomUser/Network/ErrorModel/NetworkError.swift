//
//  NetworkError.swift
//  RandomUser
//
//  Created by Anca Arhip on 01.08.2024.
//

import Foundation

enum NetworkError: Error {
    case invalidURL
    case invalidResponse
    case requestFailed
    case invalidData
    
    var localizedDescription: String {
        switch self {
        case .invalidURL:
            return NSLocalizedString("invalid-url", comment: "")
        case .invalidResponse:
            return NSLocalizedString("invalid-response", comment: "")
        case .requestFailed:
            return NSLocalizedString("request-failed", comment: "")
        case .invalidData:
            return NSLocalizedString("invalid-data", comment: "")
        }
    }
}
