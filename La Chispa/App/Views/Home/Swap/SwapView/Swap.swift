//
//  Swap.swift
//  La Chispa
//
//  Created by Pedro Omar  on 10/20/25.
//

import SwiftUI

struct Swap : View {
    
    @Environment(\.colorScheme) var colorScheme
    @State var selection = SwapView.boltz
    
    var body : some View {
        ContentNavigation {
            Picker("", selection: $selection) {
                Text(SwapView.boltz.rawValue).tag(SwapView.boltz)
                Text(SwapView.fixedFloat.rawValue).tag(SwapView.fixedFloat)
            }
            .padding(.horizontal)
            .pickerStyle(.segmented)
            .toolbar {
                _toolbar(label: LabelText(text: "Swap"))
            }
            
            switch selection {
            case .boltz:
                Boltz()
            case .fixedFloat:
                FixedFloat()
            }
        }
    }
    
    enum SwapView : LocalizedStringKey {
        case boltz = "Boltz"
        case fixedFloat = "Fixed Float"
    }
    
    @ToolbarContentBuilder
    private func _toolbar(label: LabelText) -> some ToolbarContent {
        ToolbarItem(placement: .principal) {
            Text(label.text)
                .font(.headline)
                .foregroundStyle(colorScheme == .dark ? .white : .black)
        }
    }
}

#Preview {
    Swap()
}
