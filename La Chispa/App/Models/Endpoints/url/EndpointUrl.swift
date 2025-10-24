//
//  EndopointUrl.swift
//  La Chispa
//
//  Created by Pedro Omar  on 9/12/25.
//

import Foundation

enum EndpointUrl {
    private static let urlApi = "https://lachispa.me/api/v1"
    private static let lnURLP = "https://lachispa.me/"
    private static let urlBolts = "https://lachispa.me/boltz/api/v1"
    
    case login
    case userAuth
    case register
    case changePass
    case createPayments
    case paymentsForDay
    case paymentsTagCount
    case getPayments
    
    case getListSwap
    case createSwap
    
    var path: String {
        switch self {
        case .login: return "/auth"
        case .userAuth: return "/auth"
        case .register: return "/auth/register"
        case .changePass: return "/auth/reset"
        case .createPayments: return "/payments"
        case .getPayments: return "/payments"
        case .paymentsForDay: return "/payments/history?group=day"
        case .paymentsTagCount: return "/payments/stats/count?count_by=tag"
            
        case .getListSwap: return "/swap?all_wallets=false"
        case .createSwap: return "/swap"
        }
    }
    
    var url: URL {
        return URL(string: EndpointUrl.urlApi + path)!
    }
    
    var urlBoltz: URL {
        return URL(string: EndpointUrl.urlBolts + path)!
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
