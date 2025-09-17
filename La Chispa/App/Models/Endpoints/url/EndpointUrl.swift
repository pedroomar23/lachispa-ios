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
    case register
    case changePass
    
    var path: String {
        switch self {
        case .login: return "/auth"
        case .register: return "/auth/register"
        case .changePass: return "/auth/reset"
        }
    }
    
    var url: URL {
        return URL(string: EndpointUrl.urlApi + path)!
    }
}
