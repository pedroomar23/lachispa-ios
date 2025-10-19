//
//  La_ChispaApp.swift
//  La Chispa
//
//  Created by Pedro Omar  on 9/10/25.
//

import SwiftUI

@main
struct La_ChispaApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    @Environment(\.scenePhase) var scenePhase
    
    @AppStorage("colorSchemeSelection") var colorSchemeSelection : UIUserInterfaceStyle = .unspecified
    
    @StateObject var loginRequest = LoginRequests()
    @StateObject var security = Security()
    @State var isUnlocked : Bool = false
    @AppStorage("timeOut") var timeOut = true
    @AppStorage("requirePasscode") var requirePasscode = "0"
    @State private var timerUnlock : Timer?
    
    var body: some Scene {
        WindowGroup {
            _getApplicationView()
                .environmentObject(security)
                .environmentObject(loginRequest)
                .preferredColorScheme(ColorScheme(colorSchemeSelection))
                .onChange(of: scenePhase) { scenePhase in
                    security.authenticate(scenePhase)
                }
                .fullScreenCover(isPresented: .constant(security.authenticated && !isUnlocked)) {
                    AuthenticationView(minutes: Int(requirePasscode)!, isUnlock: $isUnlocked)
                }
        }
    }
    
    @ViewBuilder
    func _getApplicationView() -> some View {
        if isUnlocked {
            AuthBiometric()
        } else if security.mostrar {
            Presentation()
        } else {
            Login()
        }
    }
}
