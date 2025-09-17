//
//  Settings.swift
//  La Chispa
//
//  Created by Pedro Omar  on 9/12/25.
//

import SwiftUI

struct Settings : View {
    
    @Environment(\.colorScheme) var colorScheme
    
    var body : some View {
        if #available(iOS 16, *) {
            ContentNavigation {
                List {
                    Section {
                        NavigationLink {
                            FaceID()
                        } label: {
                            _labelFaceId(label: LabelIcon(text: "Face ID && Passcode", icon: "faceid"))
                        }
                    } header: {
                        Text("Security").textCase(.none)
                    }
                }
                .listStyle(.insetGrouped)
                .toolbar {
                    _titleView(label: LabelText(text: "Settings"))
                }
            }
        } else {
            ScrollView (.vertical, showsIndicators: false) {
                List {
                    Section {
                        NavigationLink {
                            FaceID()
                        } label: {
                            _labelFaceId(label: LabelIcon(text: "Face ID && Passcode", icon: "faceid"))
                        }
                    } header: {
                        Text("Security").textCase(.none)
                    }
                }
                .listStyle(.insetGrouped)
                .toolbar {
                    _titleView(label: LabelText(text: "Settings"))
                }
            }
        }
    }
    
    @ToolbarContentBuilder
    private func _titleView(label: LabelText) -> some ToolbarContent {
        ToolbarItem(placement: .topBarLeading) {
            Text(label.text)
                .font(.title)
                .fontWeight(.bold)
                .foregroundStyle(colorScheme == .dark ? .white : .black)
        }
    }
}

#Preview {
    Settings()
}


