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
        List {
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
                .listRowSeparator(.hidden)
            }
            
            Button {
                loginRequest.payLNURLRequest()
            } label: {
                if loginRequest.isLNURL {
                    ProgressBar(color: .blue)
                } else {
                    _labelButton(label: LabelText(text: "invoice-pay"))
                }
            }
            .buttonStyle(.plain)
            .sheet(isPresented: $loginRequest.isLNURL) {
                PayLNURLInvoice()
            }
            .listRowSeparator(.hidden)
            .frame(maxWidth: .infinity, alignment: .center)
        }
        .listStyle(.plain)
        .listRowBackground(Color.clear)
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
