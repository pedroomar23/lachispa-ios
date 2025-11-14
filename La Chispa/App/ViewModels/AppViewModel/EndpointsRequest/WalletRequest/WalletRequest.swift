//
//  WalletRequest.swift
//  La Chispa
//
//  Created by Pedro Omar  on 10/28/25.
//

import SwiftUI
import Combine

@MainActor
final class WalletRequest : ObservableObject {
    @Published var createWalletRequest : CreateWalletRequest = CreateWalletRequest(name: "")
    @Published var createWalletRespomse: CreateWalletResponse = CreateWalletResponse(id: "", user: "", name: "", adminkey: "", inkey: "", deleted: false, created_at: "", updated_at: "", currency: "", balance_msat: 0, extra: ExtraD(icon: "", color: "", pinned: false))
    @Published var updateWalletRequest : UpdatedWalletRequest = UpdatedWalletRequest(name: "", icon: "", color: "", currency: "", pinned: false)
    @Published var updateWalletResponse : UpdatedWalletResponse = UpdatedWalletResponse(id: "", user: "", name: "", adminkey: "", inkey: "", deleted: false, created_at: "", updated_at: "", currency: "", balance_msat: 0, extra: ExtraD(icon: "", color: "", pinned: false))
    
    @Published var isLoading : Bool = false
    @Published var alertMsg : Bool = false
    @Published var isWallet : Bool = false
    @Published var isUpdate : Bool = false
    @Published var message : String = ""
    
    @Published var name : String = ""
    @Published var selectedWallet : String = ""
    
    let walletApi = WalletsApi.shared
    
    // MARK: - Create Wallet
    
    func createWalletRequests() {
        Task {
            DispatchQueue.main.async { [self] in isLoading = false }
            await createWalletRequestPrivate()
        }
    }
    
    func createWalletRequestPrivate() async {
        await walletApi.createWallet(name: name) { result in
            DispatchQueue.main.async { [self] in
                switch result {
                case let .success(model):
                    createWalletRespomse = model
                    isWallet = true
                    isLoading = false
                case let .failure(error):
                    message = error.localizedDescription
                    alertMsg = true
                    isLoading = false
                    print("ErrorGetCreateWallet: \(error.localizedDescription)")
                }
            }
        }
    }
    
    // MARK: - Update Wallet
    
   
    
    
}
