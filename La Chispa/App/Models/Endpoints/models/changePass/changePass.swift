//
//  changePass.swift
//  La Chispa
//
//  Created by Pedro Omar  on 9/12/25.
//

import Foundation

struct PasswordRequest: Decodable, Hashable, Encodable {
    var reset_key, password: String
    var password_repeat: String
    
    enum CodingKeys: String, CodingKey {
        case reset_key = "reset_key"
        case password = "password"
        case password_repeat = "password_repeat"
    }
    
    init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.reset_key = try container.decode(String.self, forKey: .reset_key)
        self.password = try container.decode(String.self, forKey: .password)
        self.password_repeat = try container.decode(String.self, forKey: .password_repeat)
    }
    
    init(reset_key: String, password: String, password_repeat: String) {
        self.reset_key = reset_key
        self.password = password
        self.password_repeat = password_repeat
    }
}

struct PasswordResponse: Decodable, Hashable, Encodable {
    let message: String
    
    enum CodingKeys: String, CodingKey {
        case message = "message"
    }
    
    init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.message = try container.decode(String.self, forKey: .message)
    }
    
    init(message: String) {
        self.message = message
    }
}
