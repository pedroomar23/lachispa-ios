//
//  createSwap.swift
//  La Chispa
//
//  Created by Pedro Omar  on 11/17/25.
//

import Foundation

struct CreateOrden: Decodable, Hashable, Encodable {
    let type: String
    let fromCcy: String
    let toCcy: String
    let direction: String
    let amount: Int
    let toAddress: String
    let tag: Bool
    let refcode: String
    let afftax: Float
    
    enum CodingKeys: String, CodingKey {
        case type = "type"
        case fromCcy = "fromCcy"
        case toCcy = "toCcy"
        case direction = "direction"
        case amount = "amount"
        case toAddress = "toAddress"
        case tag = "tag"
        case refcode = "refcode"
        case afftax = "afftax"
    }
}

struct ResponseOrden: Decodable, Hashable, Encodable {
    let code: Int
    let msg: String
    let data: Datas
    let to: TO
    let back: Back
    let emergency: Emergency
    let token: String
    
    enum CodingKeys: String, CodingKey {
        case code = "code"
        case msg = "msg"
        case data = "data"
        case to = "to"
        case back = "back"
        case emergency = "emergency"
        case token = "token"
    }
}

struct Datas: Decodable, Hashable, Encodable {
    let id: String
    let type: String
    let email: String
    let status: String
    let time: Time
    let from: From
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case type = "type"
        case email = "email"
        case status = "status"
        case time = "time"
        case from = "from"
    }
}

struct Time: Decodable, Hashable, Encodable {
    let reg: Int
    let start: String?
    let finish: String?
    let update: Int
    let expiration: Int
    let left: Int
    
    enum CodingKeys: String, CodingKey {
        case reg = "reg"
        case start = "start"
        case finish = "finish"
        case update = "update"
        case expiration = "expiration"
        case left = "left"
    }
}

struct From: Decodable, Hashable, Encodable {
    let code: String
    let coin: String
    let network: String
    let name: String
    let alias: String
    let amount: Double
    let address: String
    let addressAlt: String?
    let tag: Bool?
    let tagName: String?
    let reqConfirmations: Int
    let maxConfirmations: Int
    let tx: TX
    
    enum CodingKeys: String, CodingKey {
        case code = "code"
        case coin = "coin"
        case network = "network"
        case name = "name"
        case alias = "alias"
        case amount = "amount"
        case address = "address"
        case addressAlt = "addressAlt"
        case tag = "tag"
        case tagName = "tagName"
        case reqConfirmations = "reqConfirmations"
        case maxConfirmations = "maxConfirmations"
        case tx = "tx"
    }
}

struct TX: Decodable, Hashable, Encodable {
    let id: String?
    let amount: Double?
    let fee: Int?
    let ccyfee: Int?
    let timeReg: Int
    let timeBlock: Bool?
    let confirmations: Bool
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case amount = "amount"
        case fee = "fee"
        case ccyfee = "ccyfee"
        case timeReg = "timeReg"
        case timeBlock = "timeBlock"
        case confirmations = "confirmations"
    }
}

struct TO: Decodable, Hashable, Encodable {
    let code: String
    let coin: String
    let network: String
    let name: String
    let amount: Double
    let address: String
    let tag: Bool?
    let tagName: String?
    let tx: TX
    
    enum CodingKeys: String, CodingKey {
        case code = "code"
        case coin = "coin"
        case network = "network"
        case name = "name"
        case amount = "amount"
        case address = "address"
        case tag = "tag"
        case tagName = "tagName"
        case tx = "tx"
    }
}

struct Back: Decodable, Hashable, Encodable {
    let code: String?
    let coin: String?
    let network: String?
    let name: String?
    let amount: Double?
    let address: String?
    let tag: Bool?
    let tagName: String?
    let tx: TX?
    
    enum CodingKeys: String, CodingKey {
        case code = "code"
        case coin = "coin"
        case network = "network"
        case name = "name"
        case amount = "amount"
        case address = "address"
        case tag = "tag"
        case tagName = "tagName"
        case tx = "tx"
    }
}

struct Emergency: Decodable, Hashable, Encodable {
    let status: [String]
    let choice: String
    let `repeat`: Int
    
    enum CodingKeys: String, CodingKey {
        case status = "status"
        case choice = "choice"
        case `repeat` = "repeat"
    }
}
