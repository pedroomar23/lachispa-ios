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
                    NavigationLink {
                        Currency()
                    } label: {
                        _labelCurrency(label: LabelIcon(text: "Currency", icon: "dollarsign"))
                    }
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
            .navigationBarTitleDisplayMode(.large)
            .navigationTitle(_titleView("settings-view"))
        }
    }
    
    private func _titleView(_ text: LocalizedStringKey) -> Text {
        Text(text)
            .fontWeight(.bold)
            .foregroundColor(colorScheme == .dark ? .white : .black)
    }
}

#Preview {
    Settings()
}


