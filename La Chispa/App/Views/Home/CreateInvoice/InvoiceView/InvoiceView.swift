//
//  InvoiceView.swift
//  La Chispa
//
//  Created by Pedro Omar  on 10/27/25.
//

import SwiftUI

struct InvoiceView : View {
    
    @State var selection = LNView.lnbc
    @Environment(\.colorScheme) var colorScheme
    
    var body : some View {
        if #available(iOS 16, *) {
            ContentNavigation {
                Picker("", selection: $selection) {
                    Text(LNView.lnbc.rawValue).tag(LNView.lnbc)
                    Text(LNView.lnURL.rawValue).tag(LNView.lnURL)
                }
                .padding(.horizontal)
                .pickerStyle(.segmented)
                .toolbar {
                    _toolbar(label: LabelText(text: "invoice-view"))
                }
                
                switch selection {
                case .lnbc:
                    Invoice()
                case .lnURL:
                    LNURL()
                }
            }
        } else {
            Picker("", selection: $selection) {
                Text(LNView.lnbc.rawValue).tag(LNView.lnbc)
                Text(LNView.lnURL.rawValue).tag(LNView.lnURL)
            }
            .padding(.horizontal)
            .pickerStyle(.segmented)
            .toolbar {
                _toolbar(label: LabelText(text: "invoice-view"))
            }
            
            switch selection {
            case .lnbc:
                Invoice()
            case .lnURL:
                LNURL()
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
    
    enum LNView : LocalizedStringKey {
        case lnbc = "lnbc"
        case lnURL = "lnURL"
    }
}

#Preview {
    InvoiceView()
}
