//
//  LoginRequest.swift
//  La Chispa
//
//  Created by Pedro Omar  on 9/12/25.
//

import SwiftUI
import Combine

@MainActor
final class LoginRequests : ObservableObject {
    @Published var loginModel : LoginRequest = LoginRequest(username: "", password: "")
    @Published var loginResponse : LoginResponse = LoginResponse(access_token: "", token_type: "")
    @Published var loginAuth : LoginAuth = LoginAuth(id: "", created_at: "2025-08-13T18:56:16.640452", updated_at: "2025-08-13T19:17:30.919482", email: "", username: "", pubkey: "", external_id: "", extensions: [""], wallets: [Wallets(id: "", user: "", name: "", adminkey: "", inkey: "", deleted: false, created_at: "", updated_at: "", currency: "", balance_msat: 12817560, extra: WalletExtra(icon: "", color: "", pinned: false))], admin: false, super_user: false, fiat_providers: [""], has_password: false, extra: Extra(email_verified: false, first_name: "", last_name: "", display_name: "", picture: "", provider: "", visible_wallet_count: 10))
    
    @Published var historial : [HistorialResponse] = [HistorialResponse(date: "", income: 0, spending: 0, balance: 0)]
    @Published var paymentRequest : CreateInvoiceRequest = CreateInvoiceRequest(unit: "", internal: false, out: false, amount: 0, memo: "", description_hash: "", unhashed_description: "", expiry: 2, extra: Extra(email_verified: false, first_name: "", last_name: "", display_name: "", picture: "", provider: "", visible_wallet_count: 10), webhook: "", bolt11: "", lnurl_callback: "", fiat_provider: "")
    @Published var paymentResponse : CreateInvoiceResponse = CreateInvoiceResponse(cheking_id: "", payment_hash: "", wallet_id: "", amount: 0, fee: 0, bolt11: "", fiat_provider: "", status: "", memo: "", expiry: "", webhook: "", webhook_status: "", preimage: "", tag: "", extension: "", time: "", created_at: "", updated_at: "", extra: "")
    
    @AppStorage("token") var token : String = ""
    @AppStorage("email") var email : String = ""
    
    @Published var isInvoice : Bool = false
    
    @Published var isLoading : Bool = false
    @AppStorage("isAuth") var isAuth : Bool = false
    @Published var alertMsg : Bool = false
    
    @Published var message : String = ""
    
    @AppStorage("balance") var balance : Bool = false
    
    let endpointApi = EndpointsApi.shared
    let defaults = UserDefaults.standard
    
    var isValid : Bool {
        loginModel.username.isEmpty || loginModel.password.isEmpty
    }
    
    func loginRequest() {
        Task {
            DispatchQueue.main.async { [self] in isLoading = false }
            await loginRequestPrivate()
        }
    }
    
    func loginRequestPrivate() async {
        await endpointApi.login(username: loginModel.username, password: loginModel.password) { result in
            DispatchQueue.main.async { [self] in
                switch result {
                case let .success(model):
                    loginResponse = model
                    token = model.access_token
                    isLoading = false
                    isAuth = true
                    
                    defaults.set(model.access_token, forKey: "authToken")
                    
                    if !isAuth {
                        if let encoded = try? JSONEncoder().encode(loginModel) {
                            defaults.set(encoded, forKey: "keyLoginRequest")
                        }
                    }
                    
                    Task {
                        await getUserAuth()
                    }
                    
                case let .failure(error):
                    message = error.localizedDescription
                    alertMsg = true
                    isLoading = false
                    print("ErrorGetLoginRequestPrivate: \(error.localizedDescription)")
                }
            }
        }
    }
    
    func getUserAuth() async {
        await endpointApi.getAuthUser(usr: loginAuth.id, cookie_acccess_token: token) { result in
            DispatchQueue.main.async { [self] in
                switch result {
                case let .success(model):
                    loginAuth = model
                    isLoading = false
                    isAuth = true
                    loginModel.username = model.username
                    email = model.email
                    token = loginResponse.access_token
                    defaults.set(loginResponse.access_token, forKey: "authToken")
                    
                    Task {
                        await getHistorial()
                    }
                    
                case let .failure(error):
                    message = error.localizedDescription
                    isLoading = false
                    print("ErrorGetAuthUserPrivate: \(error.localizedDescription)")
                }
            }
        }
    }
    
    func getHistorial() async {
        await endpointApi.getHistorial { result in
            DispatchQueue.main.async { [self] in
                switch result {
                case let .success(model):
                    historial = model
                    isLoading = false
                    isAuth = true
                    defaults.set(loginResponse.access_token, forKey: "authToken")
                case let .failure(error):
                    message = error.localizedDescription
                    isLoading = false
                    alertMsg = true
                    print("ErrorGetHistorialPrivate: \(error.localizedDescription)")
                }
            }
        }
    }
    
    func paymetsRequest() {
        Task {
            DispatchQueue.main.async { [self] in isLoading = false }
            await paymentsRequestPrivate()
        }
    }
    
    func paymentsRequestPrivate() async {
        await endpointApi.payments(unit: paymentRequest.unit, internal: paymentRequest.internal, out: paymentRequest.out, amount: paymentRequest.amount, memo: paymentRequest.memo, description_hash: paymentRequest.description_hash, unhashed_description: paymentRequest.unhashed_description, expiry: paymentRequest.expiry, extra: paymentRequest.extra, webhook: paymentRequest.webhook, bolt11: paymentRequest.bolt11, lnurl_callback: paymentRequest.lnurl_callback, fiat_provider: paymentRequest.fiat_provider) { result in
            DispatchQueue.main.async { [self] in
                switch result {
                case let .success(model):
                    paymentResponse = model
                    isLoading = false
                    isAuth = true
                    isInvoice = true 
                    alertMsg = false
                    defaults.set(loginResponse.access_token, forKey: "authToken")
                case let .failure(error):
                    message = error.localizedDescription
                    isLoading = false
                    alertMsg = true
                    print("ErrorGetPaymentsPrivate: \(error.localizedDescription)")
                }
            }
        }
    }
    
    func closeSession() {
        self.loginModel = LoginRequest(username: "", password: "")
        if !isAuth {
            if let encoded = try? JSONEncoder().encode(LoginRequest(username: "", password: "")) {
                defaults.set(encoded, forKey: "keyLoginRequest")
            }
        }
        self.token = ""
        self.message = ""
        self.alertMsg = false
        self.isLoading = false
        self.isAuth = false
    }
}
