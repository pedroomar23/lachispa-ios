//
//  Receive.swift
//  La Chispa
//
//  Created by Pedro Omar  on 9/21/25.
//

import SwiftUI

struct Receive : View {
    
    @StateObject var loginRequest = LoginRequests()
    @Environment(\.colorScheme) var colorScheme
    
    var body : some View {
        if #available(iOS 16, *) {
            ContentNavigation {
                VStack {
                    
                }
                .toolbar {
                    _titleView(label: LabelText(text: "Receive"))
                }
            }
        } else {
            VStack {
                
            }
            .toolbar {
                _titleView(label: LabelText(text: "Receive"))
            }
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
    Receive()
}
