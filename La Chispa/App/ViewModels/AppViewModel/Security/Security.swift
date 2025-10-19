//
//  Security.swift
//  La Chispa
//
//  Created by Pedro Omar  on 9/12/25.
//

import SwiftUI
import Combine
import StoreKit
import LocalAuthentication

final class Security : ObservableObject {
    
    @Published var isUnlocked : Bool = false
    @AppStorage("authenticated") var authenticated : Bool = false
    @AppStorage("mostrar") var mostrar : Bool = true 
    
    init() {
        
        let context = LAContext()
        
        /// Manejar Errores
        var error: NSError?
        
        if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error) {
            self.isUnlocked = true
        } else {
            self.isUnlocked = false
            self.authenticated = false
        }
    }
    
    func authenticate(_ scenePhase: ScenePhase) {
        let context = LAContext()
        var error: NSError?
        
        if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error) {
            self.isUnlocked = true
        } else {
            self.isUnlocked = false
            self.authenticated = false 
            print("FaceID Unavailable")
        }
    }
    
    func requestAppReview() {
        if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene {
            SKStoreReviewController.requestReview(in: windowScene)
        }
    }
}
