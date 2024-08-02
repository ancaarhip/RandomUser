//
//  MainTabView.swift
//  RandomUser
//
//  Created by Anca Arhip on 31.07.2024.
//

import SwiftUI

struct MainTabView: View {
    var body: some View {
        TabView {
            UsersView()
                .tabItem {
                    Label("Users", systemImage: "person")
                }
            FavoritesView()
                .tabItem {
                    Label("Favorites", systemImage: "star")
                }
        }
        .preferredColorScheme(.light)
    }
}
