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
        UITabBar.appearance().backgroundColor = UIColor(Color.appColor)
    }
    
    var body: some View {
        Group {
            if viewModel.viewState == .loading {
                ProgressView()
                    .controlSize(.large)
                    .progressViewStyle(.circular)
                    .tint(.accentColor)
            } else {
                GeometryReader { _ in
                    usersList()
                }
            }
        }
        .navigationBar(
            title: Text("users").titleStyle()
        )
        .onAppear {
            viewModel.getUsers()
        }
        .alert(isPresented: $viewModel.showAlert) {
            Alert(
                title: Text("error"),
                message: Text(viewModel.errorMessage ?? ""),
                dismissButton: .default(Text("retry")) {
                    viewModel.getUsers()
                }
            )
        }
    }
}

extension UsersView {
    private func usersList() -> some View {
        ScrollView(showsIndicators: false) {
            LazyVStack {
                ForEach(Array(viewModel.users.enumerated()), id: \.offset) { index, user in
                    userView(user)
                        
                    Divider()
                        .onVisibilityChange { isVisible in
                            if isVisible {
                                viewModel.loadNextPage(currentIndex: index)
                            }
                        }
                }
                .searchable(text: $searchText) {
                    ForEach(viewModel.searchedUsers(text: self.searchText), id: \.id) { user in
                        userView(user)
                    }
                }
            }
            .padding()
        }
    }
    
    private func userView(_ user: User) -> some View {
        HStack{
            photoView(user)
            
            userDetailsView(user)
            
            Spacer()
            
            userTimeView(user)
        }
    }
    
    private func photoView(_ user: User) -> some View {
        ZStack {
            Text(user.name.prefix(1))
                .frame(width: 50, height: 50)
            if let photoURL = user.photoURL {
                KFImage(photoURL)
                    .placeholder{
                        ProgressView()
                            .controlSize(.large)
                            .progressViewStyle(.circular)
                            .tint(.accentColor)
                    }
            }
        }
        .background(Color.appColor)
        .clipShape(Circle())
    }
    
    private func userDetailsView(_ user: User) -> some View {
        VStack(alignment: .leading) {
            Text(user.name)
                .foregroundColor(.primaryTextColor)
                .multilineTextAlignment(.leading)
                .font(.system(size: 14, weight: .semibold))
                .padding(EdgeInsets(top: 4, leading: 4, bottom: 4, trailing: 0))
            Text(user.email)
                .foregroundColor(.secondaryTextColor)
                .multilineTextAlignment(.leading)
                .font(.system(size: 12, weight: .light))
                .padding(.leading, 4)
        }
    }
    
    private func userTimeView(_ user: User) -> some View {
        VStack {
            Text(user.time)
                .foregroundColor(.primaryTextColor)
                .multilineTextAlignment(.leading)
                .font(.system(size: 14))
            Button {
                if favourites.contains(user) {
                    modelContext.delete(user)
                } else {
                    modelContext.insert(user)
                }
            } label: {
                if favourites.contains(user) {
                    Image(systemName: "star.fill").foregroundColor(.appColor)
                } else {
                    Image(systemName: "star")
                }
            }
        }
    }
}
