//
//  getPaymentsAllUsers.swift
//  La Chispa
//
//  Created by Pedro Omar  on 9/24/25.
//

import Foundation

struct GetPaymentsAllUsers: Decodable, Hashable, Encodable {
    let field: String
    let total: Int
    
    enum CodingKeys: String, CodingKey {
        case field = "field"
        case total = "total"
    }
    
    init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.field = try container.decode(String.self, forKey: .field)
        self.total = try container.decode(Int.self, forKey: .total)
    }
    
    init(field: String, total: Int) {
        self.field = field
        self.total = total
    }
}
