//
//  FFRequest.swift
//  La Chispa
//
//  Created by Pedro Omar  on 11/17/25.
//

import SwiftUI
import Combine

@MainActor
final class FFRequest : ObservableObject {
    @Published var ffrequest : CreateOrden = CreateOrden(type: "", fromCcy: "", toCcy: "", direction: "", amount: 0, toAddress: "", tag: true, refcode: "", afftax: 0.0)
    @Published var ffResponse : ResponseOrden = ResponseOrden(code: 0, msg: "", data: Datas(id: "", type: "", email: "", status: "", time: Time(reg: 0, start: "", finish: "", update: 0, expiration: 0, left: 0), from: From(code: "", coin: "", network: "", name: "", alias: "", amount: 0.0, address: "", addressAlt: "", tag: true, tagName: "", reqConfirmations: 0, maxConfirmations: 0, tx: TX(id: "", amount: 0.0, fee: 0, ccyfee: 0, timeReg: 0, timeBlock: true, confirmations: true))), to: TO(code: "", coin: "", network: "", name: "", amount: 0.0, address: "", tag: true, tagName: "", tx: TX(id: "", amount: 0.0, fee: 0, ccyfee: 0, timeReg: 0, timeBlock: true, confirmations: true)), back: Back(code: "", coin: "", network: "", name: "", amount: 0.0, address: "", tag: true, tagName: "", tx: TX(id: "", amount: 0.0, fee: 0, ccyfee: 0, timeReg: 0, timeBlock: true, confirmations: true)), emergency: Emergency(status: [""], choice: "", repeat: 0), token: "")
    
    @Published var isLoading : Bool = false
    @Published var alertMsg : Bool = false
    @Published var isFF : Bool = false
    
    @Published var amount : String = ""
    @Published var direction : String = ""
    @Published var message : String = ""
    
    let ffapi = FixedFloatApi.shared
    
   
    func createOrden() {
        Task {
            DispatchQueue.main.async { [self] in isLoading = false }
            await createOrdenPrivate()
        }
    }
    
    func createOrdenPrivate() async {
        guard let newAmount = Int(amount), newAmount > 0 else {
            alertMsg = true
            isLoading = false 
            return
        }
        await ffapi.createOrden(type: ffrequest.type, fromCcy: ffrequest.fromCcy, toCcy: ffrequest.toCcy, direction: direction, amount: newAmount, toAddress: ffrequest.toAddress, tag: ffrequest.tag, refcode: ffrequest.refcode, afftax: ffrequest.afftax) { result in
            DispatchQueue.main.async { [self] in
                switch result {
                case let .success(model):
                    ffResponse = model
                    isLoading = false
                    isFF = true
                case let .failure(error):
                    message = error.localizedDescription
                    isLoading = false
                    alertMsg = true
                    print("ErrorGetFixedFloatPrivate: \(error.localizedDescription)")
                }
            }
        }
    }
}
