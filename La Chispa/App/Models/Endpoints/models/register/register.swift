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
    let message: String
    
    enum CodingKeys: String, CodingKey {
        case message = "string"
    }
    
    init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.message = try container.decode(String.self, forKey: .message)
    }
    
    init(message: String) {
        self.message = message
    }
}
