//
//  swapsList.swift
//  La Chispa
//
//  Created by Pedro Omar  on 10/23/25.
//

import Foundation

struct ListSwap: Decodable, Hashable, Encodable, Identifiable {
    let id: String
    let wallet: String
    let asset: String
    let amount: Int
    let direction: String
    let feerate: Bool
    let feerate_value: Int
    let payment_hash: String
    let time: String
    let status: String
    let refund_privkey: String
    let refund_address: String
    let boltz_id: String
    let expected_amount: Int
    let timeout_block_height: Int
    let address: String
    let bip21: String
    let redeem_script: String
    let blinding_key: String
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case wallet = "wallet"
        case asset = "asset"
        case amount = "amount"
        case direction = "direction"
        case feerate = "feerate"
        case feerate_value = "feerate_value"
        case payment_hash = "payment_hash"
        case time = "time"
        case status = "status"
        case refund_privkey = "refund_privkey"
        case refund_address = "refund_address"
        case boltz_id = "boltz_id"
        case expected_amount = "expected_amount"
        case timeout_block_height = "timeout_block_height"
        case address = "address"
        case bip21 = "bip21"
        case redeem_script = "redeem_script"
        case blinding_key = "bilnding_key"
    }
    
    init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decode(String.self, forKey: .id)
        self.wallet = try container.decode(String.self, forKey: .wallet)
        self.asset = try container.decode(String.self, forKey: .asset)
        self.amount = try container.decode(Int.self, forKey: .amount)
        self.direction = try container.decode(String.self, forKey: .direction)
        self.feerate = try container.decode(Bool.self, forKey: .feerate)
        self.feerate_value = try container.decode(Int.self, forKey: .feerate_value)
        self.payment_hash = try container.decode(String.self, forKey: .payment_hash)
        self.time = try container.decode(String.self, forKey: .time)
        self.status = try container.decode(String.self, forKey: .status)
        self.refund_privkey = try container.decode(String.self, forKey: .refund_privkey)
        self.refund_address = try container.decode(String.self, forKey: .refund_address)
        self.boltz_id = try container.decode(String.self, forKey: .boltz_id)
        self.expected_amount = try container.decode(Int.self, forKey: .expected_amount)
        self.timeout_block_height = try container.decode(Int.self, forKey: .timeout_block_height)
        self.address = try container.decode(String.self, forKey: .address)
        self.bip21 = try container.decode(String.self, forKey: .bip21)
        self.redeem_script = try container.decode(String.self, forKey: .redeem_script)
        self.blinding_key = try container.decode(String.self, forKey: .blinding_key)
    }
    
    init(id: String, wallet: String, asset: String, amount: Int, direction: String, feerate: Bool, feerate_value: Int, payment_hash: String, time: String, status: String, refund_privkey: String, refund_address: String, boltz_id: String, expected_amount: Int, timeout_block_height: Int, address: String, bip21: String, redeem_script: String, blinding_key: String) {
        self.id = id
        self.wallet = wallet
        self.asset = asset
        self.amount = amount
        self.direction = direction
        self.feerate = feerate
        self.feerate_value = feerate_value
        self.payment_hash = payment_hash
        self.time = time
        self.status = status
        self.refund_privkey = refund_privkey
        self.refund_address = refund_address
        self.boltz_id = boltz_id
        self.expected_amount = expected_amount
        self.timeout_block_height = timeout_block_height
        self.address = address
        self.bip21 = bip21
        self.redeem_script = redeem_script
        self.blinding_key = blinding_key
    }
}
