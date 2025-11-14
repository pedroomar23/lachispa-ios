//
//  WalletResponse.swift
//  La Chispa
//
//  Created by Pedro Omar  on 10/29/25.
//

import SwiftUI

struct WalletResponse : View {
    
    @StateObject var loginRequest = LoginRequests()
    @StateObject var walletRequest = WalletRequest()
    @Environment(\.colorScheme) var colorScheme
    @Environment(\.dismiss) var dismiss
    
    let wallet : CreateWalletResponse
    
    var body : some View {
        ContentNavigation {
            List {
                Section {
                   _preview(label: LabelIcon(text: "wallet-create", icon: "checkmark.seal.fill"))
                }
                
                Section {
                    _wallet(text: "ID", icon: "humidity", value: wallet.id)
                    _wallet(text: "login-username", icon: "person.fill", value: wallet.user)
                    _wallet(text: "Name", icon: "person", value: wallet.name)
                    _wallet(text: "Admin Key", icon: "square.and.arrow.up", value: wallet.adminkey)
                    _wallet(text: "Inkey", icon: "square.and.arrow.down", value: wallet.inkey)
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
    
    @ViewBuilder
    private func _wallet(text: LocalizedStringKey, icon: String, value: String) -> some View {
        HStack (alignment: .center, spacing: 5) {
            Image(systemName: icon)
                .font(.system(size: 14, weight: .medium))
                .foregroundStyle(colorScheme == .dark ? .white : .black)
            Text(text)
                .lineLimit(1)
                .foregroundStyle(colorScheme == .dark ? .white : .black)
                .frame(maxWidth: .infinity, alignment: .leading)
            Text(value)
                .lineLimit(1)
                .foregroundStyle(colorScheme == .dark ? .white : .gray)
                .frame(maxWidth: .infinity, alignment: .trailing)
        }.frame(maxWidth: .infinity, alignment: .leading)
    }
}


