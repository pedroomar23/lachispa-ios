//
//  LoginRequest.swift
//  La Chispa
//
//  Created by Pedro Omar  on 9/12/25.
//

import SwiftUI
import Combine
import CoreImage.CIFilterBuiltins

@MainActor
final class LoginRequests : ObservableObject {
    @Published var loginModel : LoginRequest = LoginRequest(username: "", password: "")
    @Published var loginResponse : LoginResponse = LoginResponse(access_token: "", token_type: "")
    @Published var loginAuth : LoginAuth = LoginAuth(id: "", created_at: "", updated_at: "", email: "", username: "", pubkey: "", external_id: "", extensions: [""], wallets: [Wallets(id: "", user: "", name: "", adminkey: "", inkey: "", deleted: false, created_at: "", updated_at: "", currency: "", balance_msat: 870852, extra: WalletExtra(icon: "", color: "", pinned: false))], admin: false, super_user: false, fiat_providers: [""], has_password: false, extra: Extra(email_verified: false, first_name: "", last_name: "", display_name: "", picture: "", provider: "", visible_wallet_count: 10))
    @Published var historial : [HistorialResponse] = [HistorialResponse(date: "", income: 0, spending: 0, balance: 0)]
    @Published var createInvoice : CreateInvoice = CreateInvoice(amount: 0, unit: "sat", memo: "", expiry: 0, out: false, webhook: "", url: "", internal: false)
    @Published var createPayments : CreatePayments = CreatePayments(bolt11: "", out: true, amount: 0, unit: "")
    @Published var paymentResponse : CreateInvoiceResponse = CreateInvoiceResponse(cheking_id: "", payment_hash: "", wallet_id: "", amount: 0, fee: 0, bolt11: "", fiat_provider: "", status: "", memo: "", expiry: "", webhook: "", webhook_status: 0, preimage: "", tag: "", extension: "", time: "", created_at: "", updated_at: "", extra: ExtraData(wallet_fiat_currency: "", wallet_fiat_amount: 4.274, wallet_fiat_rate: 935.8396030346214, wallet_btc_rate: 106855.918125))
    @Published var getPaymentsForDay : GetPaymentsForDay = GetPaymentsForDay(date: "", balance: 0, balance_in: 0, payments_count: 0, count_in: 0, count_out: 0, fee: 0)
    @Published var getPaymentsAllUsers : GetPaymentsAllUsers = GetPaymentsAllUsers(field: "", total: 0)
    @Published var getPayments : [GetPayments] = [GetPayments(cheking_id: "", payment_hash: "", wallet_id: "", amount: 0, fee: 0, bolt11: "", fiat_provider: "", status: "", memo: "", expiry: "", webhook: "", webhook_status: 0, preimage: "", tag: "", extension: "", time: "", created_at: "", updated_at: "", extra: ExtraData(wallet_fiat_currency: "", wallet_fiat_amount:  4.274, wallet_fiat_rate: 935.8396030346214, wallet_btc_rate: 106855.918125))]
    
    @AppStorage("token") var token : String = ""
    @AppStorage("email") var email : String = ""
    
    @AppStorage("paymmentHash") var paymentbolt11 : String = ""
    @Published var paymentsUnit : String =  ""
    
    @Published var isInvoice : Bool = false
    
    @Published var isLoading : Bool = false
    @AppStorage("isAuth") var isAuth : Bool = false
    @Published var alertMsg : Bool = false
    
    @Published var message : String = ""
    
    @AppStorage("balance") var balance : Bool = false
    
    let endpointApi = EndpointsApi.shared
    let defaults = UserDefaults.standard
    
    @Published var btcRate: Double = 0.0
    @Published var qrCodeImage : UIImage?
    
    var isValid : Bool {
        loginModel.username.isEmpty || loginModel.password.isEmpty
    }
    
    func formatSats(_ balanceMsat: Int) -> String {
        let sats = balanceMsat / 1000
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.groupingSeparator = ","
        formatter.maximumFractionDigits = 0
        return formatter.string(from: NSNumber(value: sats)) ?? "0"
    }
    
    func convertSatsToFiat(sats: Int) -> String {
        let rate = getCurrentRate()
        let amountInBTC = Double(sats) / 100_000_000.0
        let amountInFiat = amountInBTC * rate
        
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.currencyCode = "USD"
        formatter.maximumFractionDigits = 2
        
        return formatter.string(from: NSNumber(value: amountInFiat)) ?? "$0.00"
    }
    
    func updateRateFromPayment(_ paymentResponse: CreateInvoiceResponse) {
        if let rate = paymentResponse.extra?.wallet_btc_rate {
            self.btcRate = rate
        }
    }
    
    func getCurrentRate() -> Double {
        return btcRate
    }
    
    func formatDate(_ dateString: String) -> String {
        let formatter = ISO8601DateFormatter()
        if let date = formatter.date(from: dateString) {
            let displayFormatter = DateFormatter()
            displayFormatter.dateStyle = .medium
            return displayFormatter.string(from: date)
        }
        return dateString
    }
    
    func generateQRCode(from string: String) {
        let context = CIContext()
        let filter = CIFilter.qrCodeGenerator()
        
        filter.message = Data(string.utf8)
        filter.correctionLevel = "M"
        
        if let outputImage = filter.outputImage {
            let scaledImage = outputImage.transformed(by: CGAffineTransform(scaleX: 10, y: 10))
            
            if let cgImage = context.createCGImage(scaledImage, from: scaledImage.extent) {
                qrCodeImage = UIImage(cgImage: cgImage)
                return
            }
        }
        
        // Fallback si no se puede generar el QR
        qrCodeImage = UIImage(systemName: "qrcode")?
            .withTintColor(.black, renderingMode: .alwaysOriginal)
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
            DispatchQueue.main.async {
                switch result {
                case let .success(model):
                    self.loginAuth = model
                    self.isLoading = false
                    self.isAuth = true
                    self.loginModel.username = model.username
                    self.email = model.email
                    self.token = self.loginResponse.access_token
                    self.defaults.set(self.loginResponse.access_token, forKey: "authToken")
                    
                case let .failure(error):
                    self.message = error.localizedDescription
                    self.isLoading = false
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
        await endpointApi.createPayments(bolt11: paymentbolt11, out: createPayments.out, amount: createPayments.amount, unit: createPayments.unit) { result in
            DispatchQueue.main.async { [self] in
                switch result {
                case let .success(model):
                    paymentResponse = model
                    paymentsUnit = createPayments.unit
                    paymentbolt11 = createPayments.bolt11
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
    
    func invoiceRequest() {
        Task {
            DispatchQueue.main.async { [self] in isLoading = false }
            await invoiceRequestPrivate()
        }
    }
    
    func invoiceRequestPrivate() async {
        await endpointApi.createInvoice(amount: createInvoice.amount, unit: createInvoice.unit, memo: createInvoice.memo, expiry: createInvoice.expiry, out: createInvoice.out, webhook: createInvoice.webhook, url: createInvoice.url, internal: createInvoice.internal) { result in
            DispatchQueue.main.async { [self] in
                switch result {
                case let .success(model):
                    paymentResponse = model
                    isLoading = false
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
