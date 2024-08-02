//
//  ViewTitleStyle.swift
//  RandomUser
//
//  Created by Anca Arhip on 02.08.2024.
//

import SwiftUI

protocol TextModifier {
    associatedtype Body: View
    
    func body(text: Text) -> Body
}

extension Text {
    func modifier<Modifier: TextModifier>(_ modifier: Modifier) -> some View {
        return modifier.body(text: self)
    }
}

struct TitleStypeModifier: TextModifier {
    func body(text: Text) -> some View {
        text
            .font(.system(size: 20, weight: .semibold))
    }
}

extension Text {
    func titleStyle() -> some View {
        modifier(TitleStypeModifier())
    }
}
