//
//  createWallet.swift
//  La Chispa
//
//  Created by Pedro Omar  on 10/28/25.
//

import Foundation

struct CreateWalletRequest: Decodable, Hashable, Encodable {
    let name: String
    
    enum CodingKeys: String, CodingKey {
        case name = "name"
    }
    
    init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.name = try container.decode(String.self, forKey: .name)
    }
    
    init(name: String) {
        self.name = name
    }
}

struct CreateWalletResponse: Decodable, Hashable, Encodable, Identifiable {
    let id: String
    let user: String
    let name: String
    let adminkey: String
    let inkey: String
    let deleted: Bool
    let created_at: String
    let updated_at: String
    let currency: String?
    let balance_msat: Int
    let extra: ExtraD
    
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
        self.currency = try container.decodeIfPresent(String.self, forKey: .currency) ?? ""
        self.balance_msat = try container.decode(Int.self, forKey: .balance_msat)
        self.extra = try container.decode(ExtraD.self, forKey: .extra)
    }
    
    init(id: String, user: String, name: String, adminkey: String, inkey: String, deleted: Bool, created_at: String, updated_at: String, currency: String?, balance_msat: Int, extra: ExtraD) {
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

struct ExtraD: Decodable, Hashable, Encodable {
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
