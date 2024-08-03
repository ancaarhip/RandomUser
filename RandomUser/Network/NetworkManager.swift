//
//  NetworkManager.swift
//  RandomUser
//
//  Created by Anca Arhip on 01.08.2024.
//

import Foundation
import Network

final class NetworkManager {
    
    static let shared = NetworkManager()
    
    var cachePolicy: URLRequest.CachePolicy = .useProtocolCachePolicy
    var timeout = 30.0
    
    private init() { 
        NetworkMonitor.start()
    }
    
    func makeRequest<T: Codable>(type: T.Type, urlString: String) async throws -> T {
        guard NetworkMonitor.hasInternetConnection else {
            throw NetworkError.noInternet
        }
        guard let url = URL(string: urlString) else {
            throw NetworkError.invalidURL
        }
        
        var request = URLRequest(
            url: url,
            cachePolicy: cachePolicy,
            timeoutInterval: timeout
        )
        
        let (data, response) = try await URLSession.shared.data(for: request)
        
        guard let response = response as? HTTPURLResponse,
              200...299 ~= response.statusCode else { throw NetworkError.invalidResponse }
        
        do {
            let decodedData = try JSONDecoder().decode(T.self, from: data)
            return decodedData
        } catch {
            throw NetworkError.requestFailed
        }
    }
}

enum NetworkMonitor {
    private static let monitor = NWPathMonitor()
    private static let queue = DispatchQueue(label: "NetworkMonitor")
        
    public static var hasInternetConnection: Bool {
        monitor.currentPath.status == .satisfied
    }
    
    public static func start() {
        monitor.start(queue: queue)
    }
}

