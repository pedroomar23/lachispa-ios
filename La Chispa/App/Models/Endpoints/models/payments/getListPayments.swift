//
//  getListPayments.swift
//  La Chispa
//
//  Created by Pedro Omar  on 9/24/25.
//

import Foundation

struct GetPaymentsForDay: Decodable, Hashable, Encodable {
    let date: String
    let balance: Int
    let balance_in: Int
    let payments_count: Int
    let count_in: Int
    let count_out: Int
    let fee: Int
    
    enum CodingKeys: String, CodingKey {
        case date = "date"
        case balance = "balance"
        case balance_in = "balance_in"
        case payments_count = "payments_count"
        case count_in = "count_in"
        case count_out = "count_out"
        case fee = "fee"
    }
    
    init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.date = try container.decode(String.self, forKey: .date)
        self.balance = try container.decode(Int.self, forKey: .balance)
        self.balance_in = try container.decode(Int.self, forKey: .balance_in)
        self.payments_count = try container.decode(Int.self, forKey: .payments_count)
        self.count_in = try container.decode(Int.self, forKey: .count_in)
        self.count_out = try container.decode(Int.self, forKey: .count_out)
        self.fee = try container.decode(Int.self, forKey: .fee)
    }
    
    init(date: String, balance: Int, balance_in: Int, payments_count: Int, count_in: Int, count_out: Int, fee: Int) {
        self.date = date
        self.balance = balance
        self.balance_in = balance_in
        self.payments_count = payments_count
        self.count_in = count_in
        self.count_out = count_out
        self.fee = fee
    }
}
