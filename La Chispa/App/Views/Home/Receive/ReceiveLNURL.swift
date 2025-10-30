//
//  ReceiveLNURL.swift
//  La Chispa
//
//  Created by Pedro Omar  on 10/29/25.
//

import SwiftUI

struct ReceiveLNURL : View {
    
    @StateObject var loginRequest = LoginRequests()
    @Environment(\.colorScheme) var colorScheme 
    
    var body : some View {
        if #available(iOS 16, *) {
            ContentNavigation {
                VStack {
                    Section {
                        HStack (spacing: 3) {
                            InvoiceTextfield(amount: loginRequest.payLNURL.amount, placeholder: "0")
                                .frame(height: 53)
                            Text("sats")
                                .padding()
                        }
                        .listRowSeparator(.hidden)
                       
                        MutiTextfield(text: $loginRequest.username, placeholder: "Ex payments or services")
                            .frame(height: 53)
                            .listRowSeparator(.hidden)
                    }
                    
                    Section {
                        Button {
                            loginRequest.payLNURLRequest()
                        } label: {
                            _labelButton(label: LabelText(text: "Create Invoice"))
                        }
                        .sheet(isPresented: $loginRequest.isLNURL) {
                            ReceiveLNURLs()
                        }
                        .alert("Error", isPresented: $loginRequest.alertMsg) {
                            
                        } message: {
                            Text(loginRequest.message)
                        }
                    }
                }
                .padding(.horizontal)
                .toolbar {
                    _toolbar(label: LabelText(text: "Create Invoice"))
                }
                
                Spacer()
            }
        } else {
            VStack {
                
            }
            .padding(.horizontal)
            .toolbar {
                _toolbar(label: LabelText(text: "Create Invoice"))
            }
            
            Spacer()
        }
    }
    
    @ToolbarContentBuilder
    private func _toolbar(label: LabelText) -> some ToolbarContent {
        ToolbarItem(placement: .principal) {
            Text(label.text)
                .font(.headline)
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
}

#Preview {
    ReceiveLNURL()
}
