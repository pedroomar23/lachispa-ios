//
//  La_ChispaTests.swift
//  La ChispaTests
//
//  Created by Pedro Omar  on 9/10/25.
//

import XCTest
@testable import La_Chispa

final class La_ChispaTests: XCTestCase {
    
    // MARK: - Test Login
    
    func testLoginRequest() async throws {
        let jsonString = """
            {
              "username": "string",
              "password": "string"
            }
        """
        let decoder = JSONDecoder()
        let jsonData = jsonString.data(using: .utf8)!
        let loginJSON = try decoder.decode(LoginRequest.self, from: jsonData)
        print("Respuesta del JSON: \(loginJSON)")
        
        XCTAssertEqual(loginJSON.username, "string")
        XCTAssertEqual(loginJSON.password, "string")
    }
    
    func testLoginResponse() async throws {
        let jsonString = """
            {
              "id": "string",
              "created_at": "2025-09-14T18:45:08.198Z",
              "updated_at": "2025-09-14T18:45:08.198Z",
              "email": "string",
              "username": "string",
              "pubkey": "string",
              "external_id": "string",
              "extensions": [],
              "wallets": [],
              "admin": false,
              "super_user": false,
              "fiat_providers": [],
              "has_password": false,
              "extra": {
                "email_verified": false,
                "provider": "lnbits",
                "visible_wallet_count": 10
              }
            }
        """
        let decoder = JSONDecoder()
        let jsonData = jsonString.data(using: .utf8)!
        let loginJson = try decoder.decode(LoginAuth.self, from: jsonData)
        print("Respuesta del JSON: \(loginJson)")
        
        XCTAssertEqual(loginJson.id, "string")
        XCTAssertEqual(loginJson.created_at, "2025-09-14T18:45:08.198Z")
        XCTAssertEqual(loginJson.updated_at, "2025-09-14T18:45:08.198Z")
        XCTAssertEqual(loginJson.email, "string")
        XCTAssertEqual(loginJson.pubkey, "string")
        XCTAssertEqual(loginJson.external_id, "string")
        XCTAssertEqual(loginJson.extensions, [])
        XCTAssertEqual(loginJson.wallets, [])
        XCTAssertEqual(loginJson.admin, false)
        XCTAssertEqual(loginJson.super_user, false)
        XCTAssertEqual(loginJson.fiat_providers, [])
        XCTAssertEqual(loginJson.has_password, false)
        XCTAssertEqual(loginJson.extra.email_verified, false)
       
        XCTAssertEqual(loginJson.extra.visible_wallet_count, 10)
    }
    
    // MARK: - Test Register
    
    func testRegister() async throws {
        let jsonString = """
            {
              "email": "string",
              "username": "string",
              "password": "stringst",
              "password_repeat": "stringst"
            }
        """
        let decoder = JSONDecoder()
        let jsonData = jsonString.data(using: .utf8)!
        let registerJSON = try decoder.decode(RegisterRequest.self, from: jsonData)
        print("Respuesta del JSON: \(registerJSON)")
        
        XCTAssertEqual(registerJSON.email, "string")
        XCTAssertEqual(registerJSON.username, "string")
        XCTAssertEqual(registerJSON.password, "stringst")
        XCTAssertEqual(registerJSON.password_repeat, "stringst")
    }
    
    // MARK: - Test Change Password
    
    func testChangePassword() async throws {
        let jsonString = """
            {
              "reset_key": "string",
              "password": "stringst",
              "password_repeat": "stringst"
            }
        """
        let decoder = JSONDecoder()
        let jsonData = jsonString.data(using: .utf8)!
        let changeJSON = try decoder.decode(PasswordRequest.self, from: jsonData)
        print("Respuesta del JSON: \(changeJSON)")
        
        XCTAssertEqual(changeJSON.reset_key, "string")
        XCTAssertEqual(changeJSON.password, "stringst")
        XCTAssertEqual(changeJSON.password_repeat, "stringst")
    }
    
    // MARK: - Test Create or Pay a Invoice
    
    func testPayCreate() async throws {
        let jsonString = """
            {
              "unit": "sat",
              "internal": false,
              "out": true,
              "amount": 0,
              "memo": "string",
              "description_hash": "string",
              "unhashed_description": "string",
              "expiry": 0,
              "extra": {},
              "webhook": "string",
              "bolt11": "string",
              "lnurl_callback": "string",
              "fiat_provider": "string"
            }
        """
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        let jsonData = jsonString.data(using: .utf8)!
        let payCreateJSON = try decoder.decode(CreateInvoiceRequest.self, from: jsonData)
        print("JSON Response: \(payCreateJSON)")
        
        XCTAssertEqual(payCreateJSON.unit, "sat")
        XCTAssertEqual(payCreateJSON.internal, false)
        XCTAssertEqual(payCreateJSON.out, true)
        XCTAssertEqual(payCreateJSON.amount, 0)
        XCTAssertEqual(payCreateJSON.memo, "string")
        XCTAssertEqual(payCreateJSON.description_hash, "")
        XCTAssertEqual(payCreateJSON.unhashed_description, "string")
        XCTAssertEqual(payCreateJSON.expiry, 0)
        XCTAssertEqual(payCreateJSON.extra.email_verified, false)
        XCTAssertEqual(payCreateJSON.extra.visible_wallet_count, 10)
        XCTAssertEqual(payCreateJSON.webhook, "string")
        XCTAssertEqual(payCreateJSON.bolt11, "string")
        XCTAssertEqual(payCreateJSON.lnurl_callback, "string")
        XCTAssertEqual(payCreateJSON.fiat_provider, "string")
    }
}
