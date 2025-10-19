//
//  register.swift
//  La Chispa
//
//  Created by Pedro Omar  on 9/12/25.
//

import Foundation

struct RegisterRequest: Decodable, Hashable, Encodable {
    var email, username, password: String
    var password_repeat: String
    
    enum CodingKeys: String, CodingKey {
        case email = "email"
        case username = "username"
        case password = "password"
        case password_repeat = "password_repeat"
    }
    
    init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.email = try container.decode(String.self, forKey: .email)
        self.username = try container.decode(String.self, forKey: .username)
        self.password = try container.decode(String.self, forKey: .password)
        self.password_repeat = try container.decode(String.self, forKey: .password_repeat)
    }
    
    init(email: String, username: String, password: String, password_repeat: String) {
        self.email = email
        self.username = username
        self.password = password
        self.password_repeat = password_repeat
    }
}

struct RegisterResponse: Decodable, Hashable, Encodable {
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
