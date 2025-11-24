//
//  About.swift
//  La Chispa
//
//  Created by Pedro Omar  on 9/21/25.
//

import SwiftUI

struct About : View {
  
    @State var policy : Bool = false
    @Environment(\.colorScheme) var colorScheme
    
    var body: some View {
        List {
            Section {
                _image(label: LabelImages(icon: "LaunchImage", text: "LaChispa", text1: "v1.0 (1.0.3)"))
            }
            Section {
                Button {
                    self.policy.toggle()
                } label: {
                    _labelPolicy(label: LabelIcon(text: "settings-privacy", icon: "exclamationmark.shield"))
                }
                .sheet(isPresented: $policy) {
                    SafariWebView(url: URL(string: "https://app.lachispa.me")!)
                }
            }
        }
        .listStyle(.insetGrouped)
        .toolbar {
            _titleView(label: LabelText(text: "settings-aboutme"))
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
    private func _image(label: LabelImages) -> some View {
        VStack {
            Image(label.icon)
                .resizable()
                .frame(width: 60, height: 60)
                .cornerRadius(10)
            Text(label.text)
                .foregroundStyle(colorScheme == .dark ? .white : .black)
                .font(.headline)
            Text(label.text1)
                .foregroundStyle(colorScheme == .dark ? .white : .black)
                .font(.subheadline)
        }
        .frame(maxWidth: .infinity, alignment: .center)
        .listRowBackground(Color.clear)
        .listRowSeparator(.hidden)
    }
    
    @ViewBuilder
    private func _labelPolicy(label: LabelIcon) -> some View {
        HStack (alignment: .center, spacing: 12) {
            ZStack (alignment: .center) {
                RoundedRectangle(cornerRadius: 7, style: .continuous)
                    .fill(colorScheme == .dark ? .black : .orange)
                    .frame(width: 30, height: 30)
                Image(systemName: label.icon)
                    .foregroundStyle(colorScheme == .dark ? .orange : .white)
                    .font(.system(size: 20, weight: .medium))
            }
            Text(label.text)
                .lineLimit(1)
                .foregroundStyle(colorScheme == .dark ? .white : .black)
                .frame(maxWidth: .infinity, alignment: .leading)
        }.frame(maxWidth: .infinity, alignment: .leading)
    }
}

#Preview {
    About()
}
