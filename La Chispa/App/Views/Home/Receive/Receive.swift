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
                VStack {
                    Section {
                        _invoice(response: loginRequest.getLNURLResponse)
                    }
                    Section {
                        NavigationLink {
                            ReceiveInvoice()
                        } label: {
                            _labelButton(label: LabelText(text: "Create Invoice"))
                        }
                        .sheet(isPresented: $loginRequest.isInvoice) {
                            ReceiveInvoice()
                        }
                        .alert("Error", isPresented: $loginRequest.alertMsg) {
                            
                        } message: {
                            Text(loginRequest.message)
                        }
                    }
                    Spacer()
                }
                .padding(.horizontal)
                .listRowBackground(Color.clear)
                .toolbar {
                    _titleView(label: LabelText(text: "Receive"))
                }
            }
        } else {
            VStack {
                Section {
                    _invoice(response: loginRequest.getLNURLResponse)
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
                            _labelButton(label: LabelText(text: "Create Invoice"))
                        }
                    }
                    .sheet(isPresented: $loginRequest.isInvoice) {
                        ReceiveInvoice()
                    }
                    .alert("Error", isPresented: $loginRequest.alertMsg) {
                        
                    } message: {
                        Text(loginRequest.message)
                    }
                }
               Spacer()
            }
            .padding(.horizontal)
            .listRowBackground(Color.clear)
            .toolbar {
                _titleView(label: LabelText(text: "Receive"))
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
                        loginRequest.generateQRCode(from: loginRequest.username)
                    }
            }
            HStack (spacing: 2) {
                Text("\(loginRequest.username)@lachispa.me")
                    .lineLimit(1)
                    .padding()
                Button {
                    _copy(text: loginRequest.username)
                    self.invoiceReceive.toggle()
                } label: {
                    Image(systemName: "document.on.document")
                        .foregroundStyle(colorScheme == .dark ? .white : .black)
                        .font(.system(size: 20, weight: .medium))
                }
                .buttonStyle(.plain)
                .alert("Payment Hash Copied", isPresented: $invoiceReceive) {
                    
                } message: {
                    Text("Your payment hash has been copied to clipboard")
                }
            }
        }
    }
    
    private func _copy(text: String) {
        UIPasteboard.general.string = loginRequest.username
    }
}

#Preview {
    Receive().environmentObject(LoginRequests())
}
