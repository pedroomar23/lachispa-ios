//
//  RegisterRequest.swift
//  La Chispa
//
//  Created by Pedro Omar  on 9/12/25.
//

import SwiftUI
import Combine

final class Register : ObservableObject {
    @Published var registerRequest : RegisterRequest = RegisterRequest(email: "", username: "", password: "", password_repeat: "")
    @Published var registerResponse : RegisterResponse = RegisterResponse(message: "")
    
    @Published var isLoading : Bool = false
    @Published var isRegister : Bool = false
    @Published var message : String = ""
    @Published var alertMsg : Bool = false
    
    let endpointApi = EndpointsApi.shared
    
    @MainActor
    func registersRequest() {
        Task {
            DispatchQueue.main.async { [self] in isLoading = false }
            await registerRequetPrivate()
        }
    }
    
    @MainActor
    func registerRequetPrivate() async {
        await endpointApi.register(email: registerRequest.email, username: registerRequest.username, password: registerRequest.password, password_repeat: registerRequest.password_repeat) { [weak self] result in
            guard let self = self else { return }
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
