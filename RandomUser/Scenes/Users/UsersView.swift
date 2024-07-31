//
//  UsersView.swift
//  RandomUser
//
//  Created by Anca Arhip on 31.07.2024.
//

import SwiftUI
import SwiftData
import Kingfisher

struct UsersView: View {
    
    @StateObject private var viewModel = UsersViewModel()
    @State private var searchText = ""
    
    @Environment(\.modelContext) private var modelContext
    @Query private var favourites: [User]
    
    init() {
        UITabBar.appearance().backgroundColor = UIColor(Color.yellow)
    }
    
    var body: some View {
        NavigationView {
            ScrollView {
                LazyVStack {
                    ForEach(viewModel.users, id: \.id) { user in
                        userView(user)
                    }
                    .searchable(text: $searchText) {
                        ForEach(viewModel.searchedUsers(text: self.searchText), id: \.id) { user in
                            userView(user)
                        }
                    }
                }
                .navigationBar(
                    title: "Users"
                )
                .padding()
            }
        }
    }
}

extension UsersView {
    private func userView(_ user: User) -> some View {
        HStack {
            ZStack {
                Text(user.name.prefix(1))
                    .frame(width: 50, height: 50)
                if let imageURL = URL(string: user.imageURL) {
                    KFImage(imageURL)
                }
            }
            .background(Color.yellow)
            .clipShape(Circle())
            
            Text(user.name)
            Spacer()
            Button {
                if favourites.contains(user) {
                    modelContext.delete(user)
                } else {
                    modelContext.insert(user)
                }
            } label: {
                if favourites.contains(user) {
                    Image(systemName: "star.fill")
                } else {
                    Image(systemName: "star")
                }
            }
        }
    }
}
