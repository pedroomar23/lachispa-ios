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
                Section {
                    HStack (spacing: 3) {
                        InvoiceTextfield(amount: loginRequest.createInvoice.amount, placeholder: "0")
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
                        loginRequest.invoiceRequest()
                    } label: {
                        if loginRequest.isInvoice {
                            ProgressBar(color: .blue)
                        } else {
                            _labelButton(label: LabelText(text: "Solicitar Monto"))
                        }
                    }
                    .buttonStyle(.plain)
                    .sheet(isPresented: $loginRequest.isInvoice, content: {
                        RInvoice()
                    })
                    .alert("Error", isPresented: $loginRequest.alertMsg) {
                        
                    } message: {
                        Text(loginRequest.message)
                    }
                    .frame(maxWidth: .infinity, alignment: .center)
                    .listRowSeparator(.hidden)
                }
            }
            .listStyle(.plain)
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
    ReceiveInvoice()
}
