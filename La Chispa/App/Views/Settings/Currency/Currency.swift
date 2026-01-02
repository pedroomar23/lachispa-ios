//
//  Currency.swift
//  La Chispa
//
//  Created by Pedro Omar  on 12/30/25.
//

import SwiftUI

struct Currency : View {
    
    @StateObject var loginRequest = LoginRequests()
    @Environment(\.colorScheme) var colorScheme
    @State var search: String = ""
    @State var names: [String] = ["CUP", "USD", "MLC"]
    
    @AppStorage("cup") var lastCurrency: String = "CUP"
    
    let currency = ["CUP", "USD", "MLC"]
    
    var body : some View {
        List {
            Picker("", selection: $lastCurrency) {
                ForEach(search.isEmpty ? currency : names, id: \.self) { text in
                    Text(currencyTitle(text)).tag(text)
                }
            }
            .labelsHidden()
            .pickerStyle(.inline)
        }
        .listStyle(.insetGrouped)
        .toolbar {
            _toolbar(label: LabelText(text: "Currency")) 
        }
        .searchable(text: $search, prompt: "Search")
        .onChange(of: search) { text in
            names = currency.filter { text in
                currency.description.hasPrefix(search)
            }
        }
    }
    
    @ToolbarContentBuilder
    private func _toolbar(label: LabelText) -> some ToolbarContent {
        ToolbarItem(placement: .principal) {
            Text(label.text)
                .fontWeight(.bold)
                .foregroundStyle(colorScheme == .dark ? .white : .black)
        }
    }
    
    private func currencyTitle(_ text: String) -> LocalizedStringKey {
        switch text {
        case "CUP":
            return "🇨🇺 CUP"
        case "USD":
            return "🇺🇸 USD"
        case "MLC":
            return "🏳️ MLC"
        default:
            return "🇨🇺 CUP"
        }
    }
}

#Preview {
    Currency()
}
