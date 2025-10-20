//
//  PaymentsList.swift
//  La Chispa
//
//  Created by Pedro Omar  on 10/14/25.
//

import SwiftUI

struct PaymentsList : View {
    
    @StateObject var loginRequest = LoginRequests()
    @Environment(\.colorScheme) var colorScheme 
    
    var body : some View {
        ContentNavigation {
            List {
                
            }
            .task {
                await loginRequest.getPayments()
            }
            .listStyle(.insetGrouped)
            .toolbar {
                _titleView(label: LabelText(text: "Lightning Invoice"))
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
    private func _getPayments(value: GetPayments) -> some View {
        Section {
            VStack {
                Image(systemName: "checkmark.seal.fill")
                    .font(.system(size: 40, weight: .medium))
                    .foregroundStyle(colorScheme == .dark ? .green : .green)
                Text("Pay Successfully")
                    .font(.headline)
                    .padding(2)
            }
            .frame(maxWidth: .infinity, alignment: .center)
            .listRowBackground(Color.clear)
        }
        Section {
            HStack (alignment: .center, spacing: 5) {
                Image(systemName: "archivebox")
                    .font(.system(size: 20, weight: .medium))
                    .foregroundStyle(colorScheme == .dark ? .white : .black)
                Text("Balance")
                    .lineLimit(1)
                    .foregroundStyle(colorScheme == .dark ? .white : .black)
                    .frame(maxWidth: .infinity, alignment: .leading)
                Text("\(loginRequest.formatSats(value.amount))")
                    .lineLimit(1)
                    .foregroundStyle(colorScheme == .dark ? .white : .gray)
                    .frame(maxWidth: .infinity, alignment: .trailing)
            }.frame(maxWidth: .infinity, alignment: .leading)
            
            HStack (alignment: .center, spacing: 5) {
                Image(systemName: "arrow.up.bin")
                    .font(.system(size: 20, weight: .medium))
                    .foregroundStyle(colorScheme == .dark ? .white : .black)
                Text("Fee")
                    .lineLimit(1)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .foregroundStyle(colorScheme == .dark ? .white : .black)
                Text("\(value.fee)")
                    .lineLimit(1)
                    .frame(maxWidth: .infinity, alignment: .trailing)
                    .foregroundStyle(colorScheme == .dark ? .white : .gray)
            }.frame(maxWidth: .infinity, alignment: .leading)
        }
    }
}

#Preview {
    PaymentsList()
}
