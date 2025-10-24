//
//  SwapRequest.swift
//  La Chispa
//
//  Created by Pedro Omar  on 10/23/25.
//

import SwiftUI
import Combine

@MainActor
final class BoltzRequest : ObservableObject {
    @Published var createSwap : SwapCreate = SwapCreate(wallet: "", asset: "", refund_address: "", amount: 0, direction: "", feerate: true, feerate_value: 0)
    @Published var createSwapResponse : SwapCreateResponse = SwapCreateResponse(id: "", wallet: "", asset: "", amount: 0, direction: "", feerate: true, feerate_value: 0, payment_hash: "", time: "", status: "", refund_privkey: "", refund_address: "", boltz_id: "", expected_amount: 0, timeout_block_height: 0, address: "", bip21: "", redeem_script: "", blinding_key: "")
    @Published var swapList : [ListSwap] = [ListSwap(id: "", wallet: "", asset: "", amount: 0, direction: "", feerate: true, feerate_value: 0, payment_hash: "", time: "", status: "", refund_privkey: "", refund_address: "", boltz_id: "", expected_amount: 0, timeout_block_height: 0, address: "", bip21: "", redeem_script: "", blinding_key: "")]
    
    @Published var isLoading : Bool = false
    @Published var isSwap : Bool = false
    @Published var isCreateSwap : Bool = false
    @Published var alertMsg : Bool = false
    
    @Published var message : String = ""
    
    let boltzApi = BoltsApi.shared
    
    // MARK: - Create Swap
    
    func createSwapRequest() {
        Task {
            DispatchQueue.main.async { [self] in isLoading = false }
            await createSwapPrivate()
        }
    }
    
    func createSwapPrivate() async {
        await boltzApi.createSwap(wallet: createSwap.wallet, asset: createSwap.asset, refund_address: createSwap.refund_address, amount: createSwap.amount, direction: createSwap.direction, feerate: createSwap.feerate, feerate_value: createSwap.feerate_value) { result in
            DispatchQueue.main.async { [self] in
                switch result {
                case let .success(model):
                    createSwapResponse = model
                    isCreateSwap = true
                    isLoading = false
                    alertMsg = false
                case let .failure(error):
                    message = error.localizedDescription
                    isLoading = false
                    alertMsg = true
                    print("ErrorCreateSwap: \(error.localizedDescription)")
                }
            }
        }
    }
    
    // MARK: - GetSwapList
    
    func getSwapList() async {
        await boltzApi.getListSwap { result in
            DispatchQueue.main.async { [self] in
                switch result {
                case let .success(model):
                    swapList = model
                    isLoading = false
                    isSwap = true
                    alertMsg = false
                case let .failure(error):
                    message = error.localizedDescription
                    alertMsg = true
                    isLoading = false
                    print("GetListSwaapPrivate: \(error.localizedDescription)")
                }
            }
        }
    }
}
