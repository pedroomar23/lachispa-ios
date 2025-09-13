//
//  Security.swift
//  La Chispa
//
//  Created by Pedro Omar  on 9/12/25.
//

import SwiftUI
import Combine
import LocalAuthentication

final class Security : ObservableObject {
    @AppStorage("authenticated") var authenticated : Bool = false
    
    func authenticate(_ scenePhase: ScenePhase) {
        let context = LAContext()
        var error: NSError?
        
        if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error) {
            self.authenticated = true
        } else {
            self.authenticated = false
            print("FaceID Unavailable")
        }
    }
}
