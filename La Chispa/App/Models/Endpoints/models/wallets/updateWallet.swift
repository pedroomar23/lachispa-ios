//
//  updateWallet.swift
//  La Chispa
//
//  Created by Pedro Omar  on 10/28/25.
//

import Foundation

struct UpdatedWalletRequest: Decodable, Hashable, Encodable {
    let name: String
    let icon: String
    let color: String
    let currency: String?
    let pinned: Bool
    
    enum CodingKeys: String, CodingKey {
        case name = "name"
        case icon = "icon"
        case color = "color"
        case currency = "currency"
        case pinned = "pinned"
    }
    
    init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.name = try container.decode(String.self, forKey: .name)
        self.icon = try container.decode(String.self, forKey: .icon)
        self.color = try container.decode(String.self, forKey: .color)
        self.currency = try container.decodeIfPresent(String.self, forKey: .currency) ?? ""
        self.pinned = try container.decode(Bool.self, forKey: .pinned)
    }
    
    init(name: String, icon: String, color: String, currency: String?, pinned: Bool) {
        self.name = name
        self.icon = icon
        self.color = color
        self.currency = currency
        self.pinned = pinned
    }
}

struct UpdatedWalletResponse: Decodable, Hashable, Encodable, Identifiable {
    let id: String
    let user: String
    let name: String
    let adminkey: String
    let inkey: String
    let deleted: Bool
    let created_at: String
    let updated_at: String
    let currency: String?
    let balance_msat: Int64
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
}
