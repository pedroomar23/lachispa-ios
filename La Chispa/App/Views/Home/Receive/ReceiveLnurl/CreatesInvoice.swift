//
//  CreatesInvoice.swift
//  La Chispa
//
//  Created by Pedro Omar  on 10/20/25.
//

import SwiftUI

struct CreatesInvoice : View {
    
    @StateObject var loginRequest = LoginRequests()
    @Environment(\.colorScheme) var colorScheme
    
    var body : some View {
        if #available(iOS 16, *) {
            if !loginRequest.isLNURL {
                ContentNavigation {
                    List {
                        HStack (spacing: 1) {
                            MutiTextfield(text: $loginRequest.username, placeholder: "login-username")
                                .frame(height: 53)
                                .padding(.horizontal)
                            Text("@lachispa.me")
                                .font(.headline)
                                .foregroundStyle(colorScheme == .dark ? .white : .black)
                        }
                        .listRowSeparator(.hidden)
                        
                        Button {
                            loginRequest.getLNURLRequest()
                        } label: {
                            if loginRequest.isLNURL {
                                ProgressBar(color: .blue)
                            } else {
                                _labelButton(label: LabelText(text: "invoice-lnurlconnect"))
                            }
                        }
                        .buttonStyle(.plain)
                        .alert("Error", isPresented: $loginRequest.alertMsg) {
                            
                        } message: {
                            Text(loginRequest.message)
                        }
                        .frame(maxWidth: .infinity, alignment: .center)
                        .listRowSeparator(.hidden)
                    }
                    .listStyle(.plain)
                    .listRowBackground(Color.clear)
                }
            } else {
                Receive().environmentObject(loginRequest)
            }
        } else {
            if !loginRequest.isLNURL {
                List {
                    HStack (spacing: 1) {
                        MutiTextfield(text: $loginRequest.username, placeholder: "login-username")
                            .frame(height: 53)
                            .padding(.horizontal)
                        Text("@lachispa.me")
                            .font(.headline)
                            .foregroundStyle(colorScheme == .dark ? .white : .black)
                    }
                    .listRowSeparator(.hidden)
                    
                    Button {
                        loginRequest.getLNURLRequest()
                    } label: {
                        if loginRequest.isLNURL {
                            ProgressBar(color: .blue)
                        } else {
                            _labelButton(label: LabelText(text: "invoice-lnurlconnect"))
                        }
                    }
                    .buttonStyle(.plain)
                    .alert("Error", isPresented: $loginRequest.alertMsg) {
                        
                    } message: {
                        Text(loginRequest.message)
                    }
                    .frame(maxWidth: .infinity, alignment: .center)
                    .listRowSeparator(.hidden)
                }
                .listStyle(.plain)
                .listRowBackground(Color.clear)
            } else {
                Receive().environmentObject(loginRequest)
            }
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
    CreatesInvoice()
}
