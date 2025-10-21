//
//  getLNURL.swift
//  La Chispa
//
//  Created by Pedro Omar  on 10/20/25.
//

import Foundation

struct GetLNURLUsername: Decodable, Hashable, Encodable {
    let tag: String
    let callback: String
    let minSendable: Int
    let maxSendable: Int
    let metadata: String
    let commentAllowed: Int
    let allowsNostr: Bool
    let nostrPubkey: String
    
    var displayName: String {
        if let metadataArray = try? JSONSerialization.jsonObject(with: Data(metadata.utf8)) as? [[String]],
           metadataArray.count > 1,
           let identifier = metadataArray[1].last,
           let atIndex = identifier.firstIndex(of: "@") {
            return String(identifier[..<atIndex])
        }
        return "Unknown"
    }
    
    enum CodingKeys: String, CodingKey {
        case tag = "tag"
        case callback = "callback"
        case minSendable = "minSendable"
        case maxSendable = "maxSendable"
        case metadata = "metadata"
        case commentAllowed = "commentAllowed"
        case allowsNostr = "allowsNostr"
        case nostrPubkey = "nostrPubkey"
    }
    
    init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.tag = try container.decode(String.self, forKey: .tag)
        self.callback = try container.decode(String.self, forKey: .callback)
        self.minSendable = try container.decode(Int.self, forKey: .minSendable)
        self.maxSendable = try container.decode(Int.self, forKey: .maxSendable)
        self.metadata = try container.decode(String.self, forKey: .metadata)
        self.commentAllowed = try container.decode(Int.self, forKey: .commentAllowed)
        self.allowsNostr = try container.decode(Bool.self, forKey: .allowsNostr)
        self.nostrPubkey = try container.decode(String.self, forKey: .nostrPubkey)
    }
    
    init(tag: String, callback: String, minSendable: Int, maxSendable: Int, metadata: String, commentAllowed: Int, allowsNostr: Bool, nostrPubkey: String) {
        self.tag = tag
        self.callback = callback
        self.minSendable = minSendable
        self.maxSendable = maxSendable
        self.metadata = metadata
        self.commentAllowed = commentAllowed
        self.allowsNostr = allowsNostr
        self.nostrPubkey = nostrPubkey
    }
}
