//
//  ReceiveInvoice.swift
//  La Chispa
//
//  Created by Pedro Omar  on 10/14/25.
//

import SwiftUI

struct ReceiveInvoice : View {
    
    @StateObject var loginRequest = LoginRequests()
    @Environment(\.colorScheme) var colorScheme
    @Environment(\.dismiss) var dismiss
    @State var paymentInvoice : Bool = false
    
    var body : some View  {
        ContentNavigation {
            List {
               _invoiceReceive()
            }
            .listStyle(.insetGrouped)
            .interactiveDismissDisabled()
            .background {
                Color(.secondarySystemGroupedBackground).ignoresSafeArea(edges: .all)
            }
            .toolbar {
                _toolbar()
            }
        }
    }
    
    @ToolbarContentBuilder
    private func _toolbar() -> some ToolbarContent {
        ToolbarItem(placement: .principal) {
            Text("Invoice")
                .fontWeight(.bold)
                .foregroundStyle(colorScheme == .dark ? .white : .black)
        }
        ToolbarItem(placement: .topBarTrailing) {
            Button {
                dismiss()
            } label: {
                ZStack (alignment: .center) {
                    RoundedRectangle(cornerRadius: 15, style: .continuous)
                        .fill(Color(.tertiarySystemGroupedBackground))
                        .frame(width: 60, height: 40)
                    Text("Done")
                        .fontWeight(.bold)
                        .foregroundStyle(colorScheme == .dark ? .blue : .blue)
                }
            }
        }
    }
    
    @ViewBuilder
    private func _invoiceReceive() -> some View {
        VStack {
            AsyncImage(url: URL(string: loginRequest.paymentResponse.preimage))
            HStack (spacing: 2) {
                Text("\(loginRequest.paymentResponse.payment_hash)")
                Button {
                    _copy(text: loginRequest.paymentbolt11)
                    self.paymentInvoice.toggle()
                } label: {
                    Image(systemName: "document.on.document")
                        .foregroundStyle(colorScheme == .dark ? .white : .black)
                        .font(.system(size: 20, weight: .medium))
                }
                .buttonStyle(.plain)
                .alert("Payment Hash Copied", isPresented: $paymentInvoice) {
                    
                } message: {
                    Text("Your payment hash has been copied to clipboard")
                }
            }
        }
    }
    
    private func _copy(text: String) {
        UIPasteboard.general.string = loginRequest.paymentbolt11
    }
}

#Preview {
    ReceiveInvoice()
}
