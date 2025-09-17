//
//  Home.swift
//  La Chispa
//
//  Created by Pedro Omar  on 9/16/25.
//

import SwiftUI

struct Wallet : View {
    
    @Environment(\.colorScheme) var colorScheme
    
    var body: some View {
        if #available(iOS 16, *) {
            ContentNavigation {
                ScrollView (.vertical, showsIndicators: false) {
                    
                }
                .listRowBackground(Color.clear)
                .toolbar {
                    _titleView(label: LabelText(text: "Wallet"))
                }
            }
        } else {
            ScrollView (.vertical, showsIndicators: false) {
                
            }
            .listRowBackground(Color.clear)
            .toolbar {
                _titleView(label: LabelText(text: "Wallet"))
            }
        }
    }
    
    @ToolbarContentBuilder
    private func _titleView(label: LabelText) -> some ToolbarContent {
        ToolbarItem(placement: .topBarLeading) {
            Text(label.text)
                .font(.title)
                .fontWeight(.bold)
                .foregroundStyle(colorScheme == .dark ? .white : .black)
        }
    }
}

#Preview {
    Wallet()
}
