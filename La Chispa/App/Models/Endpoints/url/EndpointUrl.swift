//
//  EndopointUrl.swift
//  La Chispa
//
//  Created by Pedro Omar  on 9/12/25.
//

import Foundation

enum EndpointUrl {
    private static let urlApi = "https://lachispa.me/api/v1"
    
    case login
    case userAuth
    case register
    case changePass
    case createPayments
    case paymentsForDay
    case paymentsTagCount
    
    var path: String {
        switch self {
        case .login: return "/auth"
        case .userAuth: return "/auth"
        case .register: return "/auth/register"
        case .changePass: return "/auth/reset"
        case .createPayments: return "/payments"
        case .paymentsForDay: return "/payments/history?group=day"
        case .paymentsTagCount: return "/payments/stats/count?count_by=tag"
        }
    }
    
    var url: URL {
        return URL(string: EndpointUrl.urlApi + path)!
    }
}
