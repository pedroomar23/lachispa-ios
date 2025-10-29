//
//  PayLNURLInvoice.swift
//  La Chispa
//
//  Created by Pedro Omar  on 10/27/25.
//

import SwiftUI

struct PayLNURLInvoice : View {
    
    @StateObject var loginRequet = LoginRequests()
    @Environment(\.colorScheme) var colorScheme
    @Environment(\.dismiss) var dismiss
    
    var body : some View {
        ContentNavigation {
            List {
                Section {
                    _preview(label: LabelIcon(text: "Pay Successfully", icon: "checkmark.seal.fill"))
                }
                
                Section {
                    
                }
            }
            .listStyle(.insetGrouped)
            .interactiveDismissDisabled()
            .toolbar {
                _toolbar(label: LabelIcon(text: "Payment Invoice", icon: "xmark"))
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
                    .font(.headline)
                    .foregroundStyle(colorScheme == .dark ? .white : .black)
            }
        }
    }
    
    @ViewBuilder
    private func _preview(label: LabelIcon) -> some View {
        VStack {
            Image(systemName: label.icon)
                .font(.system(size: 50, weight: .medium))
                .foregroundStyle(colorScheme == .dark ? .white : .blue)
                .padding(2)
            Text(label.text)
                .lineLimit(1)
                .font(.headline)
                .foregroundStyle(colorScheme == .dark ? .white : .black)
        }
        .frame(maxWidth: .infinity, alignment: .center)
        .listRowBackground(Color.clear)
    }
}

#Preview {
    PayLNURLInvoice()
}
