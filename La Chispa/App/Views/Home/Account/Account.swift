//
//  Account.swift
//  La Chispa
//
//  Created by Pedro Omar  on 9/22/25.
//

import SwiftUI

struct Account : View {

    @StateObject var loginRequest = LoginRequests()
    @Environment(\.colorScheme) var colorScheme
    
    let loginAuth : LoginAuth
    
    var body : some View {
        List {
            Section {
                _accountDetails(text: "login-username", icon: "person", value: loginAuth.username)
                _accountDetails(text: "Joined", icon: "calendar", value: "\(loginRequest.formatDate(loginAuth.created_at))")
                _accountDetails(text: "Updated", icon: "calendar", value: "\(loginRequest.formatDate(loginAuth.updated_at))")
            }
            Section {
                Button(role: .destructive) {
                    loginRequest.closeSession()
                } label: {
                    if loginRequest.isLoading {
                        ProgressBar(color: .blue)
                            .frame(maxWidth: .infinity, alignment: .center)
                    } else {
                        Text("login-close")
                            .frame(maxWidth: .infinity, alignment: .center)
                    }
                }
            }
        }
        .listStyle(.insetGrouped)
        .environmentObject(loginRequest)
        .toolbar {
            _titleView(label: LabelText(text: "wallet-account"))
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
    
    @ViewBuilder
    private func _accountDetails(text: LocalizedStringKey, icon: String, value: String) -> some View {
        HStack (alignment: .center) {
            Image(systemName: icon)
                .font(.system(size: 20, weight: .medium))
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

