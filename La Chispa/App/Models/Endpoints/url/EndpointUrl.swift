//
//  EndopointUrl.swift
//  La Chispa
//
//  Created by Pedro Omar  on 9/12/25.
//

import Foundation

enum EndpointUrl {
    private static let urlApi = "https://lachispa.me/api/v1"
    private static let urlBolts = "https://lachispa.me/boltz/api/v1"
    private static let urlFF = "https://ff.io/api/v2"
    
    case wallet
    case updateWallet
  
    case login
    case userAuth
    case register
    case changePass
    case createPayments
    case paymentsForDay
    case paymentsTagCount
    case getPayments
    case payLNURL
    case payLNURLNFC
    
    case getListSwap
    case createSwap
    
    case createOrden
    
    var path: String {
        switch self {
        case .wallet: return "/wallet"
        case .updateWallet: return "/wallet"
       
        case .login: return "/auth"
        case .userAuth: return "/auth"
        case .register: return "/auth/register"
        case .changePass: return "/auth/reset"
        case .createPayments: return "/payments"
        case .getPayments: return "/payments"
        case .paymentsForDay: return "/payments/history?group=day"
        case .paymentsTagCount: return "/payments/stats/count?count_by=tag"
        case .payLNURL: return "/payments/lnurl"
        case .payLNURLNFC: return "/payments/lnurl/pay-with-nfc"
            
        case .getListSwap: return "/swap?all_wallets=false"
        case .createSwap: return "/swap"
            
        case .createOrden: return "/create"
        }
    }
    
    var url: URL {
        return URL(string: EndpointUrl.urlApi + path)!
    }
    
    var urlBoltz: URL {
        return URL(string: EndpointUrl.urlBolts + path)!
    }
    
    var urlFF: URL {
        return URL(string: EndpointUrl.urlFF + path)!
    }
}

enum EndpointLNUrl {
    case getLNURLP(username: String)
    
    var urlLNP: URL {
        switch self {
        case .getLNURLP(let username):
            let urlString = "https://lachispa.me/.well-known/lnurlp/\(username)"
            return URL(string: urlString)!
        }
    }
}

enum EndpointWallet {
    case getUpdateWallet(walletId: String)
    
    var urlUpdate: URL {
        switch self {
        case .getUpdateWallet(let walletId):
            let urlString = "https://lachispa.me/api/v1/wallet/\(walletId)"
            return URL(string: urlString)!
        }
    }
}
