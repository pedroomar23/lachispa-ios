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
                Section {
                    VStack {
                        VStack {
                            Text("Balance")
                                .font(.headline)
                            Text("\(loginRequest.loginAuth.wallets.first?.balance_msat ?? 0) sats")
                                .font(.subheadline)
                                .font(.system(size: 30))
                        }
                    }.padding(.top)
                }
                
                Section {
                    HStack (alignment: .center, spacing: 1) {
                        NavigationLink {
                            CreateInvoice()
                        } label: {
                            _label(label: LabelIcon(text: "Send", icon: "arrow.up.forward"))
                        }
                        
                        NavigationLink {
                            Receive()
                        } label: {
                            _label(label: LabelIcon(text: "Receive", icon: "arrow.down.right"))
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
                        ForEach(loginRequest.historial, id: \.self) { value in
                            Label {
                                VStack {
                                    HStack(spacing: 5) {
                                        Text("Payment")
                                            .lineLimit(1)
                                            .font(.headline)
                                            .frame(maxWidth: .infinity, alignment: .leading)
                                            .foregroundStyle(colorScheme == .dark ? .white : .black)
                                        Text(value.date)
                                            .lineLimit(1)
                                            .font(.subheadline)
                                            .frame(maxWidth: .infinity, alignment: .leading)
                                        Text("\(value.spending)")
                                            .lineLimit(1)
                                            .frame(maxWidth: .infinity, alignment: .trailing)
                                    }
                                }
                            } icon: {
                                _labelImage(label: Labels(icon: "bolt"))
                            }
                            .padding()
                            .background { RoundedRectangle(cornerRadius: 7, style: .continuous).fill(Color(.tertiarySystemGroupedBackground)) }
                        }
                    }.padding(.horizontal)
                }
            }
            .environmentObject(loginRequest)
            .listRowBackground(Color.clear)
            .toolbar {
                _titleView(label: LabelIcon(text: "Wallets", icon: "chevron.down"))
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
                Menu {
                    ForEach(loginRequest.loginAuth.wallets, id: \.self) { value in
                        Text("LaChispa Wallet \(value.name)")
                    }
                } label: {
                    Image(systemName: label.icon)
                        .foregroundStyle(colorScheme == .dark ? .white : .black)
                        .font(.system(size: 10, weight: .bold))
                }
            }
        }
        
        ToolbarItem(placement: .topBarTrailing) {
            NavigationLink {
                Account()
            } label: {
                Image(systemName: "person.crop.circle")
                    .foregroundStyle(colorScheme == .dark ? .white : .black)
                    .font(.system(size: 20))
            }
        }
    }
    
    @ViewBuilder
    private func _labelImage(label: Labels) -> some View {
        ZStack (alignment: .center) {
            RoundedRectangle(cornerRadius: 7, style: .continuous)
                .fill(colorScheme == .dark ? .black : .orange)
                .frame(width: 30, height: 30)
            Image(systemName: label.icon)
                .foregroundStyle(colorScheme == .dark ? .orange : .white)
                .font(.system(size: 20, weight: .medium))
        }
    }
    
    @ViewBuilder
    private func _label(label: LabelIcon) -> some View {
        HStack {
            Text(label.text)
                .font(.headline)
                .foregroundStyle(colorScheme == .dark ? .orange : .white)
            Image(systemName: label.icon)
                .font(.headline)
                .foregroundStyle(colorScheme == .dark ? .orange : .white)
        }
        .padding(.vertical)
        .frame(width: UIScreen.main.bounds.width - 260)
        .background(Color(colorScheme == .dark ? .gray : .orange))
        .clipShape(Capsule())
        .padding()
    }
}

#Preview {
    Wallet()
}
