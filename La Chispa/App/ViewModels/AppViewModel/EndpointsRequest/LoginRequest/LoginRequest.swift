//
//  LoginRequest.swift
//  La Chispa
//
//  Created by Pedro Omar  on 9/12/25.
//

import SwiftUI
import Combine

final class LoginRequests : ObservableObject {
    @Published var loginModel : LoginRequest = LoginRequest(username: "", password: "")
    @Published var loginResponse : LoginResponse = LoginResponse(id: "", created_at: "", updated_at: "", email: "", username: "", pubkey: "", external_id: "", extensions: [""], wallets: [""], admin: false, super_user: false, fiat_providers: [""], has_password: false, extra: Extra(email_verified: false, provider: "", visible_wallet_count: 10))
    
    @Published var isLoading : Bool = false
    @AppStorage("isAuth") var isAuth : Bool = false
    @Published var alertMsg : Bool = false
    
    @Published var message : String = ""
    
    let endpointApi = EndpointsApi.shared
    let defaults = UserDefaults.standard
    
    var isValid : Bool {
        loginModel.username.isEmpty || loginModel.password.isEmpty
    }
    
    @MainActor
    func loginRequest() {
        Task {
            DispatchQueue.main.async { [self] in isLoading = false }
            await loginRequestPrivate()
        }
    }
    
    @MainActor
    func loginRequestPrivate() async {
        await endpointApi.login(username: loginModel.username, password: loginModel.password) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case let .success(model):
                loginResponse = model
                loginModel.username = model.username
                isLoading = false
                isAuth = true
                
                if !isAuth {
                    if let encoded = try? JSONEncoder().encode(loginModel) {
                        defaults.set(encoded, forKey: "keyLoginRequest")
                    }
                }
            case let .failure(error):
                message = error.localizedDescription
                alertMsg = true
                isLoading = false
                print("ErrorGetLoginRequestPrivate: \(error.localizedDescription)")
            }
        }
    }
    
    @MainActor
    func closeSession() {
        self.loginModel = LoginRequest(username: "", password: "")
        if !isAuth {
            if let encoded = try? JSONEncoder().encode(LoginRequest(username: "", password: "")) {
                defaults.set(encoded, forKey: "keyLoginRequest")
            }
        }
        self.isLoading = false
        self.isAuth = false
    }
}
