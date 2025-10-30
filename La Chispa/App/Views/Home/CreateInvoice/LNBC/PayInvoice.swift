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
    
    var body : some View {
        ContentNavigation {
            List {
                Section {
                    _titleView(label: LabelText(text: "invoice-pay-success"))
                }
                Section {
                    ForEach(loginRequest.getPayments, id: \.checking_id) { value in
                        if value.checking_id == loginRequest.getPayment {
                            _paymentResponse(response: value)
                        }
                    }
                }
            }
            .task {
                await loginRequest.getPayments()
            }
            .refreshable {
                await loginRequest.getPayments()
            }
            .toolbar {
                _toolbar()
            }
            .listStyle(.insetGrouped)
            .navigationBarTitle("invoice-title-pay", displayMode: .inline)
            .background {
                Color(.secondarySystemGroupedBackground).ignoresSafeArea(edges: .all)
            }
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
    private func _paymentResponse(response: GetPayments) -> some View {
        HStack (alignment: .center, spacing: 5) {
            Image(systemName: "calendar")
                .font(.system(size: 20, weight: .medium))
                .foregroundStyle(colorScheme == .dark ? .white : .black)
            Text("invoice-date")
                .lineLimit(1)
                .foregroundStyle(colorScheme == .dark ? .white : .black)
                .frame(maxWidth: .infinity, alignment: .leading)
            Text("\(loginRequest.formatDate(response.time))")
                .lineLimit(1)
                .foregroundStyle(colorScheme == .dark ? .white : .gray)
                .frame(maxWidth: .infinity, alignment: .trailing)
        }.frame(maxWidth: .infinity, alignment: .leading)
        
        HStack (alignment: .center, spacing: 5) {
            Image(systemName: "purchased")
                .font(.system(size: 20, weight: .medium))
                .foregroundStyle(colorScheme == .dark ? .white : .black)
            Text("Hash:")
                .lineLimit(1)
                .foregroundStyle(colorScheme == .dark ? .white : .black)
                .frame(maxWidth: .infinity, alignment: .leading)
            Text(response.payment_hash)
                .lineLimit(1)
                .foregroundStyle(colorScheme == .dark ? .white : .gray)
                .frame(maxWidth: .infinity, alignment: .trailing)
        }.frame(maxWidth: .infinity, alignment: .leading)
        
        HStack (alignment: .center, spacing: 5) {
            Image(systemName: "staroflife.circle")
                .font(.system(size: 20, weight: .medium))
                .foregroundStyle(colorScheme == .dark ? .white : .black)
            Text("Fee:")
                .lineLimit(1)
                .foregroundStyle(colorScheme == .dark ? .white : .black)
                .frame(maxWidth: .infinity, alignment: .leading)
            Text("\(loginRequest.formatSats(response.fee))")
                .lineLimit(1)
                .foregroundStyle(colorScheme == .dark ? .white : .gray)
                .frame(maxWidth: .infinity, alignment: .trailing)
        }.frame(maxWidth: .infinity, alignment: .leading)
        
        HStack (alignment: .center, spacing: 5) {
            Image(systemName: "checkmark.rectangle.stack.fill")
                .font(.system(size: 20, weight: .medium))
                .foregroundStyle(colorScheme == .dark ? .white : .black)
            Text("invoice-status")
                .lineLimit(1)
                .foregroundStyle(colorScheme == .dark ? .white : .black)
                .frame(maxWidth: .infinity, alignment: .leading)
            Text(response.status)
                .lineLimit(1)
                .foregroundStyle(colorScheme == .dark ? .white : .gray)
                .frame(maxWidth: .infinity, alignment: .trailing)
        }.frame(maxWidth: .infinity, alignment: .leading)
    }
}

#Preview {
    PayInvoice()
}
