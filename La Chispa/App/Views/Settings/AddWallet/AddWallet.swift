//
//  AddWallet.swift
//  La Chispa
//
//  Created by Pedro Omar  on 11/3/25.
//

import SwiftUI

struct AddWallet : View {
    
    @StateObject var loginRequest = LoginRequests()
    @Environment(\.colorScheme) var colorScheme
    
    let wallets : [Wallets]
    
    var body : some View {
        List {
            ForEach(wallets, id: \.id) { value in 
                if value.id == loginRequest.wallets {
                    Picker("\(loginRequest.wallets)", selection: $loginRequest.wallets) {
                        Text(value.name).tag(value.id)
                    }
                    .pickerStyle(.inline)
                    .labelsHidden()
                }
            }
        }
        .listStyle(.insetGrouped)
        .refreshable {
            await loginRequest.getUserAuth()
        }
        .toolbar {
            _toolbar(label: LabelIcon(text: "wallet-view", icon: "plus"))
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
            NavigationLink {
                NewWallet()
            } label: {
                Image(systemName: label.icon)
                    .font(.system(size: 15, weight: .medium))
                    .foregroundStyle(colorScheme == .dark ? .white : .black)
            }
        }
    }
}

