//
//  payLNURL.swift
//  La Chispa
//
//  Created by Pedro Omar  on 10/27/25.
//

import Foundation

struct PayLNURLRequest: Decodable, Hashable, Encodable {
    let description_hash: String
    let callback: String
    let amount: Int
    let comment: String
    let description: String
    let unit: String
    
    enum CodingKeys: String, CodingKey {
        case description_hash = "description_hash"
        case callback = "callback"
        case amount = "amount"
        case comment = "comment"
        case description = "description"
        case unit = "unit"
    }
    
    init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.description_hash = try container.decode(String.self, forKey: .description_hash)
        self.callback = try container.decode(String.self, forKey: .callback)
        self.amount = try container.decode(Int.self, forKey: .amount)
        self.comment = try container.decode(String.self, forKey: .comment)
        self.description = try container.decode(String.self, forKey: .description)
        self.unit = try container.decode(String.self, forKey: .unit)
    }
    
    init(description_hash: String, callback: String, amount: Int, comment: String, description: String, unit: String) {
        self.description_hash = description_hash
        self.callback = callback
        self.amount = amount
        self.comment = comment
        self.description = description
        self.unit = unit
    }
}

struct PayLNURLResponse: Decodable, Hashable, Encodable {
    let checking_id: String
    let payment_hash: String
    let wallet_id: String
    let amount: Int
    let fee: Int
    let bolt11: String
    let fiat_provider: String?
    let status: String
    let memo: String?
    let expiry: String
    let webhook: String?
    let webhook_status: String?
    let preimage: String
    let tag: String
    let `extension`: String?
    let time: String
    let created_at: String
    let updated_at: String
    let extra: ExtraData?
    
    enum CodingKeys: String, CodingKey {
        case checking_id = "checking_id"
        case payment_hash = "payment_hash"
        case wallet_id = "wallet_id"
        case amount = "amount"
        case fee = "fee"
        case bolt11 = "bolt11"
        case fiat_provider = "fiat_provider"
        case status = "status"
        case memo = "memo"
        case expiry = "expiry"
        case webhook = "webhook"
        case webhook_status = "webhook_status"
        case preimage = "preimage"
        case tag = "tag"
        case `extension` = "extension"
        case time = "time"
        case created_at = "created_at"
        case updated_at = "updated_at"
        case extra = "extra"
    }
    
    init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.checking_id = try container.decode(String.self, forKey: .checking_id)
        self.payment_hash = try container.decode(String.self, forKey: .payment_hash)
        self.wallet_id = try container.decode(String.self, forKey: .wallet_id)
        self.amount = try container.decode(Int.self, forKey: .amount)
        self.fee = try container.decode(Int.self, forKey: .fee)
        self.bolt11 = try container.decode(String.self, forKey: .bolt11)
        self.fiat_provider = try container.decodeIfPresent(String.self, forKey: .fiat_provider)
        self.status = try container.decode(String.self, forKey: .status)
        self.memo = try container.decodeIfPresent(String.self, forKey: .memo)
        self.expiry = try container.decode(String.self, forKey: .expiry)
        self.webhook = try container.decodeIfPresent(String.self, forKey: .webhook)
        self.webhook_status = try container.decodeIfPresent(String.self, forKey: .webhook_status)
        self.preimage = try container.decode(String.self, forKey: .preimage)
        self.tag = try container.decode(String.self, forKey: .tag)
        self.extension = try container.decodeIfPresent(String.self, forKey: .extension)
        self.time = try container.decode(String.self, forKey: .time)
        self.created_at = try container.decode(String.self, forKey: .created_at)
        self.updated_at = try container.decode(String.self, forKey: .updated_at)
        self.extra = try container.decodeIfPresent(ExtraData.self, forKey: .extra)
    }
    
    init(checking_id: String, payment_hash: String, wallet_id: String, amount: Int, fee: Int, bolt11: String, fiat_provider: String?, status: String, memo: String?, expiry: String, webhook: String?, webhook_status: String?, preimage: String, tag: String, `extension`: String, time: String, created_at: String, updated_at: String, extra: ExtraData?) {
        self.checking_id = checking_id
        self.payment_hash = payment_hash
        self.wallet_id = wallet_id
        self.amount = amount
        self.fee = fee
        self.bolt11 = bolt11
        self.fiat_provider = fiat_provider
        self.status = status
        self.memo = memo
        self.expiry = expiry
        self.webhook = webhook
        self.webhook_status = webhook_status
        self.preimage = preimage
        self.tag = tag
        self.`extension` = `extension`
        self.time = time
        self.created_at = created_at
        self.updated_at = updated_at
        self.extra = extra
    }
}
