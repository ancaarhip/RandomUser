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
    @Published private(set) internal var errorMessage: String?
    @Published internal var showAlert = false
    
    private(set) internal var viewState: ViewState = .notLoaded
    private var page: Int = 1
    
    private var randomUserAPI: any RandomUserAPIProtocol
    
    init(randomUserAPI: any RandomUserAPIProtocol = RandomUserAPI()) {
        self.randomUserAPI = randomUserAPI
    }
    
    func getUsers() {
        Task {
            try await self.testableLoadingData()
        }
    }
    
    func searchedUsers(text: String) -> [User] {
        if text.isEmpty {
            return self.users
        } else {
            return self.users.filter { $0.name.lowercased().contains(text.lowercased()) }
        }
    }
    
    func testableLoadingData() async throws {
        self.viewState = .loading
        
        try await randomUserAPI(page: self.page) { [weak self] results in
            guard let self else { return }
            switch results {
            case .success(let users):
                DispatchQueue.main.async {
                    self.showAlert = false
                    self.viewState = .loaded
                    self.users.append(contentsOf: users)
                }
            case .failure(let error):
                DispatchQueue.main.async {
                    self.errorMessage = error.localizedDescription
                    self.showAlert = true
                }
            }
        }
    }
}

enum ViewState: Equatable {
    case notLoaded
    case loading
    case loaded
}
