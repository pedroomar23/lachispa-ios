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
    
    var body : some View {
        List {
            Section {
                _account(response: loginRequest.loginAuth)
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
        .task {
            await loginRequest.getUserAuth()
        }
        .refreshable {
            await loginRequest.getUserAuth()
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
        ToolbarItem(placement: .topBarTrailing) {
            Menu {
                Button {
                    loginRequest.balance = true
                } label: {
                    if loginRequest.balance {
                        Image(systemName: "eye")
                    } else {
                        Image(systemName: "eye.slash")
                    }
                    Text("View Balance")
                }
            } label: {
                Image(systemName: "text.insert")
                    .foregroundStyle(colorScheme == .dark ? .white : .black)
                    .font(.system(size: 14, weight: .medium))
            }
        }
    }
    
    @ViewBuilder
    private func _account(response: LoginAuth) -> some View {
        HStack (alignment: .center) {
            Image(systemName: "person")
                .foregroundStyle(colorScheme == .dark ? .white : .black)
                .font(.system(size: 20, weight: .medium))
            Text("login-username")
                .lineLimit(1)
                .foregroundStyle(colorScheme == .dark ? .white : .black)
                .frame(maxWidth: .infinity, alignment: .leading)
            Text(response.username)
                .lineLimit(1)
                .foregroundStyle(colorScheme == .dark ? .white : .gray)
                .frame(maxWidth: .infinity, alignment: .trailing)
        }.frame(maxWidth: .infinity, alignment: .leading)
        
        HStack (alignment: .center) {
            Image(systemName: "calendar")
                .foregroundStyle(colorScheme == .dark ? .white : .black)
                .font(.system(size: 20, weight: .medium))
            Text("Joined")
                .lineLimit(1)
                .foregroundStyle(colorScheme == .dark ? .white : .black)
                .frame(maxWidth: .infinity, alignment: .leading)
            Text("\(loginRequest.formatDate(response.created_at))")
                .lineLimit(1)
                .foregroundStyle(colorScheme == .dark ? .white : .gray)
                .frame(maxWidth: .infinity, alignment: .trailing)
        }.frame(maxWidth: .infinity, alignment: .leading)
        
        HStack (alignment: .center) {
            Image(systemName: "calendar")
                .foregroundStyle(colorScheme == .dark ? .white : .black)
                .font(.system(size: 20, weight: .medium))
            Text("Updated")
                .lineLimit(1)
                .foregroundStyle(colorScheme == .dark ? .white : .black)
                .frame(maxWidth: .infinity, alignment: .leading)
            Text("\(loginRequest.formatDate(response.updated_at))")
                .lineLimit(1)
                .foregroundStyle(colorScheme == .dark ? .white : .gray)
                .frame(maxWidth: .infinity, alignment: .trailing)
        }.frame(maxWidth: .infinity, alignment: .leading)
    }
}

#Preview {
    Account()
}
