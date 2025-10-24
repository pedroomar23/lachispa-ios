//
//  BoltsApi.swift
//  La Chispa
//
//  Created by Pedro Omar  on 10/20/25.
//

import Foundation
import SwiftUI
import os.log

class BoltsApi {
    static let shared: BoltsApi = BoltsApi()
    let logger = Logger()
    let session : URLSession = {
        let configuration = URLSessionConfiguration.default
        configuration.httpCookieStorage = HTTPCookieStorage.shared
        configuration.timeoutIntervalForRequest = 10
        return URLSession(configuration: configuration)
    }()
    
    // MARK: - Create Swap
    
    func createSwap(wallet: String, asset: String, refund_address: String, amount: Int, direction: String, feerate: Bool, feerate_value: Int, completion: @escaping @Sendable (Result<SwapCreateResponse, EndpointFailure>) -> Void) async {
        let decoder = JSONDecoder()
        var request = URLRequest(url: EndpointUrl.createSwap.url)
        request.httpMethod = "POST"
        request.timeoutInterval = 10
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        logger.info("Initializing Solicitate: \(EndpointUrl.createSwap.url.absoluteString)")
        
        let createSwap = SwapCreate(
            wallet: wallet,
            asset: asset,
            refund_address: refund_address,
            amount: amount,
            direction: direction,
            feerate: feerate,
            feerate_value: feerate_value
        )
        print("JSON Response: \(createSwap)")
        
        do {
            let jsonBody = try JSONEncoder().encode(createSwap)
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
                case 200, 201:
                    let createSwapJson = try decoder.decode(SwapCreateResponse.self, from: data)
                    print("JSON Response: \(createSwapJson)")
                    completion(.success(createSwapJson))
                case 405:
                    let errorDetails = String(data: data, encoding: .utf8)
                    print("JSON Failure Response: \(String(describing: errorDetails))")
                case 422:
                    let errorDetails = String(data: data, encoding: .utf8)
                    print("JSON Failure Response: \(String(describing: errorDetails))")
                default:
                    completion(.failure(EndpointFailure.jsonFailure(message: "Server Failure Response: \(httpResponse.statusCode)")))
                }
            }
        } catch {
            completion(.failure(EndpointFailure.jsonFailure(message: "JSON Response: \(error.localizedDescription)")))
        }
    }
    
    // MARK: - Get List Swap
    
    func getListSwap(completion: @escaping @Sendable (Result<[ListSwap], EndpointFailure>) -> Void) async {
        let decoder = JSONDecoder()
        var request = URLRequest(url: EndpointUrl.getListSwap.url)
        request.httpMethod = "GET"
        request.timeoutInterval = 10
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        logger.info("Initializing Solicitate: \(EndpointUrl.createSwap.url.absoluteString)")
        
        do {
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
                    let listSwapJSON = try decoder.decode([ListSwap].self, from: data)
                    print("JSON Response: \(listSwapJSON)")
                    completion(.success(listSwapJSON))
                case 422:
                    let errorDetails = String(data: data, encoding: .utf8)
                    print("JSON Failure Response: \(String(describing: errorDetails))")
                default:
                    completion(.failure(EndpointFailure.jsonFailure(message: "JSON Response Failre: \(httpResponse.statusCode)")))
                }
            }
        } catch {
            completion(.failure(EndpointFailure.jsonFailure(message: "JSON Response Failure: \(error.localizedDescription)")))
        }
    }
}
