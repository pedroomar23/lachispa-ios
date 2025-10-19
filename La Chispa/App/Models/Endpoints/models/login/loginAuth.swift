//
//  loginAuth.swift
//  La Chispa
//
//  Created by Pedro Omar  on 9/17/25.
//

import Foundation

struct LoginAuth: Decodable, Hashable, Encodable, Identifiable {
    let id: String
    let created_at: String
    let updated_at: String
    let email: String
    let username: String
    let pubkey: String?
    let external_id: String?
    let extensions: [String]
    let wallets: [Wallets]
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
        self.pubkey = try container.decodeIfPresent(String.self, forKey: .pubkey) ?? ""
        self.external_id = try container.decodeIfPresent(String.self, forKey: .external_id) ?? ""
        self.extensions = try container.decode([String].self, forKey: .extensions)
        self.wallets = try container.decode([Wallets].self, forKey: .wallets)
        self.admin = try container.decode(Bool.self, forKey: .admin)
        self.super_user = try container.decode(Bool.self, forKey: .super_user)
        self.fiat_providers = try container.decode([String].self, forKey: .fiat_providers)
        self.has_password = try container.decode(Bool.self, forKey: .has_password)
        self.extra = try container.decode(Extra.self, forKey: .extra)
    }
    
    init(id: String, created_at: String, updated_at: String, email: String, username: String, pubkey: String?, external_id: String?, extensions: [String], wallets: [Wallets], admin: Bool, super_user: Bool, fiat_providers: [String], has_password: Bool, extra: Extra) {
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

struct Wallets: Decodable, Hashable, Encodable, Identifiable {
    let id: String
    let user: String
    let name: String
    let adminkey: String
    let inkey: String
    let deleted: Bool
    let created_at: String
    let updated_at: String
    let currency: String
    let balance_msat: Int
    let extra: WalletExtra
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case user = "user"
        case name = "name"
        case adminkey = "adminkey"
        case inkey = "inkey"
        case deleted = "deleted"
        case created_at = "created_at"
        case updated_at = "updated_at"
        case currency = "currency"
        case balance_msat = "balance_msat"
        case extra = "extra"
    }
    
    init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decode(String.self, forKey: .id)
        self.user = try container.decode(String.self, forKey: .user)
        self.name = try container.decode(String.self, forKey: .name)
        self.adminkey = try container.decode(String.self, forKey: .adminkey)
        self.inkey = try container.decode(String.self, forKey: .inkey)
        self.deleted = try container.decode(Bool.self, forKey: .deleted)
        self.created_at = try container.decode(String.self, forKey: .created_at)
        self.updated_at = try container.decode(String.self, forKey: .updated_at)
        self.currency = try container.decode(String.self, forKey: .currency)
        self.balance_msat = try container.decode(Int.self, forKey: .balance_msat)
        self.extra = try container.decode(WalletExtra.self, forKey: .extra)
    }
    
    init(id: String, user: String, name: String, adminkey: String, inkey: String, deleted: Bool, created_at: String, updated_at: String, currency: String, balance_msat: Int, extra: WalletExtra) {
        self.id = id
        self.user = user
        self.name = name
        self.adminkey = adminkey
        self.inkey = inkey
        self.deleted = deleted
        self.created_at = created_at
        self.updated_at = updated_at
        self.currency = currency
        self.balance_msat = balance_msat
        self.extra = extra
    }
}

struct WalletExtra: Decodable, Hashable, Encodable {
    let icon: String
    let color: String
    let pinned: Bool
    
    enum CodingKeys: String, CodingKey {
        case icon = "icon"
        case color = "color"
        case pinned = "pinned"
    }
    
    init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.icon = try container.decode(String.self, forKey: .icon)
        self.color = try container.decode(String.self, forKey: .color)
        self.pinned = try container.decode(Bool.self, forKey: .pinned)
    }
    
    init(icon: String, color: String, pinned: Bool) {
        self.icon = icon
        self.color = color
        self.pinned = pinned
    }
}

struct Extra: Decodable, Hashable, Encodable {
    let email_verified: Bool
    let first_name: String?
    let last_name: String?
    let display_name: String?
    let picture: String?
    let provider: String
    let visible_wallet_count: Int
    
    enum CodingKeys: String, CodingKey {
        case email_verified = "email_verified"
        case first_name = "first_name"
        case last_name = "last_name"
        case display_name = "display_name"
        case picture = "picture"
        case provider = "provider"
        case visible_wallet_count = "visible_wallet_count"
    }
    
    init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.email_verified = try container.decode(Bool.self, forKey: .email_verified)
        self.first_name = try container.decodeIfPresent(String.self, forKey: .first_name) ?? ""
        self.last_name = try container.decodeIfPresent(String.self, forKey: .last_name) ?? ""
        self.display_name = try container.decodeIfPresent(String.self, forKey: .display_name) ?? ""
        self.picture = try container.decodeIfPresent(String.self, forKey: .picture) ?? ""
        self.provider = try container.decode(String.self, forKey: .provider)
        self.visible_wallet_count = try container.decode(Int.self, forKey: .visible_wallet_count)
    }
    
    init(email_verified: Bool, first_name: String?, last_name: String?, display_name: String?, picture: String?, provider: String, visible_wallet_count: Int) {
        self.email_verified = email_verified
        self.first_name = first_name
        self.last_name = last_name
        self.display_name = display_name
        self.picture = picture
        self.provider = provider
        self.visible_wallet_count = visible_wallet_count
    }
}
