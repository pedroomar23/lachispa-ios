//
//  ReceiveLNURLs.swift
//  La Chispa
//
//  Created by Pedro Omar  on 10/29/25.
//

import SwiftUI

struct ReceiveLNURLs : View {
    
    @StateObject var loginRequest = LoginRequests()
    @Environment(\.colorScheme) var colorScheme
    @Environment(\.dismiss) var dismiss
    
    var body : some View {
        ContentNavigation {
            List {
                
            }
            .listStyle(.insetGrouped)
            .interactiveDismissDisabled()
            .toolbar {
                _toolbar(label: LabelIcon(text: "Invoice", icon: "xmark"))
            }
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
            Button {
                dismiss()
            } label: {
                Image(systemName: label.icon)
                    .font(.system(size: 20, weight: .medium))
                    .foregroundStyle(colorScheme == .dark ? .white : .black)
            }
        }
    }
}

#Preview {
    ReceiveLNURLs()
}
