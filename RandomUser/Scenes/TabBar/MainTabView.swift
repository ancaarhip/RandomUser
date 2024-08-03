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
            NavigationView {
                UsersView()
            }
            .tabItem {
                Label("users", systemImage: "person")
            }
            NavigationView {
                FavoritesView()
            }
            .tabItem {
                Label("favorites", systemImage: "star")
            }
            
        }
        .preferredColorScheme(.light)
    }
}
