//
//  RInvoice.swift
//  La Chispa
//
//  Created by Pedro Omar  on 10/22/25.
//

import SwiftUI

struct RInvoice : View {
    
    @StateObject var loginRequest = LoginRequests()
    @Environment(\.colorScheme) var colorScheme
    @Environment(\.dismiss) var dismiss
    @State var alertMsg : Bool = false
    
    var body : some View {
        ContentNavigation {
            List {
                _invoiceResponse(response: loginRequest.paymentResponse)
            }
            .interactiveDismissDisabled()
            .listStyle(.insetGrouped)
            .toolbar {
                _toolbar(label: LabelIcon(text: "", icon: "xmark"))
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
                    .font(.system(size: 15, weight: .medium))
                    .foregroundStyle(colorScheme == .dark ? .white : .black)
            }
        }
    }
    
    @ViewBuilder
    private func _invoiceResponse(response: CreateInvoiceResponse) -> some View {
        Section {
            if let qrImage = loginRequest.qrCodeImage {
                ZStack (alignment: .center) {
                    Image(uiImage: qrImage)
                        .resizable()
                        .interpolation(.none)
                        .scaledToFit()
                        .clipShape(RoundedRectangle(cornerRadius: 10, style: .continuous))
                        .frame(width: 300, height: 300)
                   
                    Image("LaunchImage")
                        .resizable()
                        .interpolation(.none)
                        .scaledToFit()
                        .clipShape(Circle())
                        .frame(width: 60, height: 60)
                }.ignoresSafeArea(edges: .all)
            } else {
                ProgressBar(color: .blue)
                    .task {
                        loginRequest.generateQRCode(from: loginRequest.paymentbolt11)
                    }
            }
        }
        Section {
            HStack (spacing: 5) {
                Text("\(loginRequest.paymentbolt11)")
                    .lineLimit(1)
                Button {
                    self.alertMsg.toggle()
                    _copy(text: loginRequest.paymentbolt11)
                } label: {
                    Image(systemName: "document.on.document")
                        .font(.system(size: 20, weight: .medium))
                        .foregroundStyle(colorScheme == .dark ? .white : .black)
                }
                .buttonStyle(.plain)
                .alert("invoice-copy", isPresented: $alertMsg) {
                    
                } message: {
                    Text("invoice-alert-copy")
                }
            }
            .frame(maxWidth: .infinity, alignment: .center)
        }
    }
    
    private func _copy(text: String) {
        UIPasteboard.general.string = loginRequest.paymentbolt11
    }
}

#Preview {
    RInvoice()
}
