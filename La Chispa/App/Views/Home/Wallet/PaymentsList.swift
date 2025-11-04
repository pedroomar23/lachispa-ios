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
    
    let getPayments : GetPayments
    
    var body : some View {
        List {
            Section {
                Section {
                    VStack {
                        Image(systemName: "checkmark.seal.fill")
                            .font(.system(size: 40, weight: .medium))
                            .foregroundStyle(colorScheme == .dark ? .green : .green)
                        Text("Invoice Created")
                            .font(.headline)
                            .padding(2)
                    }
                    .frame(maxWidth: .infinity, alignment: .center)
                    .listRowBackground(Color.clear)
                }
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
    
    @ViewBuilder
    private func _getInvoice(value: GetPayments) -> some View {
        Section {
            VStack {
                Image(systemName: "checkmark.seal.fill")
                    .font(.system(size: 40, weight: .medium))
                    .foregroundStyle(colorScheme == .dark ? .green : .green)
                Text("Invoice Created")
                    .font(.headline)
                    .padding(2)
            }
            .frame(maxWidth: .infinity, alignment: .center)
            .listRowBackground(Color.clear)
        }
        Section {
            HStack (alignment: .center, spacing: 5) {
                Image(systemName: "archivebox")
                    .font(.system(size: 18, weight: .medium))
                    .foregroundStyle(colorScheme == .dark ? .white : .black)
                Text("Amount")
                    .lineLimit(1)
                    .foregroundStyle(colorScheme == .dark ? .white : .black)
                    .frame(maxWidth: .infinity, alignment: .leading)
                Text("\(loginRequest.formatSats(value.amount))")
                    .lineLimit(1)
                    .foregroundStyle(colorScheme == .dark ? .white : .gray)
                    .frame(maxWidth: .infinity, alignment: .trailing)
            }.frame(maxWidth: .infinity, alignment: .leading)
            
            HStack (alignment: .center, spacing: 5) {
                Image(systemName: "calendar")
                    .font(.system(size: 18, weight: .medium))
                    .foregroundStyle(colorScheme == .dark ? .white : .black)
                Text("Created")
                    .lineLimit(1)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .foregroundStyle(colorScheme == .dark ? .white : .black)
                Text("\(loginRequest.formatDate(value.created_at))")
                    .lineLimit(1)
                    .frame(maxWidth: .infinity, alignment: .trailing)
                    .foregroundStyle(colorScheme == .dark ? .white : .gray)
            }.frame(maxWidth: .infinity, alignment: .leading)
            
            HStack (alignment: .center, spacing: 5) {
                Image(systemName: "point.bottomleft.forward.to.point.topright.scurvepath")
                    .font(.system(size: 18, weight: .medium))
                    .foregroundStyle(colorScheme == .dark ? .white : .black)
                Text("Hash")
                    .lineLimit(1)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .foregroundStyle(colorScheme == .dark ? .white : .black)
                Text(value.payment_hash)
                    .lineLimit(1)
                    .frame(maxWidth: .infinity, alignment: .trailing)
                    .foregroundStyle(colorScheme == .dark ? .white : .gray)
            }.frame(maxWidth: .infinity, alignment: .leading)
            
            HStack (alignment: .center, spacing: 5) {
                Image(systemName: "arrow.down.backward.and.arrow.up.forward.square")
                    .font(.system(size: 18, weight: .medium))
                    .foregroundStyle(colorScheme == .dark ? .white : .black)
                Text("Memo")
                    .lineLimit(1)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .foregroundStyle(colorScheme == .dark ? .white : .black)
                Text(value.memo ?? "")
                    .lineLimit(1)
                    .frame(maxWidth: .infinity, alignment: .trailing)
                    .foregroundStyle(colorScheme == .dark ? .white : .gray)
            }.frame(maxWidth: .infinity, alignment: .leading)
            
            HStack (alignment: .center, spacing: 5) {
                Image(systemName: "square.stack")
                    .font(.system(size: 18, weight: .medium))
                    .foregroundStyle(colorScheme == .dark ? .white : .black)
                Text("Estatus")
                    .lineLimit(1)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .foregroundStyle(colorScheme == .dark ? .white : .black)
                Text(value.status)
                    .lineLimit(1)
                    .frame(maxWidth: .infinity, alignment: .trailing)
                    .foregroundStyle(colorScheme == .dark ? .white : .gray)
            }.frame(maxWidth: .infinity, alignment: .leading)
        }
    }
}



