//
//  LNURL.swift
//  La Chispa
//
//  Created by Pedro Omar  on 10/27/25.
//

import SwiftUI

struct LNURL : View {
    
    @StateObject var loginRequest = LoginRequests()
    @Environment(\.colorScheme) var colorScheme
    @State var payLNURL : Bool = false
    
    var body : some View {
        if #available(iOS 16, *) {
            ContentNavigation {
                VStack {
                    HStack (spacing: 1) {
                        LNTextfield(text: $loginRequest.payLNURLs, placeholder: "invoice-bolt11")
                            .frame(height: 53)
                            .padding()
                        Button {
                            self.payLNURL.toggle()
                        } label: {
                            _qrLabel(label: LabelImage(text: "qrcode.viewfinder"))
                        }
                        .buttonStyle(.plain)
                        .fullScreenCover(isPresented: $payLNURL) {
                            QRCodeScannerController(scannedCode: $loginRequest.payLNURLs, errorMessage: $loginRequest.message)
                        }
                    }
                    
                    Button {
                        loginRequest.payLNURLRequest()
                    } label: {
                        if loginRequest.isLNURL {
                            ProgressBar(color: .blue)
                        } else {
                            _labelButton(label: LabelText(text: "Pay"))
                        }
                    }
                    .sheet(isPresented: $loginRequest.isLNURL) {
                        PayLNURLInvoice()
                    }
                    .disabled(loginRequest.invoiceEmpty || loginRequest.isLoading)
                    .opacity((!loginRequest.invoiceEmpty && !loginRequest.isLoading) ? 1.0 : 0.5)
                }
                .listRowBackground(Color.clear)
                .padding(.horizontal)
                Spacer()
            }
        } else {
            VStack {
                HStack (spacing: 1) {
                    LNTextfield(text: $loginRequest.payLNURLs, placeholder: "LNURL")
                        .frame(height: 53)
                        .padding()
                    Button {
                        self.payLNURL.toggle()
                    } label: {
                        _qrLabel(label: LabelImage(text: "qrcode"))
                    }
                    .buttonStyle(.plain)
                    .fullScreenCover(isPresented: $payLNURL) {
                        QRCodeScannerController(scannedCode: $loginRequest.payLNURLs, errorMessage: $loginRequest.message)
                    }
                }
                
                Button {
                    loginRequest.payLNURLRequest()
                } label: {
                    if loginRequest.isLNURL {
                        ProgressBar(color: .blue)
                    } else {
                        _labelButton(label: LabelText(text: "Pay"))
                    }
                }
                .disabled(loginRequest.invoiceEmpty || loginRequest.isLoading)
                .opacity((!loginRequest.invoiceEmpty && !loginRequest.isLoading) ? 1.0 : 0.5)
                .sheet(isPresented: $loginRequest.isLNURL) {
                    PayLNURLInvoice()
                }
            }
            .listRowBackground(Color.clear)
            .padding(.horizontal)
            Spacer()
        }
    }
    
    @ViewBuilder
    private func _qrLabel(label: LabelImage) -> some View {
        Image(systemName: label.text)
            .font(.system(size: 25, weight: .medium))
            .foregroundStyle(colorScheme == .dark ? .blue : .blue)
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
}

#Preview {
    LNURL()
}
