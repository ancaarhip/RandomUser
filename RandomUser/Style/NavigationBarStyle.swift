//
//  NavigationBarStyle.swift
//  RandomUser
//
//  Created by Anca Arhip on 31.07.2024.
//

import SwiftUI

struct NavigationBarStyle: ViewModifier {
    let leading: AnyView
    let title: String
    let trailing: AnyView
    
    func body(content: Content) -> some View {
        content
            .toolbar {
                ToolbarItem(placement: .topBarLeading) { leading }
                ToolbarItem(placement: .principal) {
                    Text(title)
                        .fontWeight(.semibold)
                        .foregroundColor(.primary)
                }
                ToolbarItem(placement: .topBarTrailing) { trailing }
            }
            .navigationBarTitleDisplayMode(.inline)
            .toolbarBackground(.visible, for: .navigationBar)
            .toolbarBackground(Color.yellow, for: .navigationBar)
    }
}

extension View {
    func navigationBar(leading: any View = EmptyView(), title: String = "", trailing: any View = EmptyView()) -> some View {
        modifier(NavigationBarStyle(leading: AnyView(leading), title: title, trailing: AnyView(trailing)))
    }
}
