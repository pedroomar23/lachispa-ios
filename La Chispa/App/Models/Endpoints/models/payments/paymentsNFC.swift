//
//  paymentsNFC.swift
//  La Chispa
//
//  Created by Pedro Omar  on 10/28/25.
//

import Foundation

struct PaymentNFCRequest: Decodable, Hashable, Encodable {
    let lnurl_w: String
    
    enum CodingKeys: String, CodingKey {
        case lnurl_w = "lnurl_w"
    }
    
    init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.lnurl_w = try container.decode(String.self, forKey: .lnurl_w)
    }
    
    init(lnurl_w: String) {
        self.lnurl_w = lnurl_w
    }
}
