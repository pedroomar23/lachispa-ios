//
//  loginResponse.swift
//  La Chispa
//
//  Created by Pedro Omar  on 9/12/25.
//

import Foundation

struct LoginRequest: Codable {
    var username, password: String
    
    enum CodingKeys: String, CodingKey {
        case username, password
    }
    
    init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.username = try container.decode(String.self, forKey: .username)
        self.password = try container.decode(String.self, forKey: .password)
    }
    
    init(username: String, password: String) {
        self.username = username
        self.password = password
    }
}

struct LoginResponse: Decodable, Hashable, Encodable {
    let access_token: String
    let token_type: String
    
    enum CodingKeys: String, CodingKey {
        case access_token = "access_token"
        case token_type = "token_type"
    }
    
    init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.access_token = try container.decode(String.self, forKey: .access_token)
        self.token_type = try container.decode(String.self, forKey: .token_type)
    }
    
    init(access_token: String, token_type: String) {
        self.access_token = access_token
        self.token_type = token_type
    }
}
