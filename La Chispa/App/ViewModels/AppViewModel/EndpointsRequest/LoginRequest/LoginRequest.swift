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
    @Published var createInvoice : CreateInvoice = CreateInvoice(bolt11: "", out: false, amount: 1000, unit: "", memo: "")
    @Published var createPayments : CreatePayments = CreatePayments(bolt11: "", out: true, amount: 0, unit: "")
    @Published var paymentResponse : CreateInvoiceResponse = CreateInvoiceResponse(cheking_id: "", payment_hash: "", wallet_id: "", amount: 0, fee: 0, bolt11: "", fiat_provider: "", status: "", memo: "", expiry: "", webhook: "", webhook_status: 0, preimage: "", tag: "", extension: "", time: "", created_at: "", updated_at: "", extra: ExtraData(wallet_fiat_currency: "", wallet_fiat_amount: 0.0, wallet_fiat_rate: 0.0, wallet_btc_rate: 0.0))
    @Published var getPaymentsAllUsers : GetPaymentsAllUsers = GetPaymentsAllUsers(field: "", total: 0)
    @Published var getPayments : [GetPayments] = [GetPayments(cheking_id: "", payment_hash: "", wallet_id: "", amount: 0, fee: 0, bolt11: "", fiat_provider: "", status: "", memo: "", expiry: "", webhook: "", webhook_status: "", preimage: "", tag: "", extension: "", time: "", created_at: "", updated_at: "", extra: ExtraData(wallet_fiat_currency: "", wallet_fiat_amount: 4.274, wallet_fiat_rate: 935.8396030346214, wallet_btc_rate: 106855.918125))]
    @Published var isGetPayments : GetPayments = GetPayments(cheking_id: "", payment_hash: "", wallet_id: "", amount: 0, fee: 0, bolt11: "", fiat_provider: "", status: "", memo: "", expiry: "", webhook: "", webhook_status: "", preimage: "", tag: "", extension: "", time: "", created_at: "", updated_at: "", extra: ExtraData(wallet_fiat_currency: "", wallet_fiat_amount: 4.274, wallet_fiat_rate: 935.8396030346214, wallet_btc_rate: 106855.918125))
    @Published var getLNURLResponse : GetLNURLUsername = GetLNURLUsername(tag: "", callback: "", minSendable: 1000, maxSendable: 2100000000000, metadata: "", commentAllowed: 500, allowsNostr: true, nostrPubkey: "")
    @Published var payLNURL : PayLNURLRequest = PayLNURLRequest(description_hash: "", callback: "", amount: 0, comment: "", description: "", unit: "")
    @Published var payLNURLResponse : PayLNURLResponse = PayLNURLResponse(checking_id: "", payment_hash: "", wallet_id: "", amount: 0, fee: 0, bolt11: "", fiat_provider: "", status: "", memo: "", expiry: "", webhook: "", webhook_status: "", preimage: "", tag: "", extension: "", time: "", created_at: "", updated_at: "", extra: ExtraData(wallet_fiat_currency: "", wallet_fiat_amount: 0.0, wallet_fiat_rate: 0.0, wallet_btc_rate: 0.0))
    @Published var payLNUrlNFC : PaymentNFCRequest = PaymentNFCRequest(lnurl_w: "")
    
    @AppStorage("token") var token : String = ""
    @AppStorage("email") var email : String = ""
    @AppStorage("usuario") var username : String = ""
    @AppStorage("paymmentHash") var paymentbolt11 : String = ""
    @AppStorage("wallets") var wallets: String = ""
    @AppStorage("getPayments") var getPayment : String = ""
    @Published var paymentsUnit : String =  ""
    @Published var payLNURLs : String = ""
    
    @Published var isInvoice : Bool = false
    @Published var isLNURL : Bool = false
    
    @Published var isLoading : Bool = false
    @Published var timeOut : Bool = false
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
    
    var invoiceEmpty : Bool {
        paymentbolt11.isEmpty
    }
    
    // MARK: - Balance in sats
   
    func formatSats(_ balanceMsat: Int) -> String {
        let sats = balanceMsat / 1000
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.groupingSeparator = ","
        formatter.maximumFractionDigits = 0
        return formatter.string(from: NSNumber(value: sats)) ?? "0"
    }
    
    // MARK: - Format Date
    
    func formatDate(_ dateString: String) -> String {
        let inputFormatter = DateFormatter()
        inputFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSSSS"
        
        let outputFormatter = DateFormatter()
        outputFormatter.dateFormat = "dd/MM/yy HH:mm"
        
        if let date = inputFormatter.date(from: dateString) {
            return outputFormatter.string(from: date)
        }
        return String(dateString.prefix(10))
    }
    
    // MARK: - Convert Sats to Fiat
    
    func convertSatsToFiat(sats: Int) -> String {
        let amountInBTC = Double(sats) / 100_000_000.0
        let amountInFiat = amountInBTC 
        
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
        return Double(loginAuth.wallets[0].balance_msat)
    }
    
    // MARK: - Read QR
    
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
    
    // MARK: - Login
    
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
                    timeOut = true
                    
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
                    timeOut = false 
                    print("ErrorGetLoginRequestPrivate: \(error.localizedDescription)")
                }
            }
        }
    }
    
    // MARK: - User Auth
    
    func getUserAuth() async {
        await endpointApi.getAuthUser(usr: loginAuth.id, cookie_acccess_token: token) { result in
            DispatchQueue.main.async { [self] in
                switch result {
                case let .success(model):
                    loginAuth = model
                    isLoading = false
                    timeOut = true
                    isAuth = true
                    loginModel.username = model.username
                    email = model.email
                    token = loginResponse.access_token
                    defaults.set(loginResponse.access_token, forKey: "authToken")
                   
                    wallets.removeAll()
                    for i in model.wallets {
                        wallets.append(i.id)
                    }
                    
                    wallets = model.wallets[0].id
                    
                    Task {
                        await getPayments()
                    }
                    
                case let .failure(error):
                    self.message = error.localizedDescription
                    self.isLoading = false
                    print("ErrorGetAuthUserPrivate: \(error.localizedDescription)")
                }
            }
        }
    }
    
    // MARK: - Historial
    
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
    
    // MARK: - GetPayments
    
    func getPayments() async {
        await endpointApi.getPayments { result in
            DispatchQueue.main.async { [self] in
                switch result {
                case let .success(model):
                    getPayments = model
                    isLoading = false
                    isAuth = true
                    timeOut = true 
                    defaults.set(loginResponse.access_token, forKey: "authToken")
                    
                    for i in model {
                        getPayment.append(i.checking_id)
                    }
                    
                    getPayment = model[0].checking_id
               
                case let .failure(error):
                    message = error.localizedDescription
                    isLoading = false
                    alertMsg = true 
                    print("ErrorGetPaymentsPrivate: \(error.localizedDescription)")
                }
            }
        }
    }
    
    // MARK: - LNURL
    
    func getLNURLRequest() {
        Task {
            DispatchQueue.main.async { [self] in isLoading = false }
            await getLNURLRequestPrivate()
        }
    }
    
    func getLNURLRequestPrivate() async {
        await endpointApi.getLNURl(username: username) { result in
            DispatchQueue.main.async { [self] in
                switch result {
                case let .success(model):
                    getLNURLResponse = model
                    isLoading = false
                    isAuth = true
                    isLNURL = true
                    defaults.set(loginResponse.access_token, forKey: "authToken")
                case let .failure(error):
                    message = error.localizedDescription
                    alertMsg = true
                    isLoading = false
                    print("ErrorGetLNURLPrivate: \(error.localizedDescription)")
                }
            }
        }
    }
    
    func payLNURLRequest() {
        Task {
            DispatchQueue.main.async { [self] in isLoading = false }
            await payLNURLRequestPrivate()
        }
    }
    
    func payLNURLRequestPrivate() async {
        await endpointApi.payLNURL(description_hash: payLNURL.description_hash, callback: payLNURLs, amount: payLNURL.amount, comment: payLNURL.comment, description: payLNURL.description, unit: payLNURL.unit) { result in
            DispatchQueue.main.async { [self] in
                switch result {
                case let .success(model):
                    payLNURLResponse = model
                    paymentbolt11 = model.bolt11
                    isLoading = false
                    isAuth = true
                    isLNURL = true
                    alertMsg = false
                    defaults.set(loginResponse.access_token, forKey: "authToken")
                case let .failure(error):
                    message = error.localizedDescription
                    alertMsg = true
                    isLoading = false
                    print("ErrorPayLNURLPrivate: \(error.localizedDescription)")
                }
            }
        }
    }
    
    // MARK: - Payments
    
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
    
    // MARK: - Invoices
    
    func invoiceRequest() {
        Task {
            DispatchQueue.main.async { [self] in isLoading = false }
            await invoiceRequestPrivate()
        }
    }
    
    func invoiceRequestPrivate() async {
        await endpointApi.createInvoice(bolt11: paymentbolt11, out: createInvoice.out, amount: createInvoice.amount, unit: createInvoice.unit,  memo: createInvoice.memo ?? "") { result in
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
    
    // MARK: - Login Out
    
    func closeSession() {
        self.loginModel = LoginRequest(username: "", password: "")
        if !isAuth {
            if let encoded = try? JSONEncoder().encode(LoginRequest(username: "", password: "")) {
                defaults.set(encoded, forKey: "keyLoginRequest")
            }
        }
        self.timeOut = false
        self.token = ""
        self.message = ""
        self.alertMsg = false
        self.isLoading = false
        self.isAuth = false
    }
}

extension String {
    func removingPlus() -> String {
        return replacingOccurrences(of: "+", with: "")
    }
}
