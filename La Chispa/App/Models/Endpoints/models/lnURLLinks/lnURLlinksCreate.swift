//
//  lnURLlinksCreate.swift
//  La Chispa
//
//  Created by Pedro Omar  on 11/4/25.
//

import Foundation

struct LNURLlinksCreate: Decodable, Hashable, Encodable {
    let description: String
    let wallet: String
    let min: Int
    let max: Int
    let currency: String
    let comment_chars: Int
    let webhook_url: String
    let webhook_headers: String
    let webhook_body: String
    let success_text: String
    let success_url: String
    let fiat_base_multiplier: Int
    let username: String
    let zaps: Bool
    
    enum CodingKeys: String, CodingKey {
        case description = "description"
        case wallet = "wallet"
        case min = "min"
        case max = "max"
        case currency = "currency"
        case comment_chars = "comment_chars"
        case webhook_url = "webhook_url"
        case webhook_headers = "webhook_headers"
        case webhook_body = "webhook_body"
        case success_text = "success_text"
        case success_url = "success_url"
        case fiat_base_multiplier = "fiat_base_multiplier"
        case username = "username"
        case zaps = "zaps"
    }
    
    init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.description = try container.decode(String.self, forKey: .description)
        self.wallet = try container.decode(String.self, forKey: .wallet)
        self.min = try container.decode(Int.self, forKey: .min)
        self.max = try container.decode(Int.self, forKey: .max)
        self.currency = try container.decode(String.self, forKey: .currency)
        self.comment_chars = try container.decode(Int.self, forKey: .comment_chars)
        self.webhook_url = try container.decode(String.self, forKey: .webhook_url)
        self.webhook_headers = try container.decode(String.self, forKey: .webhook_headers)
        self.webhook_body = try container.decode(String.self, forKey: .webhook_body)
        self.success_text = try container.decode(String.self, forKey: .success_text)
        self.success_url = try container.decode(String.self, forKey: .success_url)
        self.fiat_base_multiplier = try container.decode(Int.self, forKey: .fiat_base_multiplier)
        self.username = try container.decode(String.self, forKey: .username)
        self.zaps = try container.decode(Bool.self, forKey: .zaps)
    }
    
    init(description: String, wallet: String, min: Int, max: Int, currency: String, comment_chars: Int, webhook_url: String, webhook_headers: String, webhook_body: String, success_text: String, success_url: String, fiat_base_multiplier: Int, username: String, zaps: Bool) {
        self.description = description
        self.wallet = wallet
        self.min = min
        self.max = max
        self.currency = currency
        self.comment_chars = comment_chars
        self.webhook_url = webhook_url
        self.webhook_headers = webhook_headers
        self.webhook_body = webhook_body
        self.success_text = success_text
        self.success_url = success_url
        self.fiat_base_multiplier = fiat_base_multiplier
        self.username = username
        self.zaps = zaps
    }
}
