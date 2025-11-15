//
//  PaymentsList.swift
//  La Chispa
//
//  Created by Pedro Omar  on 10/14/25.
//

import SwiftUI

struct PaymentsList : View {
    
    @StateObject var loginRequest = LoginRequests()
    @Environment(\.colorScheme) var colorScheme
    @Environment(\.dismiss) var dismiss
    
    let getPayments : GetPayments
    
    var body : some View {
        if #available(iOS 16, *) {
            List {
                Section {
                    VStack {
                        Image(systemName: "checkmark.seal.fill")
                            .font(.system(size: 40, weight: .medium))
                            .foregroundStyle(colorScheme == .dark ? .blue : .blue)
                        Text("Invoice Created")
                            .font(.headline)
                            .padding(2)
                    }
                    .frame(maxWidth: .infinity, alignment: .center)
                    .listRowBackground(Color.clear)
                }
                Section {
                    _payDetails(text: "Amount", icon: "archivebox", value: "\(loginRequest.formatSats(getPayments.amount))")
                    _payDetails(text: "Created", icon: "calendar", value: "\(loginRequest.formatDate(getPayments.created_at))")
                    _payDetails(text: "Hash", icon: "point.bottomleft.forward.to.point.topright.scurvepath", value: getPayments.payment_hash)
                    _payDetails(text: "Memo", icon: "arrow.down.backward.and.arrow.up.forward.square", value: getPayments.memo ?? "")
                    _payDetails(text: "Status", icon: "square.stack", value: getPayments.status)
                }
            }
            .listStyle(.insetGrouped)
            .toolbar {
                _titleView(label: LabelText(text: "invoice-lightning"))
            }
        } else {
            List {
                Section {
                    VStack {
                        Image(systemName: "checkmark.seal.fill")
                            .font(.system(size: 40, weight: .medium))
                            .foregroundStyle(colorScheme == .dark ? .blue : .blue)
                        Text("Invoice Created")
                            .font(.headline)
                            .padding(2)
                    }
                    .frame(maxWidth: .infinity, alignment: .center)
                    .listRowBackground(Color.clear)
                }
                Section {
                    _payDetails(text: "Amount", icon: "archivebox", value: "\(loginRequest.formatSats(getPayments.amount))")
                    _payDetails(text: "Created", icon: "calendar", value: "\(loginRequest.formatDate(getPayments.created_at))")
                    _payDetails(text: "Hash", icon: "point.bottomleft.forward.to.point.topright.scurvepath", value: getPayments.payment_hash)
                    _payDetails(text: "Memo", icon: "arrow.down.backward.and.arrow.up.forward.square", value: getPayments.memo ?? "")
                    _payDetails(text: "Status", icon: "square.stack", value: getPayments.status)
                }
            }
            .listStyle(.insetGrouped)
            .toolbar {
                _toolbarIOS15(label: LabelIcon(text: "invoice-lightning", icon: "xmark"))
            }
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
    
    @ToolbarContentBuilder
    private func _toolbarIOS15(label: LabelIcon) -> some ToolbarContent {
        ToolbarItem(placement: .principal) {
            Text(label.text)
                .fontWeight(.bold)
                .foregroundStyle(colorScheme == .dark ? .white : .black)
        }
        ToolbarItem(placement: .topBarTrailing) {
            Button {
                dismiss()
            } label: {
                Image(systemName: label.icon)
                    .font(.system(size: 14, weight: .medium))
                    .foregroundStyle(colorScheme == .dark ? .white : .black)
            }
        }
    }
    
    @ViewBuilder
    private func _payDetails(text: String, icon: String, value: String) -> some View {
        HStack (alignment: .center, spacing: 5) {
            Image(systemName: icon)
                .font(.system(size: 18, weight: .medium))
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



