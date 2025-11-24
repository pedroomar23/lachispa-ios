//
//  Settings.swift
//  La Chispa
//
//  Created by Pedro Omar  on 9/12/25.
//

import SwiftUI

struct Settings : View {
    
    @StateObject var loginRequest = LoginRequests()
    @Environment(\.colorScheme) var colorScheme
    
    var body : some View {
        ContentNavigation {
            List {
                Section {
                    NavigationLink {
                        FaceID()
                    } label: {
                        _labelFaceId(label: LabelIcon(text: "settings-faceid", icon: "faceid"))
                    }
                } header: {
                    Text("settings-security").textCase(.none)
                }
                Section {
                    /*
                    NavigationLink {
                        AddWallet(wallet: loginRequest.wallet)
                   } label: {
                        _labelWallet(label: LabelIcons(text: "wallet-view", icon: "wallet.bifold", icon1: "creditcard"))
                    }
                     */
                    NavigationLink {
                        About()
                    } label: {
                        _labelPolicy(label: LabelIcon(text: "settings-aboutme", icon: "exclamationmark.circle"))
                    }
                } header: {
                    Text("settings-about").textCase(.none)
                }
            }
            .background(Color(.secondarySystemGroupedBackground).ignoresSafeArea(edges: .all))
            .listStyle(.insetGrouped)
            .toolbar {
                _titleView(label: LabelText(text: "settings-view"))
            }
        }
    }
    
    @ToolbarContentBuilder
    private func _titleView(label: LabelText) -> some ToolbarContent {
        ToolbarItem(placement: .principal) {
            Text(label.text)
                .font(.title3)
                .fontWeight(.bold)
                .foregroundStyle(colorScheme == .dark ? .white : .black)
        }
    }
}

#Preview {
    Settings()
}


