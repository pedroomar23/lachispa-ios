//
//  NewWallet.swift
//  La Chispa
//
//  Created by Pedro Omar  on 10/28/25.
//

import SwiftUI

struct NewWallet : View {
    
    @StateObject var walletRequest = WalletRequest()
    @Environment(\.colorScheme) var colorScheme
    
    var body : some View {
        if #available(iOS 16, *) {
            ContentNavigation {
                VStack {
                    MutiTextfield(text: $walletRequest.name, placeholder: "http://example.com")
                        .frame(height: 53)
                        .padding()
                    
                    Button {
                        walletRequest.createWalletRequests()
                    } label: {
                        if walletRequest.isWallet {
                            ProgressBar(color: .blue)
                        } else {
                            _labelButton(label: LabelText(text: "Connect"))
                        }
                    }
                    .alert("Error", isPresented: $walletRequest.alertMsg) {
                        
                    } message: {
                        Text(walletRequest.message)
                    }
                }
                .padding(.horizontal)
                .toolbar {
                    _toolbar(label: LabelText(text: "Create Wallet"))
                }
                Spacer()
            }
        } else {
            VStack {
                MutiTextfield(text: $walletRequest.name, placeholder: "http://example.com")
                    .frame(height: 53)
                    .padding()
                
                Button {
                    walletRequest.createWalletRequests()
                } label: {
                    if walletRequest.isWallet {
                        ProgressBar(color: .blue)
                    } else {
                        _labelButton(label: LabelText(text: "Connect"))
                    }
                }
                .alert("Error", isPresented: $walletRequest.alertMsg) {
                    
                } message: {
                    Text(walletRequest.message)
                }
            }
            .padding(.horizontal)
            .toolbar {
                _toolbar(label: LabelText(text: "Create Wallet"))
            }
            Spacer()
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
    private func _labelButton(label: LabelText) -> some View {
        Text(label.text)
            .font(.headline)
            .foregroundColor(.white)
            .padding(.vertical)
            .frame(width: UIScreen.main.bounds.width - 150)
            .background(Color(colorScheme == .dark ? .gray : .blue))
            .clipShape(Capsule())
            .padding()
    }
}

#Preview {
    NewWallet()
}
