//
//  createInvoice.swift
//  La Chispa
//
//  Created by Pedro Omar  on 9/18/25.
//

import Foundation

struct CreateInvoiceRequest: Decodable, Hashable, Encodable {
    let unit: String
    let `internal`: Bool
    let out: Bool
    let amount: Int
    let memo: String
    let description_hash: String
    let unhashed_description: String
    let expiry: Int
    let extra: Extra
    let webhook: String
    let bolt11: String
    let lnurl_callback: String
    let fiat_provider: String
    
    enum CodingKeys: String, CodingKey {
        case unit = "unit"
        case `internal` = "internal"
        case out = "out"
        case amount = "amount"
        case memo = "memo"
        case description_hash = "description_hash"
        case unhashed_description = "unhashed_description"
        case expiry = "expiry"
        case extra = "extra"
        case webhook = "webhook"
        case bolt11 = "bolt11"
        case lnurl_callback = "lnurl_callback"
        case fiat_provider = "fiat_provider"
    }
    
    init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.unit = try container.decode(String.self, forKey: .unit)
        self.internal = try container.decode(Bool.self, forKey: .internal)
        self.out = try container.decode(Bool.self, forKey: .out)
        self.amount = try container.decode(Int.self, forKey: .amount)
        self.memo = try container.decode(String.self, forKey: .memo)
        self.description_hash = try container.decode(String.self, forKey: .description_hash)
        self.unhashed_description = try container.decode(String.self, forKey: .unhashed_description)
        self.expiry = try container.decode(Int.self, forKey: .expiry)
        self.extra = try container.decode(Extra.self, forKey: .extra)
        self.webhook = try container.decode(String.self, forKey: .webhook)
        self.bolt11 = try container.decode(String.self, forKey: .bolt11)
        self.lnurl_callback = try container.decode(String.self, forKey: .lnurl_callback)
        self.fiat_provider = try container.decode(String.self, forKey: .fiat_provider)
    }
    
    init(unit: String, `internal`: Bool, out: Bool, amount: Int, memo: String, description_hash: String, unhashed_description: String, expiry: Int, extra: Extra, webhook: String, bolt11: String, lnurl_callback: String, fiat_provider: String) {
        self.unit = unit
        self.`internal` = `internal`
        self.out = out
        self.amount = amount
        self.memo = memo
        self.description_hash = description_hash
        self.unhashed_description = unhashed_description
        self.expiry = expiry
        self.extra = extra
        self.webhook = webhook
        self.bolt11 = bolt11
        self.lnurl_callback = lnurl_callback
        self.fiat_provider = fiat_provider
    }
}

struct CreateInvoiceResponse: Decodable, Hashable, Encodable {
    let checking_id: String
    let payment_hash: String
    let wallet_id: String
    let amount: Int 
    let fee: Int
    let bolt11: String
    let fiat_provider: String
    let status: String
    let memo: String
    let expiry: String
    let webhook: String
    let webhook_status: String
    let preimage: String
    let tag: String
    let `extension`: String
    let time: String
    let created_at: String
    let updated_at: String
    let extra: String
    
    enum CodingKeys: String, CodingKey {
        case checking_id = "cheking_id"
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
        self.fiat_provider = try container.decode(String.self, forKey: .fiat_provider)
        self.status = try container.decode(String.self, forKey: .status)
        self.memo = try container.decode(String.self, forKey: .memo)
        self.expiry = try container.decode(String.self, forKey: .expiry)
        self.webhook = try container.decode(String.self, forKey: .webhook)
        self.webhook_status = try container.decode(String.self, forKey: .webhook_status)
        self.preimage = try container.decode(String.self, forKey: .preimage)
        self.tag = try container.decode(String.self, forKey: .tag)
        self.extension = try container.decode(String.self, forKey: .extension)
        self.time = try container.decode(String.self, forKey: .time)
        self.created_at = try container.decode(String.self, forKey: .created_at)
        self.updated_at = try container.decode(String.self, forKey: .updated_at)
        self.extra = try container.decode(String.self, forKey: .extra)
    }
    
    init(cheking_id: String, payment_hash: String, wallet_id: String, amount: Int, fee: Int, bolt11: String, fiat_provider: String, status: String, memo: String, expiry: String, webhook: String, webhook_status: String, preimage: String, tag: String, `extension`: String, time: String, created_at: String, updated_at: String, extra: String) {
        self.checking_id = cheking_id
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
