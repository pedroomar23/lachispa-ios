//
//  EndopointUrl.swift
//  La Chispa
//
//  Created by Pedro Omar  on 9/12/25.
//

import Foundation

enum EndopointUrl {
    private static let urlApi = "https://lachispa.me"
    
    case login
    case register
    case changePass
    
    var path : String {
        switch self {
        case .login: return "/api/v1/auth"
        case .register: return "/api/v1/auth/register"
        case .changePass: return ""
        }
    }
    
    var url : URL {
        return URL(string: EndopointUrl.urlApi + path)!
    }
}
