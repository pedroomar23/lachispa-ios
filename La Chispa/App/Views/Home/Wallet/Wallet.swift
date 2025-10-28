//
//  Home.swift
//  La Chispa
//
//  Created by Pedro Omar  on 9/16/25.
//

import SwiftUI

struct Wallet : View {
    
    @Environment(\.colorScheme) var colorScheme
    @StateObject var loginRequest = LoginRequests()
    
    var body : some View {
        ContentNavigation {
            ScrollView (.vertical, showsIndicators: false) {
                ForEach(loginRequest.loginAuth.wallets, id: \.id) { value in
                    Section {
                        VStack {
                            Text(value.name)
                                .font(.headline)
                                .padding(.top)
                            Text("Balance")
                                .font(.headline)
                                .foregroundStyle(colorScheme == .dark ? .white : .black)
                            Text("\(loginRequest.formatSats(value.balance_msat)) sats")
                                .font(.subheadline)
                                .font(.system(size: 40))
                                .foregroundStyle(colorScheme == .dark ? .white : .black)
                        }.padding(.top)
                    }
                    
                    Section {
                        HStack (alignment: .center, spacing: 1) {
                            NavigationLink {
                                InvoiceView()
                            } label: {
                                _label(label: LabelIcon(text: "invoice-view", icon: "arrow.up.forward"))
                            }
                            
                            NavigationLink {
                                CreatesInvoice()
                            } label: {
                                _label(label: LabelIcon(text: "invoice-receive", icon: "arrow.down.right"))
                            }
                        }
                    }
                  
                    Section {
                        VStack {
                            Text("Historial")
                                .fontWeight(.bold)
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .font(.title2)
                                .padding()
                            if loginRequest.historial.isEmpty {
                                _historialEmpty()
                            } else {
                                ForEach(loginRequest.getPayments, id: \.self) { value in
                                    NavigationLink {
                                        PaymentsList()
                                    } label: {
                                        _historial(value: value)
                                    }
                                    .padding()
                                    .background {
                                        RoundedRectangle(cornerRadius: 7, style: .continuous)
                                            .fill(Color(.tertiarySystemGroupedBackground))
                                    }
                                }
                            }
                        }.padding(.horizontal)
                    }
                }
            }
            .task {
                await loginRequest.getUserAuth()
            }
            .refreshable {
                await loginRequest.getUserAuth()
            }
            .environmentObject(loginRequest)
            .listRowBackground(Color.clear)
            .toolbar {
                _titleView(label: LabelIcon(text: "Wallet", icon: "chevron.down"))
            }
        }
    }
    
    @ToolbarContentBuilder
    private func _titleView(label: LabelIcon) -> some ToolbarContent {
        ToolbarItem(placement: .topBarLeading) {
            HStack (spacing: 5) {
                Text(label.text)
                    .font(.title)
                    .fontWeight(.bold)
                    .foregroundStyle(colorScheme == .dark ? .white : .black)
            }
        }
        
        ToolbarItem(placement: .topBarTrailing) {
            NavigationLink {
                Account()
            } label: {
                AsyncImage(url: URL(string: loginRequest.loginAuth.extra.picture ?? "")) { image in
                    image
                        .resizable()
                        .scaledToFit()
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                } placeholder: {
                    if loginRequest.isLoading {
                        ProgressView()
                            .progressViewStyle(CircularProgressViewStyle(tint: colorScheme == .dark ? .orange : .white))
                            .frame(width: 200, height: 45)
                    } else {
                        Image(systemName: "person.crop.circle")
                            .foregroundStyle(colorScheme == .dark ? .white : .black)
                            .font(.system(size: 20, weight: .medium))
                    }
                }
            }
        }
    }
    
    @ViewBuilder
    private func _labelIcon(label: Labels) -> some View {
        ZStack (alignment: .center) {
            RoundedRectangle(cornerRadius: 7, style: .continuous)
                .fill(colorScheme == .dark ? .black : .blue)
                .frame(width: 30, height: 30)
            Image(systemName: label.icon)
                .foregroundStyle(colorScheme == .dark ? .blue : .white)
                .font(.system(size: 20, weight: .medium))
        }
    }
    
    @ViewBuilder
    private func _historial(value: GetPayments) -> some View {
        HStack (alignment: .center, spacing: 12) {
            _labelIcon(label: Labels(icon: "bolt.fill"))
            VStack {
                Text("\(value.memo ?? "")")
                    .lineLimit(1)
                    .font(.headline)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .foregroundStyle(colorScheme == .dark ? .white : .black)
                Text("\(loginRequest.formatDate(value.created_at))")
                    .lineLimit(1)
                    .font(.subheadline)
                    .foregroundStyle(colorScheme == .dark ? .white : .gray)
                    .frame(maxWidth: .infinity, alignment: .leading)
            }
            Text("\(loginRequest.formatSats(value.amount))")
                .lineLimit(1)
                .foregroundStyle(colorScheme == .dark ? .white : .black)
                .frame(maxWidth: .infinity, alignment: .trailing)
        }.frame(maxWidth: .infinity, alignment: .leading)
    }
    
    @ViewBuilder
    private func _historialEmpty() -> some View {
        VStack {
            VStack {
                ZStack (alignment: .center) {
                    RoundedRectangle(cornerRadius: 10, style: .continuous)
                        .fill(colorScheme == .dark ? .black : .orange)
                        .frame(width: 30, height: 30)
                    Image(systemName: "archivebox")
                        .foregroundStyle(colorScheme == .dark ? .orange : .white)
                        .font(.system(size: 20, weight: .medium))
                }
                Text("Historial is Empty")
                    .lineLimit(1)
                    .font(.headline)
                    .frame(maxWidth: .infinity, alignment: .center)
                Text("Don't have payments in your historial")
                    .lineLimit(1)
                    .font(.subheadline)
                    .frame(maxWidth: .infinity, alignment: .center)
            }
            .padding(.horizontal)
            .background(Color(.tertiarySystemGroupedBackground), in: RoundedRectangle(cornerRadius: 7, style: .continuous))
        }
    }
    
    @ViewBuilder
    private func _label(label: LabelIcon) -> some View {
        HStack {
            Text(label.text)
                .font(.headline)
                .foregroundStyle(colorScheme == .dark ? .white : .white)
            Image(systemName: label.icon)
                .font(.headline)
                .foregroundStyle(colorScheme == .dark ? .white : .white)
        }
        .padding(.vertical)
        .frame(width: UIScreen.main.bounds.width - 260)
        .background(Color(colorScheme == .dark ? .gray : .blue))
        .clipShape(Capsule())
        .padding()
    }
}

#Preview {
    Wallet()
}
