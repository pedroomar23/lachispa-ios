//
//  RegisterRequest.swift
//  La Chispa
//
//  Created by Pedro Omar  on 9/12/25.
//

import SwiftUI
import Combine

@MainActor
final class Register : ObservableObject {
    @Published var registerRequest : RegisterRequest = RegisterRequest(email: "", username: "", password: "", password_repeat: "")
    @Published var registerResponse : RegisterResponse = RegisterResponse(access_token: "", token_type: "")
    
    @Published var isLoading : Bool = false
    @Published var isRegister : Bool = false
    @Published var registerMsg : String = "Your register in the LaChispa has been successfully"
    @Published var message : String = ""
    @Published var alertMsg : Bool = false
    
    let endpointApi = EndpointsApi.shared
    
    var isValid : Bool {
        return registerRequest.username.isEmpty || registerRequest.password.isEmpty || registerRequest.password_repeat.isEmpty
    }
    
    // MARK: - Register
    
    func registersRequest() {
        Task {
            DispatchQueue.main.async { [self] in isLoading = false }
            await registerRequetPrivate()
        }
    }
    
    func registerRequetPrivate() async {
        await endpointApi.register(email: registerRequest.email, username: registerRequest.username, password: registerRequest.password, password_repeat: registerRequest.password_repeat) { result in
            DispatchQueue.main.async { [self] in
                switch result {
                case let .success(model):
                    registerResponse = model
                    isLoading = false
                    isRegister = true
                case let .failure(error):
                    message = error.localizedDescription
                    alertMsg = true
                    isLoading = false
                    print("ErrorGetRegisterprivate: \(error.localizedDescription)")
                }
            }
        }
    }
}
