//
//  createInvoice.swift
//  La Chispa
//
//  Created by Pedro Omar  on 9/18/25.
//

import Foundation

struct CreateInvoice: Decodable, Hashable, Encodable {
    let bolt11: String
    let out: Bool
    let amount: Int
    let unit: String
    let memo: String?
    
    enum CodingKeys: String, CodingKey {
        case bolt11 = "bolt11"
        case out = "out"
        case amount = "amount"
        case unit = "unit"
        case memo = "memo"
    }
    
    init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.bolt11 = try container.decode(String.self, forKey: .bolt11)
        self.out = try container.decode(Bool.self, forKey: .out)
        self.amount = try container.decode(Int.self, forKey: .amount)
        self.unit = try container.decode(String.self, forKey: .unit)
        self.memo = try container.decodeIfPresent(String.self, forKey: .memo)
    }
    
    init(bolt11: String, out: Bool, amount: Int, unit: String, memo: String?) {
        self.bolt11 = bolt11
        self.out = out
        self.amount = amount * 1000 
        self.unit = unit
        self.memo = memo
    }
}

struct CreateInvoiceResponse: Decodable, Hashable, Encodable {
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
    let webhook_status: Int?
    let preimage: String
    let tag: String?
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
        self.fiat_provider = try container.decodeIfPresent(String.self, forKey: .fiat_provider) ?? ""
        self.status = try container.decode(String.self, forKey: .status)
        self.memo = try container.decode(String.self, forKey: .memo)
        self.expiry = try container.decode(String.self, forKey: .expiry)
        self.webhook = try container.decodeIfPresent(String.self, forKey: .webhook) ?? ""
        self.webhook_status = try container.decodeIfPresent(Int.self, forKey: .webhook_status)
        self.preimage = try container.decode(String.self, forKey: .preimage)
        self.tag = try container.decodeIfPresent(String.self, forKey: .tag) ?? ""
        self.extension = try container.decodeIfPresent(String.self, forKey: .extension) ?? ""
        self.time = try container.decode(String.self, forKey: .time)
        self.created_at = try container.decode(String.self, forKey: .created_at)
        self.updated_at = try container.decode(String.self, forKey: .updated_at)
        self.extra = try container.decodeIfPresent(ExtraData.self.self, forKey: .extra)
    }
    
    init(cheking_id: String, payment_hash: String, wallet_id: String, amount: Int, fee: Int, bolt11: String, fiat_provider: String?, status: String, memo: String, expiry: String, webhook: String?, webhook_status: Int?, preimage: String, tag: String?, `extension`: String?, time: String, created_at: String, updated_at: String, extra: ExtraData?) {
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

struct ExtraData: Decodable, Hashable, Encodable {
    let wallet_fiat_currency: String
    let wallet_fiat_amount: Double
    let wallet_fiat_rate: Double
    let wallet_btc_rate: Double
    
    enum CodingKeys: String, CodingKey {
        case wallet_fiat_currency = "wallet_fiat_currency"
        case wallet_fiat_amount = "wallet_fiat_amount"
        case wallet_fiat_rate = "wallet_fiat_rate"
        case wallet_btc_rate = "wallet_btc_rate"
    }
    
    init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.wallet_fiat_currency = try container.decode(String.self, forKey: .wallet_fiat_currency)
        self.wallet_fiat_amount = try container.decode(Double.self, forKey: .wallet_fiat_amount)
        self.wallet_fiat_rate = try container.decode(Double.self, forKey: .wallet_fiat_rate)
        self.wallet_btc_rate = try container.decode(Double.self, forKey: .wallet_btc_rate)
    }
    
    init(wallet_fiat_currency: String, wallet_fiat_amount: Double, wallet_fiat_rate: Double, wallet_btc_rate: Double) {
        self.wallet_fiat_currency = wallet_fiat_currency
        self.wallet_fiat_amount = wallet_fiat_amount
        self.wallet_fiat_rate = wallet_fiat_rate
        self.wallet_btc_rate = wallet_btc_rate
    }
}
