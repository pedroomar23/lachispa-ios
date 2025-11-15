//
//  AddWallet.swift
//  La Chispa
//
//  Created by Pedro Omar  on 11/3/25.
//

import SwiftUI

struct AddWallet : View {
    
    @StateObject var walletRequest = WalletRequest()
    @StateObject var loginRequest = LoginRequests()
    @Environment(\.colorScheme) var colorScheme
    
    let wallet : [Wallets]
    
    var body : some View {
        List {
            Picker("\(loginRequest.wallets)", selection: $loginRequest.wallets) {
                ForEach(wallet, id: \.id) { value in
                    Text("\(value.name)").tag(value.id)
                }
            }
            .pickerStyle(.inline)
            .labelsHidden()
        }
        .listStyle(.insetGrouped)
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
    
    @ViewBuilder
    private func _walletEmpty(label: LabelPre) -> some View {
        VStack {
            ZStack (alignment: .center) {
                RoundedRectangle(cornerRadius: 10, style: .continuous)
                    .fill(colorScheme == .dark ? .black : .blue)
                    .frame(width: 30, height: 30)
                Image(systemName: label.icon)
                    .foregroundStyle(colorScheme == .dark ? .blue : .white)
                    .font(.system(size: 20, weight: .medium))
            }
            Text(label.text)
                .font(.headline)
                .foregroundStyle(colorScheme == .dark ? .white : .black)
            Text(label.text1)
                .font(.subheadline)
        }
        .background {
            RoundedRectangle(cornerRadius: 10, style: .continuous).fill(Color(.tertiarySystemGroupedBackground))
        }
        .padding()
    }
}

