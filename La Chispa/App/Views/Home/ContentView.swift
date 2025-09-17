//
//  ContentView.swift
//  La Chispa
//
//  Created by Pedro Omar  on 9/10/25.
//

import SwiftUI

struct ContentView: View {
    
    @EnvironmentObject var loginRequest: LoginRequests
    @Environment(\.screenSize) var screenSize
    @Environment(\.colorScheme) var colorScheme
    @State var selectedTab : Int = 0
    
    var body : some View {
        GeometryReader { geo in
            if !loginRequest.isLoading {
                ProgressView("Loading...", value: 1.0)
                    .progressViewStyle(.circular)
                    .controlSize(.large)
                    .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
                    .environment(\.screenSize, geo.size)
                    .task {
                        loginRequest.loginRequest()
                    }
            } else {
                TabView(selection: $selectedTab) {
                    Wallet()
                        .tabItem {
                            Text(Tab.wallet.rawValue)
                            Image(systemName: Tab.wallet.sistemImage)
                        }
                        .tag(0)
                    Settings()
                        .tabItem {
                            Text(Tab.settings.rawValue)
                            Image(systemName: Tab.settings.sistemImage)
                        }
                        .tag(1)
                }.environment(\.screenSize, geo.size)
            }
        }
    }
    
    private enum Tab : LocalizedStringKey {
        case wallet = "Wallet"
        case settings = "Settings"
        
        var sistemImage : String {
            switch self {
            case .wallet: return "wallet.bifold"
            case .settings: return "gear"
            }
        }
    }
}

#Preview {
    ContentView().environmentObject(LoginRequests())
}
