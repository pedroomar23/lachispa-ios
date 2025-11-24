//
//  ContentView.swift
//  La Chispa
//
//  Created by Pedro Omar  on 9/10/25.
//

import SwiftUI

struct ContentView : View {
    
    @EnvironmentObject var loginRequest : LoginRequests
    @Environment(\.screenSize) var screenSize
    @StateObject var security = Security()
    @StateObject var swapRequest = BoltzRequest()
    @Environment(\.colorScheme) var colorScheme
    @State var selectedTab : Int = 0
    
    var body : some View {
        GeometryReader { geo in
            if loginRequest.isLoading {
                ProgressView("wallet-progress", value: 1.0)
                    .progressViewStyle(.circular)
                    .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
                    .task {
                        await loginRequest.getUserAuth()
                    }
            } else {
                ZStack {
                    LinearGradient(colors: [.blue.opacity(0.4), .purple.opacity(0.4)],
                                   startPoint: .topLeading,
                                   endPoint: .bottomTrailing)
                    .ignoresSafeArea()
                    TabView(selection: $selectedTab) {
                        Wallet()
                            .tabItem {
                                VStack {
                                    Image(systemName: Tab.wallet.sistemImage)
                                        .symbolRenderingMode(.hierarchical)
                                        .background(.ultraThinMaterial)
                                        .clipShape(RoundedRectangle(cornerRadius: 10))
                                    Text(Tab.wallet.rawValue)
                                }
                            }
                            .tag(0)
                            .environmentObject(loginRequest)
                            /*
                        Swap()
                            .tabItem {
                                Image(systemName: Tab.swap.sistemImage)
                                Text(Tab.swap.rawValue)
                            }
                            .tag(1)
                            .environmentObject(swapRequest)
                             */
                        Settings()
                            .tabItem {
                                VStack {
                                    Image(systemName: Tab.settings.sistemImage)
                                        .symbolRenderingMode(.hierarchical)
                                        .background(.ultraThinMaterial)
                                        .clipShape(RoundedRectangle(cornerRadius: 10))
                                    Text(Tab.settings.rawValue)
                                }
                            }
                            .tag(2)
                            .environmentObject(security)
                    }
                    .environment(\.screenSize, geo.size)
                    .accentColor(colorScheme == .dark ? .white : .blue)
                    .background(.regularMaterial)
                }
            }
        }
    }
    
    private enum Tab : LocalizedStringKey {
        case wallet = "wallet-view"
        case swap = "Swap"
        case settings = "wallet-settings"
        
        var sistemImage : String {
            switch self {
            case .wallet:
                if #available(iOS 16, *) {
                    return "wallet.bifold"
                } else {
                    return "creditcard"
                }
            case .swap: return "arrow.up.arrow.down"
            case .settings: return "gearshape"
            }
        }
    }
    
    @ViewBuilder
    private func _labelButton(label: LabelText) -> some View {
        Text(label.text)
            .font(.headline)
            .foregroundColor(.white)
            .padding(.vertical)
            .frame(width: UIScreen.main.bounds.width - 250)
            .background(Color(colorScheme == .dark ? .gray : .blue))
            .clipShape(Capsule())
            .padding()
    }
}

#Preview {
    ContentView().environmentObject(LoginRequests())
}
