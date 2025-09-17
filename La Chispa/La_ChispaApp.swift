//
//  La_ChispaApp.swift
//  La Chispa
//
//  Created by Pedro Omar  on 9/10/25.
//

import SwiftUI

@main
struct La_ChispaApp: App {
    
    @Environment(\.scenePhase) var scenePhase
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    
    @StateObject var security = Security()
   
    var body: some Scene {
        WindowGroup {
            _getApplicationView()
                .environmentObject(security)
        }
    }
    
    @ViewBuilder
    private func _getApplicationView() -> some View {
        Login()
    }
}
