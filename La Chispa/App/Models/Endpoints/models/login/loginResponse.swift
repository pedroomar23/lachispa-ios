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
    let id: String
    let created_at: String
    let updated_at: String
    let email: String
    let username: String
    let pubkey: String
    let external_id: String
    let extensions: [String]
    let wallets: [String]
    let admin: Bool
    let super_user: Bool
    let fiat_providers: [String]
    let has_password: Bool
    let extra: Extra
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case created_at = "created_at"
        case updated_at = "updated_at"
        case email = "email"
        case username = "username"
        case pubkey = "pubkey"
        case external_id = "external_id"
        case extensions = "extensions"
        case wallets = "wallets"
        case admin = "admin"
        case super_user = "super_user"
        case fiat_providers = "fiat_providers"
        case has_password = "has_password"
        case extra = "extra"
    }
    
    init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decode(String.self, forKey: .id)
        self.created_at = try container.decode(String.self, forKey: .created_at)
        self.updated_at = try container.decode(String.self, forKey: .updated_at)
        self.email = try container.decode(String.self, forKey: .email)
        self.username = try container.decode(String.self, forKey: .username)
        self.pubkey = try container.decode(String.self, forKey: .pubkey)
        self.external_id = try container.decode(String.self, forKey: .external_id)
        self.extensions = try container.decode([String].self, forKey: .extensions)
        self.wallets = try container.decode([String].self, forKey: .wallets)
        self.admin = try container.decode(Bool.self, forKey: .admin)
        self.super_user = try container.decode(Bool.self, forKey: .super_user)
        self.fiat_providers = try container.decode([String].self, forKey: .fiat_providers)
        self.has_password = try container.decode(Bool.self, forKey: .has_password)
        self.extra = try container.decode(Extra.self, forKey: .extra)
    }
    
    init(id: String, created_at: String, updated_at: String, email: String, username: String, pubkey: String, external_id: String, extensions: [String], wallets: [String], admin: Bool, super_user: Bool, fiat_providers: [String], has_password: Bool, extra: Extra) {
        self.id = id
        self.created_at = created_at
        self.updated_at = updated_at
        self.email = email
        self.username = username
        self.pubkey = pubkey
        self.external_id = external_id
        self.extensions = extensions
        self.wallets = wallets
        self.admin = admin
        self.super_user = super_user
        self.fiat_providers = fiat_providers
        self.has_password = has_password
        self.extra = extra
    }
}

struct Extra: Decodable, Hashable, Encodable {
    let email_verified: Bool
    let provider: String
    let visible_wallet_count: Int
    
    enum CodingKeys: String, CodingKey {
        case email_verified = "email_verified"
        case provider = "provider"
        case visible_wallet_count = "visible_wallet_count"
    }
    
    init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.email_verified = try container.decode(Bool.self, forKey: .email_verified)
        self.provider = try container.decode(String.self, forKey: .provider)
        self.visible_wallet_count = try container.decode(Int.self, forKey: .visible_wallet_count)
    }
    
    init(email_verified: Bool, provider: String, visible_wallet_count: Int) {
        self.email_verified = email_verified
        self.provider = provider
        self.visible_wallet_count = visible_wallet_count
    }
}
