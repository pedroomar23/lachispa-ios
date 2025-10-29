//
//  WalletsApi.swift
//  La Chispa
//
//  Created by Pedro Omar  on 10/28/25.
//

import Foundation
import SwiftUI
import os.log

class WalletsApi {
    static let shared : WalletsApi = WalletsApi()
    let logger = Logger()
    let session : URLSession = {
        let configuration = URLSessionConfiguration.default
        configuration.httpCookieStorage = HTTPCookieStorage.shared
        configuration.timeoutIntervalForRequest = 10
        return URLSession(configuration: configuration)
    }()
    
    // MARK: - Create Wallet
    
    func createWallet(name: String, completion: @escaping @Sendable (Result<CreateWalletResponse, EndpointFailure>) -> Void) async {
        let decoder = JSONDecoder()
        var request = URLRequest(url: EndpointUrl.wallet.url)
        request.httpMethod = "POST"
        request.timeoutInterval = 10
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("c38ef8a288024b82a5951bcc06143999", forHTTPHeaderField: "X-Api-Key")
        
        logger.info("Initializing Solicite: \(EndpointUrl.wallet.url.absoluteString)")
        
        let createWallet = CreateWalletRequest(
            name: name
        )
        print("JSONResponse: \(createWallet)")
        
        do {
            let jsonBody = try JSONEncoder().encode(createWallet)
            request.httpBody = jsonBody
            
            let (data, response) = try await session.data(for: request)
            
            if let httpResponse = response as? HTTPURLResponse {
                print("Server Response: \(httpResponse.statusCode)")
                
                if let jsonData = String(data: data, encoding: .utf8) {
                    print("Server Response: \(jsonData)")
                } else {
                    print("Server Failure Response")
                }
                
                switch httpResponse.statusCode {
                case 200:
                    let createWalletResponse = try decoder.decode(CreateWalletResponse.self, from: data)
                    print("JSON Response: \(createWalletResponse)")
                    completion(.success(createWalletResponse))
                case 422:
                    let errorDetails = String(data: data, encoding: .utf8)
                    print("JSON Failure Response: \(String(describing: errorDetails))")
                default:
                    completion(.failure(EndpointFailure.jsonFailure(message: "Server Failure Response: \(httpResponse.statusCode)")))
                }
            }
        } catch {
            completion(.failure(EndpointFailure.jsonFailure(message: "JSON Failure Response: \(error.localizedDescription)")))
        }
    }
    
    // MARK: - Update Wallet
    
    func updateWallet(name: String, icon: String, color: String, currency: String, pinned: Bool, completion: @escaping @Sendable (Result<UpdatedWalletResponse, EndpointFailure>) -> Void) async {
        let decoder = JSONDecoder()
        var request = URLRequest(url: EndpointUrl.updateWallet.url)
        request.httpMethod = "PATCH"
        request.timeoutInterval = 10
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("c38ef8a288024b82a5951bcc06143999", forHTTPHeaderField: "X-Api-Key")
        
        logger.info("Initializing Solicite: \(EndpointUrl.updateWallet.url.absoluteString)")
        
        let updateWallet = UpdatedWalletRequest(
            name: name,
            icon: icon,
            color: color,
            currency: currency,
            pinned: pinned
        )
        print("JSON Response: \(updateWallet)")
        
        do {
            let jsonBody = try JSONEncoder().encode(updateWallet)
            request.httpBody = jsonBody
            
            let (data, response) = try await session.data(for: request)
            
            if let httpResponse = response as? HTTPURLResponse {
                print("Server Response: \(httpResponse.statusCode)")
                
                if let jsonData = String(data: data, encoding: .utf8) {
                    print("Server Response: \(jsonData)")
                } else {
                    print("Server Failure Response")
                }
                
                switch httpResponse.statusCode {
                case 200:
                    let updatedWalletResponse = try decoder.decode(UpdatedWalletResponse.self, from: data)
                    completion(.success(updatedWalletResponse))
                    print("JSON Response: \(updatedWalletResponse)")
                case 422:
                    let errorDetails = String(data: data, encoding: .utf8)
                    print("Server Failure Response: \(String(describing: errorDetails))")
                default:
                    completion(.failure(EndpointFailure.jsonFailure(message: "Server Failure Response: \(httpResponse.statusCode)")))
                }
            }
        } catch {
            completion(.failure(EndpointFailure.jsonFailure(message: "Server Failure Response: \(error.localizedDescription)")))
        }
    }
}
