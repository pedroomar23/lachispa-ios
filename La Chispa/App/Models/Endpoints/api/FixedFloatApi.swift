//
//  FixedFloatApi.swift
//  La Chispa
//
//  Created by Pedro Omar  on 11/3/25.
//

import Foundation
import SwiftUI
import os.log

class FixedFloatApi {
    static let shared : FixedFloatApi = FixedFloatApi()
    let logger = Logger()
    let session : URLSession = {
        let configuration = URLSessionConfiguration.default
        configuration.httpCookieStorage = HTTPCookieStorage.shared
        configuration.timeoutIntervalForRequest = 10
        return URLSession(configuration: configuration)
    }()
    
    func createOrden(type: String, fromCcy: String, toCcy: String, direction: String, amount: Int, toAddress: String, tag: Bool, refcode: String, afftax: CFloat, completion: @escaping @Sendable (Result<ResponseOrden, EndpointFailure>) -> Void) async {
        let decoder = JSONDecoder()
        var request = URLRequest(url: EndpointUrl.createOrden.urlFF)
        request.httpMethod = "POST"
        request.timeoutInterval = 10
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("J2DEyZ4GQSa2kwl0W51HJVRnBtq1nWHeBY4kOkCg", forHTTPHeaderField: "X-API-KEY")
        
        logger.info("Iniciando Solicitud a POST: \(EndpointUrl.createOrden.urlFF.absoluteString)")
        
        let createOrden = CreateOrden(
            type: type,
            fromCcy: fromCcy,
            toCcy: toCcy,
            direction: direction,
            amount: amount,
            toAddress: toAddress,
            tag: tag,
            refcode: refcode,
            afftax: afftax
        )
        print("JSON Request: \(createOrden)")
        
        do {
            let jsonBody = try JSONEncoder().encode(createOrden)
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
                    let createOrdenJSON = try decoder.decode(ResponseOrden.self, from: data)
                    completion(.success(createOrdenJSON))
                    print("JSON Response: \(createOrdenJSON)")
                case 400:
                    let errorDetails = String(data: data, encoding: .utf8)
                    print("Server Failure Response: \(String(describing: errorDetails))")
                default:
                    completion(.failure(EndpointFailure.jsonFailure(message: "Server Failure Response: \(httpResponse.statusCode)")))
                }
            }
        } catch {
            completion(.failure(EndpointFailure.jsonFailure(message: "JSON Failure Response: \(error.localizedDescription)")))
        }
    }
}
