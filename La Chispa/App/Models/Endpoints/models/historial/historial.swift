//
//  historial.swift
//  La Chispa
//
//  Created by Pedro Omar  on 9/23/25.
//

import Foundation

struct HistorialResponse: Decodable, Hashable, Encodable {
    let date: String
    let income: Int
    let spending: Int
    let balance: Int
    
    enum CodingKeys: String, CodingKey {
        case date = "date"
        case income = "income"
        case spending = "spending"
        case balance = "balance"
    }
    
    init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.date = try container.decode(String.self, forKey: .date)
        self.income = try container.decode(Int.self, forKey: .income)
        self.spending = try container.decode(Int.self, forKey: .spending)
        self.balance = try container.decode(Int.self, forKey: .balance)
    }
    
    init(date: String, income: Int, spending: Int, balance: Int) {
        self.date = date
        self.income = income
        self.spending = spending
        self.balance = balance
    }
}
