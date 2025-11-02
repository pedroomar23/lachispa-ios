//
//  Receive.swift
//  La Chispa
//
//  Created by Pedro Omar  on 9/21/25.
//

import SwiftUI

struct Receive : View {
    
    @EnvironmentObject var loginRequest: LoginRequests
    @Environment(\.colorScheme) var colorScheme
    @State var invoiceReceive : Bool = false
    
    var body : some View {
        if #available(iOS 16, *) {
            ContentNavigation {
                ScrollView (.vertical, showsIndicators: false) {
                    Section {
                        _invoice(response: loginRequest.getLNURLResponse)
                    }
                }
                .listStyle(.plain)
                .listRowBackground(Color.clear)
            }
        } else {
            ScrollView (.vertical, showsIndicators: false) {
                Section {
                    _invoice(response: loginRequest.getLNURLResponse)
                }
            }
            .listStyle(.plain)
            .listRowBackground(Color.clear)
        }
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
    private func _invoice(response: GetLNURLUsername) -> some View {
        VStack {
            if let qrImage = loginRequest.qrCodeImage {
                Image(uiImage: qrImage)
                    .resizable()
                    .interpolation(.none)
                    .scaledToFit()
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                    .frame(width: 300, height: 300)
            } else {
                ProgressBar(color: .blue)
                    .task {
                        loginRequest.generateQRCode(from: loginRequest.getLNURLResponse.callback)
                    }
            }
            VStack (spacing: 2) {
                Text("\(loginRequest.username)@lachispa.me")
                    .lineLimit(1)
                    .padding()
            }
        }
        .frame(maxWidth: .infinity, alignment: .center)
        .listRowSeparator(.hidden)
    }
    
    private func _copy(text: String) {
        UIPasteboard.general.string = loginRequest.getLNURLResponse.callback
    }
}

#Preview {
    Receive().environmentObject(LoginRequests())
}
