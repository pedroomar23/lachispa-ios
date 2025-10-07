//
//  ChangeRequest.swift
//  La Chispa
//
//  Created by Pedro Omar  on 9/12/25.
//

import SwiftUI
import Combine

@MainActor
final class ChangePassword : ObservableObject {
    @Published var passRequest : PasswordRequest = PasswordRequest(reset_key: "", password: "", password_repeat: "")
    @Published var passResponse : PasswordResponse = PasswordResponse(message: "")
    
    @Published var isPass : Bool = false
    @Published var failureMsg : Bool = false
    @Published var successMsg : Bool = false
    
    @Published var message : String = ""
    @Published var acceptMsg : String = ""
    
    @Published var isLoading : Bool = false
    
    let endPointApi = EndpointsApi.shared
    
    var isValid : Bool {
        return passRequest.password.isEmpty || passRequest.password_repeat.isEmpty
    }
    
    func changePassRequest() {
        Task {
            DispatchQueue.main.async { [self] in isLoading = false }
            await changePassPrivate()
        }
    }
    
    func changePassPrivate() async {
        await endPointApi.changePass(reset_key: passRequest.reset_key, password: passRequest.password, password_repeat: passRequest.password_repeat) { result in
            DispatchQueue.main.async { [self] in
                switch result {
                case let .success(model):
                    passResponse = model
                    acceptMsg = model.message
                    successMsg = true
                    isPass = true
                    isLoading = false
                case let .failure(error):
                    message = error.localizedDescription
                    failureMsg = true
                    isLoading = false
                    print("FailreGetChangePass: \(error.localizedDescription)")
                }
            }
        }
    }
}
