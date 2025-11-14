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
                        .frame(width: 70, height: 70)
                }.ignoresSafeArea(edges: .all)
            } else {
                ProgressBar(color: .blue)
                    .task {
                        loginRequest.generateQRCode(from: "\(loginRequest.getLNURLResponse.displayName)@lachispa.me")
                    }
            }
            HStack (spacing: 1) {
                Text("\(loginRequest.getLNURLResponse.displayName)@lachispa.me")
                    .foregroundStyle(colorScheme == .dark ? .white : .black)
                    .padding()
                Button {
                    self.invoiceReceive.toggle()
                    _copy(text: "\(loginRequest.getLNURLResponse.displayName)@lachispa.me")
                } label: {
                    Image(systemName: "document.on.document")
                        .font(.system(size: 14, weight: .medium))
                        .foregroundStyle(colorScheme == .dark ? .white : .black)
                }
                .padding()
                .buttonStyle(.plain)
                .alert("Lightning Address Copied", isPresented: $invoiceReceive) {
                    
                } message: {
                    Text("invoice-alert-copy")
                }
            }
            .background(Color(.tertiarySystemGroupedBackground), in: RoundedRectangle(cornerRadius: 10, style: .continuous))
            .padding()
            
            NavigationLink {
                ReceiveInvoice()
            } label: {
                _labelButton(label: LabelText(text: "invoice-request"))
            }
        }
        .frame(maxWidth: .infinity, alignment: .center)
        .listRowSeparator(.hidden)
    }
    
    private func _copy(text: String) {
        UIPasteboard.general.string = "\(loginRequest.getLNURLResponse.displayName)@lachispa.me"
    }
}

#Preview {
    Receive().environmentObject(LoginRequests())
}
