//
//  FavoritesView.swift
//  RandomUser
//
//  Created by Anca Arhip on 31.07.2024.
//

import SwiftUI
import SwiftData

struct FavoritesView: View {
    @Environment(\.modelContext) private var modelContext
    @Query private var favourites: [User]

    var body: some View {
        NavigationView {
            List {
                ForEach(favourites) { item in
                    Text(item.name)
                }
                .onDelete(perform: deleteItems)
            }
            .navigationBar(
                title: "Favorites"
            )
        }
    }

    private func deleteItems(offsets: IndexSet) {
        withAnimation {
            for index in offsets {
                modelContext.delete(favourites[index])
            }
        }
    }
}
