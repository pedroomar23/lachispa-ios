//
//  PayInvoice.swift
//  La Chispa
//
//  Created by Pedro Omar  on 10/15/25.
//

import SwiftUI

struct PayInvoice : View {
    
    @StateObject var loginRequest = LoginRequests()
    @Environment(\.colorScheme) var colorScheme
    @Environment(\.dismiss) var dismiss
    
    let getPayments : CreateInvoiceResponse
    
    var body : some View {
        ContentNavigation {
            List {
                Section {
                    _titleView(label: LabelText(text: "invoice-pay-success"))
                }
                Section {
                    _getPayments(text: "Amount", icon: "card", value: "\(loginRequest.formatSats(getPayments.amount))")
                    _getPayments(text: "invoice-date", icon: "calendar", value: "\(loginRequest.formatDate(getPayments.time))")
                    _getPayments(text: "Hash", icon: "purchased", value: getPayments.payment_hash)
                    _getPayments(text: "Fee", icon: "staroflife.circle", value: "\(loginRequest.formatSats(getPayments.fee))")
                    _getPayments(text: "invoice-status", icon: "checkmark.rectangle.stack.fill", value: getPayments.status)
                }
            }
            .toolbar {
                _toolbar()
            }
            .listStyle(.insetGrouped)
            .navigationBarTitle("invoice-title-pay", displayMode: .inline)
            .interactiveDismissDisabled()
        }
    }
    
    @ToolbarContentBuilder
    private func _toolbar() -> some ToolbarContent {
        ToolbarItem(placement: .topBarTrailing) {
            Button {
                dismiss()
            } label: {
                Image(systemName: "xmark")
                    .font(.system(size: 20, weight: .medium))
                    .foregroundStyle(colorScheme == .dark ? .white : .black)
            }
        }
    }
    
    @ViewBuilder
    private func _titleView(label: LabelText) -> some View {
        VStack {
            Image(systemName: "checkmark.seal.fill")
                .font(.system(size: 40, weight: .medium))
                .foregroundStyle(colorScheme == .dark ? .blue : .blue)
                .padding(2)
            Text(label.text)
                .lineLimit(1)
                .font(.headline)
                .frame(maxWidth: .infinity, alignment: .center)
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


