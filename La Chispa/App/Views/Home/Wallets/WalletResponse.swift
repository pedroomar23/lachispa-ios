//
//  WalletResponse.swift
//  La Chispa
//
//  Created by Pedro Omar  on 10/29/25.
//

import SwiftUI

struct WalletResponse : View {
    
    @StateObject var walletRequest = WalletRequest()
    @Environment(\.colorScheme) var colorScheme
    @Environment(\.dismiss) var dismiss
    
    var body : some View {
        ContentNavigation {
            List {
                Section {
                   _preview(label: LabelIcon(text: "wallet-create", icon: "checkmark.seal.fill"))
                }
                
                Section {
                    
                }
            }
            .listStyle(.insetGrouped)
            .interactiveDismissDisabled()
            .toolbar {
                _toolbar(label: LabelIcon(text: "", icon: "xmark"))
            }
        }
    }
    
    @ToolbarContentBuilder
    private func _toolbar(label: LabelIcon) -> some ToolbarContent {
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
                    .font(.system(size: 20, weight: .medium))
                    .foregroundStyle(colorScheme == .dark ? .white : .black)
            }
        }
    }
    
    @ViewBuilder
    private func _preview(label: LabelIcon) -> some View {
        VStack {
            Image(systemName: label.icon)
                .font(.system(size: 40, weight: .medium))
                .foregroundStyle(colorScheme == .dark ? .white : .blue)
                .padding(2)
            Text(label.text)
                .font(.headline)
                .foregroundStyle(colorScheme == .dark ? .white : .black)
        }
        .frame(maxWidth: .infinity, alignment: .center)
        .listRowBackground(Color.clear)
    }
}

#Preview {
    WalletResponse()
}
