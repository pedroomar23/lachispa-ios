//
//  ReceiveView.swift
//  La Chispa
//
//  Created by Pedro Omar  on 10/28/25.
//

import SwiftUI

struct ReceiveView : View {
    
    @StateObject var loginRequest = LoginRequests()
    @Environment(\.colorScheme) var colorScheme
    @Environment(\.dismiss) var dismiss
    @State var selection = ReceiveV.lnurl
    
    var body : some View {
        if #available(iOS 16, *) {
            ContentNavigation {
                Picker("", selection: $selection) {
                    Text(ReceiveV.lnurl.rawValue).tag(ReceiveV.lnurl)
                    Text(ReceiveV.lnbc.rawValue).tag(ReceiveV.lnbc)
                }
                .padding(.horizontal)
                .pickerStyle(.segmented)
                .toolbar {
                    _toolbar(label: LabelText(text: "invoice-receive"))
                }
                
                switch selection {
                case .lnurl:
                    CreatesInvoice()
                case .lnbc:
                    ReceiveInvoice()
                }
            }
        } else {
            Picker("", selection: $selection) {
                Text(ReceiveV.lnurl.rawValue).tag(ReceiveV.lnurl)
                Text(ReceiveV.lnbc.rawValue).tag(ReceiveV.lnbc)
            }
            .padding(.horizontal)
            .pickerStyle(.segmented)
            .toolbar {
                _toolbarIOS15(label: LabelIcon(text: "invoice-receive", icon: "xmark"))
            }
            
            switch selection {
            case .lnurl:
                CreatesInvoice()
            case .lnbc:
                ReceiveInvoice()
            }
        }
    }
    
    enum ReceiveV : LocalizedStringKey {
        case lnurl = "lnURL"
        case lnbc = "lnbc"
    }
    
    @ToolbarContentBuilder
    private func _toolbar(label: LabelText) -> some ToolbarContent {
        ToolbarItem(placement: .principal) {
            Text(label.text)
                .font(.headline)
                .foregroundStyle(colorScheme == .dark ? .white : .black)
        }
    }
    
    @ToolbarContentBuilder
    private func _toolbarIOS15(label: LabelIcon) -> some ToolbarContent {
        ToolbarItem(placement: .principal) {
            Text(label.text)
                .font(.headline)
                .foregroundStyle(colorScheme == .dark ? .white : .black)
        }
        ToolbarItem(placement: .topBarTrailing) {
            Button {
                dismiss()
            } label: {
                Image(systemName: label.icon)
                    .font(.system(size: 25, weight: .medium))
                    .foregroundStyle(colorScheme == .dark ? .white : .black)
            }
        }
    }
}

#Preview {
    ReceiveView()
}
