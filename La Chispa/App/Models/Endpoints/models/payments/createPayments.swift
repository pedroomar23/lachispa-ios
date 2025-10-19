//
//  createPayments.swift
//  La Chispa
//
//  Created by Pedro Omar  on 10/16/25.
//

import Foundation

struct CreatePayments: Decodable, Hashable, Encodable {
    let bolt11: String
    let out: Bool
    let amount: Int
    var unit: String
    
    enum CodingKeys: String, CodingKey {
        case bolt11 = "bolt11"
        case out = "out"
        case amount = "amount"
        case unit = "unit"
    }
    
    init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.bolt11 = try container.decode(String.self, forKey: .bolt11)
        self.out = try container.decode(Bool.self, forKey: .out)
        self.amount = try container.decode(Int.self, forKey: .amount)
        self.unit = try container.decode(String.self, forKey: .unit)
    }
    
    init(bolt11: String, out: Bool, amount: Int, unit: String) {
        self.bolt11 = bolt11
        self.out = out
        self.amount = amount
        self.unit = unit
    }
}
