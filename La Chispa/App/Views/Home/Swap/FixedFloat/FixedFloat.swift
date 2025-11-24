//
//  FixedFloat.swift
//  La Chispa
//
//  Created by Pedro Omar  on 10/26/25.
//

import SwiftUI

struct FixedFloat : View {
    
    @StateObject var ffRequet = FFRequest()
    @Environment(\.colorScheme) var colorScheme
    
    var body : some View {
        if #available(iOS 16, *) {
            ScrollView (.vertical, showsIndicators: false) {
                LazyVStack {
                    Section {
                        HStack {
                            VStack {
                                Text("Send")
                                    .font(.headline)
                                    .foregroundStyle(colorScheme == .dark ? .white : .black)
                                    .frame(maxWidth: .infinity, alignment: .leading)
                                ZStack {
                                    InvoiceTextfield(text: $ffRequet.amount, placeholder: "Amount")
                                        .frame(height: 55)
                                }
                            }
                            Image(systemName: "arrow.left.arrow.right")
                                .font(.system(size: 20, weight: .medium))
                                .foregroundStyle(colorScheme == .dark ? .white : .black)
                                .padding()
                            VStack {
                                Text("Receive")
                                    .font(.headline)
                                    .foregroundStyle(colorScheme == .dark ? .white : .black)
                                    .frame(maxWidth: .infinity, alignment: .leading)
                                ZStack {
                                    InvoiceTextfield(text: $ffRequet.amount, placeholder: "Receive")
                                        .frame(height: 55)
                                }
                            }
                        }.padding(.horizontal)
                    }
                    Section {
                        ZStack {
                            InvoiceTextfield(text: $ffRequet.direction, placeholder: "Direction")
                                .frame(height: 55)
            
                            Button {
                                
                            } label: {
                                Image(systemName: "qrcode")
                                    .font(.system(size: 20, weight: .medium))
                                    .foregroundStyle(colorScheme == .dark ? .white : .black)
                                    .frame(maxWidth: .infinity, alignment: .trailing)
                            }
                            .buttonStyle(.plain)
                            .padding()
                        }.padding()
                    }
                    Section {
                        Button {
                            
                        } label: {
                            
                        }
                    }
                }
            }
        } else {
            List {
                Section {
                    HStack {
                        VStack {
                            Text("Send")
                                .font(.headline)
                                .foregroundStyle(colorScheme == .dark ? .white : .black)
                                .frame(maxWidth: .infinity, alignment: .leading)
                            ZStack {
                                InvoiceTextfield(text: $ffRequet.amount, placeholder: "Amount")
                                    .frame(height: 55)
                            }
                        }
                        Image(systemName: "arrow.left.arrow.right")
                            .font(.system(size: 20, weight: .medium))
                            .foregroundStyle(colorScheme == .dark ? .white : .black)
                            .padding()
                        VStack {
                            Text("Receive")
                                .font(.headline)
                                .foregroundStyle(colorScheme == .dark ? .white : .black)
                                .frame(maxWidth: .infinity, alignment: .leading)
                            ZStack {
                                InvoiceTextfield(text: $ffRequet.amount, placeholder: "Receive")
                                    .frame(height: 55)
                            }
                        }
                    }.padding(.horizontal)
                }
                Section {
                    ZStack {
                        InvoiceTextfield(text: $ffRequet.direction, placeholder: "Direction")
                            .frame(height: 55)
        
                        Button {
                            
                        } label: {
                            Image(systemName: "qrcode")
                                .font(.system(size: 20, weight: .medium))
                                .foregroundStyle(colorScheme == .dark ? .white : .black)
                                .frame(maxWidth: .infinity, alignment: .trailing)
                        }
                        .buttonStyle(.plain)
                        .padding()
                    }.padding()
                }
                Section {
                    Button {
                        
                    } label: {
                        
                    }
                }
            }
            .listStyle(.plain)
        }
    }
}

#Preview {
    FixedFloat()
}
