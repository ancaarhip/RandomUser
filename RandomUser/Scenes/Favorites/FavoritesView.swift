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

    @State private var deleteAlert = false
    
    var body: some View {
        List {
            ForEach(favourites) { user in
                Text(user.name)
            }
            .onDelete(perform: deleteItems)
        }
        .navigationBar(
            title:
                Text("favorites").titleStyle(),
            trailing:
                Button {
                    deleteAlert.toggle()
                } label: {
                    Image(systemName: "trash")
                }
                .disabled(favourites.isEmpty)
        )
        .alert(isPresented: $deleteAlert) {
            Alert(title: Text("confirm"),
                message: Text("confirm_delete_message"),
                primaryButton: .destructive(Text("delete")) {
                   clearAll()
                },
                secondaryButton: .cancel())
        }
    }

    private func deleteItems(offsets: IndexSet) {
        withAnimation {
            for index in offsets {
                modelContext.delete(favourites[index])
            }
        }
    }
    
    private func clearAll() {
        do {
            try modelContext.delete(model: User.self)
        } catch {
            //Handle error
            print("Error deleting favs")
        }
    }
}
