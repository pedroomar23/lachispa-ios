//
//  AuthBiometric.swift
//  La Chispa
//
//  Created by Pedro Omar  on 9/12/25.
//

import SwiftUI
import LocalAuthentication

struct AuthBiometric : View {
    
    @StateObject var security = Security()
    @State var isActive : Bool = false
    @State private var size = 0.8
    @State private var opacity = 0.5
    
    var body : some View {
        Group {
            if !isActive {
                VStack {
                    Image("LaunchImage")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 100)
                        .cornerRadius(100)
                        .clipShape(Circle())
                }
            } else {
                ContentView()
            }
        }
        .environmentObject(security)
        .task {
            splashAnimation()
        }
    }
    
    private func splashAnimation() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
            withAnimation(.easeIn(duration: 1.2)) {
                self.size = 0.9
                self.opacity = 1.00
            }
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                withAnimation {
                    self.isActive = true
                }
            }
        }
    }
}

struct AuthenticationView : View {
    
    @StateObject var security = Security()
    @State var minutes : Int
    @Binding var isUnlock : Bool
    
    var body : some View {
        Group {
            VStack(spacing: 20) {
                if security.authenticated {
                    Image(systemName: "lock.fill")
                        .font(.system(size: 50))
                        .foregroundColor(.accentColor)
                    Text("settings-biometric-locked")
                        .font(.headline)
                } else {
                    Image(systemName: "lock.open.fill")
                        .font(.system(size: 50))
                        .foregroundColor(.accentColor)
                    Text("settings-biometric-unlocked")
                        .font(.headline)
                }
                
               Text("settings-auth-message")
                    .font(.subheadline)
                    .multilineTextAlignment(.center)
                    .foregroundColor(.secondary)
                    .padding(.horizontal)
                
                Spacer(minLength: 50)
                
                Button {
                    requestUnlock { result in
                        isUnlock = result
                    }
                } label: {
                    Text("settings-auth-button")
                        .font(.headline)
                        .foregroundColor(.white)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.accentColor)
                        .cornerRadius(10)
                }
            }
            .padding()
            .onAppear {
                requestUnlock { result in
                    isUnlock = result
                }
            }
            .environmentObject(security)
        }
    }
    
    private func hasPassedMoreThan(_ minutes: Int, suiteName: String) -> Bool {
        guard let userDefaults = UserDefaults(suiteName: "com.app.LaChispa"),
              let openedAt = userDefaults.object(forKey: "appOpenedAt") as? Date,
              let closedAt = userDefaults.object(forKey: "appClosedAt") as? Date else {
            print("Paso time: no")
            print("No se pudieron recuperar las fechas de apertura o cierre.")
            return false
        }
        
        let elapsedTime = openedAt.timeIntervalSince(closedAt)
        let elapsedTimeInSeconds = elapsedTime // El tiempo ya está en segundos
        let timeLimitInSeconds = Double(minutes) * 60 // Convertimos el tiempo límite a segundos
        
        print("Paso time:", elapsedTimeInSeconds, timeLimitInSeconds)
        return elapsedTimeInSeconds > timeLimitInSeconds
    }
    
    private func requestUnlock(completionHandler: @escaping (Bool) -> Void) {
        if !hasPassedMoreThan(minutes, suiteName: "") {
            completionHandler(true)
            return
        }
        authenticate { success, error in
            if success {
                // La autenticación fue exitosa, se retorna true.
                completionHandler(true)
            } else {
                // Autenticación fallida, se maneja el error aquí.
                if let error = error {
                    print("Error: \(error.localizedDescription)")
                }
                // Se retorna false debido a que la autenticación falló.
                completionHandler(false)
            }
        }
    }
    
    private func authenticate(completion: @escaping (Bool, Error?) -> Void) {
        let context = LAContext()
        var error: NSError?
        
        if context.canEvaluatePolicy(.deviceOwnerAuthentication, error: &error) {
            let reason = "Utilizar Face ID o huella dactilar para desbloquear"
            context.evaluatePolicy(.deviceOwnerAuthentication, localizedReason: reason) { success, authenticationError in
                DispatchQueue.main.async {
                    completion(success, authenticationError)
                }
            }
        } else {
            // Manejar el caso cuando no hay biometría configurada
            if let error = error, error.code == LAError.passcodeNotSet.rawValue {
                // Aquí puedes decidir si tratas este caso como un éxito o no
                completion(true, nil) // Por ejemplo, considerarlo como autenticación exitosa
            } else {
                // Otros errores
                let customError = NSError(domain: "com.example.app", code: -1, userInfo: [NSLocalizedDescriptionKey: "Biometric authentication not available"])
                completion(false, customError)
            }
        }
    }
}
