//
//  createPayments.swift
//  La Chispa
//
//  Created by Pedro Omar  on 10/16/25.
//

import Foundation

struct CreatePayments: Decodable, Hashable, Encodable {
    let out: Bool
    let amount: Int
    var unit: String
    
    enum CodingKeys: String, CodingKey {
        case out = "out"
        case amount = "amount"
        case unit = "unit"
    }
    
    init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.out = try container.decode(Bool.self, forKey: .out)
        self.amount = try container.decode(Int.self, forKey: .amount)
        self.unit = try container.decode(String.self, forKey: .unit)
    }
    
    init(out: Bool, amount: Int, unit: String) {
        self.out = out
        self.amount = amount
        self.unit = unit
    }
}
