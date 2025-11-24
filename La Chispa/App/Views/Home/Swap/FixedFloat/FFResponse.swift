//
//  FFResponse.swift
//  La Chispa
//
//  Created by Pedro Omar  on 11/20/25.
//

import SwiftUI

struct FFResponse : View {
    
    @Environment(\.colorScheme) var colorScheme
    let value : ResponseOrden
    
    var body : some View {
        ContentNavigation {
            List {
                
            }
            .listStyle(.insetGrouped)
            .toolbar {
                _toolbar(label: LabelText(text: "Orden"))
            }
        }
    }
    
    @ToolbarContentBuilder
    private func _toolbar(label: LabelText) -> some ToolbarContent {
        ToolbarItem(placement: .principal) {
            Text(label.text)
                .font(.headline)
                .foregroundStyle(colorScheme == .dark ? .white : .black)
        }
    }
    
    @ViewBuilder
    private func _swapView(text: LocalizedStringKey, icon: String, value: String) -> some View {
        HStack (alignment: .center, spacing: 5) {
            
        }.frame(maxWidth: .infinity, alignment: .leading)
    }
}
