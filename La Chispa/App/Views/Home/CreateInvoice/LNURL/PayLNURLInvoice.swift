//
//  PayLNURLInvoice.swift
//  La Chispa
//
//  Created by Pedro Omar  on 10/27/25.
//

import SwiftUI

struct PayLNURLInvoice : View {
    
    @StateObject var loginRequest = LoginRequests()
    @Environment(\.colorScheme) var colorScheme
    @Environment(\.dismiss) var dismiss
    
    let payment : PayLNURLResponse
    
    var body : some View {
        ContentNavigation {
            List {
                Section {
                    _preview(label: LabelIcon(text: "invoice-pay-success", icon: "checkmark.seal.fill"))
                }
                Section {
                    _getPayments(text: "Amount", icon: "card", value: "\(loginRequest.formatSats(payment.amount))")
                    _getPayments(text: "invoice-date", icon: "calendar", value: "\(loginRequest.formatDate(payment.time))")
                    _getPayments(text: "Hash", icon: "purchased", value: payment.payment_hash)
                    _getPayments(text: "Fee", icon: "staroflife.circle", value: "\(loginRequest.formatSats(payment.fee))")
                    _getPayments(text: "invoice-status", icon: "checkmark.rectangle.stack.fill", value: payment.status)
                }
            }
            .listStyle(.insetGrouped)
            .interactiveDismissDisabled()
            .toolbar {
                _toolbar(label: LabelIcon(text: "invoice-title-pay", icon: "xmark"))
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
    
    @ViewBuilder
    private func _getPayments(text: LocalizedStringKey, icon: String, value: String) -> some View {
        HStack (alignment: .center, spacing: 5) {
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

