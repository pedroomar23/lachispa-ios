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
                ForEach(loginRequest.loginAuth.wallets, id: \.self) { account in
                    _account(account: account)
                }
            }
            Section {
                Button(role: .destructive) {
                    loginRequest.closeSession()
                } label: {
                    if loginRequest.isLoading {
                        ProgressBar(color: .blue)
                            .frame(maxWidth: .infinity, alignment: .center)
                    } else {
                        Text("Close Sesion")
                            .frame(maxWidth: .infinity, alignment: .center)
                    }
                }
            }
        }
        .listStyle(.insetGrouped)
        .environmentObject(loginRequest)
        .toolbar {
            _titleView(label: LabelText(text: "Account"))
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
    private func _account(account: Wallets) -> some View {
        HStack (alignment: .center) {
            Image(systemName: "person")
                .foregroundStyle(colorScheme == .dark ? .white : .black)
                .font(.system(size: 20, weight: .medium))
            Text("Username")
                .lineLimit(1)
                .foregroundStyle(colorScheme == .dark ? .white : .black)
                .frame(maxWidth: .infinity, alignment: .leading)
            Text(account.user)
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
            Text(account.created_at)
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
            Text(account.updated_at)
                .lineLimit(1)
                .foregroundStyle(colorScheme == .dark ? .white : .gray)
                .frame(maxWidth: .infinity, alignment: .trailing)
        }.frame(maxWidth: .infinity, alignment: .leading)
        
        HStack (alignment: .center) {
            Image(systemName: "dollarsign.circle")
                .foregroundStyle(colorScheme == .dark ? .white : .black)
                .font(.system(size: 20, weight: .medium))
            Text("Currency")
                .lineLimit(1)
                .foregroundStyle(colorScheme == .dark ? .white : .black)
                .frame(maxWidth: .infinity, alignment: .leading)
            Text(account.currency)
                .lineLimit(1)
                .foregroundStyle(colorScheme == .dark ? .white : .gray)
                .frame(maxWidth: .infinity, alignment: .trailing)
        }.frame(maxWidth: .infinity, alignment: .leading)
        
        HStack (alignment: .center) {
            Image(systemName: "bag")
                .foregroundStyle(colorScheme == .dark ? .white : .black)
                .font(.system(size: 20, weight: .medium))
            Text("Balance")
                .lineLimit(1)
                .foregroundStyle(colorScheme == .dark ? .white : .black)
                .frame(maxWidth: .infinity, alignment: .leading)
            Text("\(account.balance_msat)")
                .lineLimit(1)
                .foregroundStyle(colorScheme == .dark ? .white : .gray)
                .frame(maxWidth: .infinity, alignment: .trailing)
        }.frame(maxWidth: .infinity, alignment: .center)
    }
}

#Preview {
    Account()
}
