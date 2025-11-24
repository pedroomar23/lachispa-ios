//
//  CreateInvoice.swift
//  La Chispa
//
//  Created by Pedro Omar  on 9/21/25.
//

import SwiftUI

struct Invoice : View {
    
    @StateObject var loginRequest = LoginRequests()
    @Environment(\.colorScheme) var colorScheme
    @State var qrCode : Bool = false
    
    let paymentsUnit = ["sat", "AED", "AFN", "ALL", "AMD", "ANG"]
    
    var body: some View {
        List {
            Section {
                HStack (alignment: .center, spacing: 1) {
                    LNTextfield(text: $loginRequest.paymentbolt11, placeholder: "invoice-bolt11")
                        .frame(height: 53)
                        .padding()
                    Button {
                        self.qrCode.toggle()
                    } label: {
                        _labelIcon(label: Labels(icon: "qrcode.viewfinder"))
                    }
                    .buttonStyle(.plain)
                    .fullScreenCover(isPresented: $qrCode) {
                        QRCodeScannerController(scannedCode: $loginRequest.paymentbolt11, errorMessage: $loginRequest.message)
                    }
                }.listRowSeparator(.hidden)
            }
            Section {
                Button {
                    loginRequest.paymetsRequest()
                } label: {
                    if loginRequest.isLoading {
                        ProgressView()
                            .progressViewStyle(CircularProgressViewStyle(tint: colorScheme == .dark ? .orange : .white))
                            .frame(width: 200, height: 45)
                    } else {
                        _labelButton(label: LabelText(text: "invoice-pay"))
                    }
                }
                .buttonStyle(.plain)
                .sheet(isPresented: $loginRequest.isInvoice) {
                    PayInvoice(getPayments: loginRequest.paymentResponse)
                }
                .alert("Error", isPresented: $loginRequest.alertMsg) {
                    
                } message: {
                    Text(loginRequest.message)
                }
                .disabled(loginRequest.invoiceEmpty || loginRequest.isLoading)
                .opacity((!loginRequest.invoiceEmpty && !loginRequest.isLoading) ? 1.0 : 0.5)
                .frame(maxWidth: .infinity, alignment: .center)
                .listRowSeparator(.hidden)
            }
        }
        .listStyle(.plain)
        .listRowBackground(Color.clear)
    }
    
    @ViewBuilder
    private func _labelButton(label: LabelText) -> some View {
        Text(label.text)
            .font(.headline)
            .foregroundColor(.white)
            .padding(.vertical)
            .frame(width: UIScreen.main.bounds.width - 150)
            .background(Color(colorScheme == .dark ? .gray : .blue))
            .clipShape(Capsule())
            .padding()
    }
    
    @ViewBuilder
    private func _labelIcon(label: Labels) -> some View {
        Image(systemName: label.icon)
            .foregroundStyle(colorScheme == .dark ? .blue : .blue)
            .font(.system(size: 25, weight: .medium))
    }
    
    private func unitTitle(_ title: String) -> LocalizedStringKey {
        switch title {
        case "sat":
            return "sat"
        case "AED":
            return "AED"
        case "AFN":
            return "AFN"
        case "ALL":
            return "ALL"
        case "AMD":
            return "AMD"
        case "ANG":
            return "ANG"
        default:
            return "sat"
        }
    }
}

#Preview {
    Invoice()
}
