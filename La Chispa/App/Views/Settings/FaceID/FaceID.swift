//
//  FaceID.swift
//  La Chispa
//
//  Created by Pedro Omar  on 9/16/25.
//

import SwiftUI

struct FaceID : View {
    
    @Environment(\.colorScheme) var colorScheme
    
    var body : some View {
        List {
            
        }
        .listStyle(.insetGrouped)
        .toolbar {
            _titleView(label: LabelText(text: "Face ID && Passcode"))
        }
    }
    
    @ToolbarContentBuilder
    private func _titleView(label: LabelText) -> some ToolbarContent {
        ToolbarItem(placement: .principal) {
            Text(label.text)
                .fontWeight(.bold)
                .foregroundStyle(colorScheme == .dark ? .white : .black)
        }
    }
}

#Preview {
    FaceID()
}
