//
//  VisibilityModifier.swift
//  RandomUser
//
//  Created by Anca Arhip on 03.08.2024.
//

import SwiftUI

struct VisibilityModifier: ViewModifier {
    let onChange: (Bool) -> Void
    
    func body(content: Content) -> some View {
        content
            .background(
                GeometryReader { geometry in
                    Color.clear
                        .preference(key: VisibilityPreferenceKey.self, value: geometry.frame(in: .global))
                }
            )
            .onPreferenceChange(VisibilityPreferenceKey.self) { frame in
                let screenHeight = UIScreen.main.bounds.height
                let isVisible = frame.minY < screenHeight && frame.maxY > 0
                onChange(isVisible)
            }
    }
}

struct VisibilityPreferenceKey: PreferenceKey {
    typealias Value = CGRect
    static var defaultValue: CGRect = .zero
    
    static func reduce(value: inout CGRect, nextValue: () -> CGRect) {
        value = nextValue()
    }
}

extension View {
    func onVisibilityChange(perform: @escaping (Bool) -> Void) -> some View {
        self.modifier(VisibilityModifier(onChange: perform))
    }
}
