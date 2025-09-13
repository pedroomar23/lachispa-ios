//
//  EndpointsApi.swift
//  La Chispa
//
//  Created by Pedro Omar  on 9/12/25.
//

import Foundation
import SwiftUI
import os.log

class EndpointsApi {
    static let shared : EndpointsApi = EndpointsApi()
    let logger = Logger()
    let session : URLSession = {
        let configuration = URLSessionConfiguration.default
        configuration.httpCookieStorage = HTTPCookieStorage.shared
        configuration.timeoutIntervalForRequest = 10
        return URLSession(configuration: configuration)
    }()
    
    // MARK: - Register
    
    func register(email: String, username: String, password: String, password_repeat: String, completion: @escaping @Sendable (Result<RegisterResponse, EndpointFailure>) -> Void) async {
        let decoder = JSONDecoder()
        var request = URLRequest(url: EndopointUrl.register.url)
        request.httpMethod = "POST"
        request.timeoutInterval = 15
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        
        logger.info("Iniciando Solicitud a POST: \(EndopointUrl.register.url.absoluteString)")
        
        do {
            let (data, response) = try await session.data(for: request)
            
            if let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 {
                let registerJSON = try decoder.decode(RegisterRequest.self, from: data)
                print("JSON Response: \(registerJSON)")
            } else {
                print("Failure JSON Response")
            }
            
            if let jsonData = String(data: data, encoding: .utf8) {
                print("Server Response: \(jsonData)")
            } else {
                print("Failure Server Response")
            }
        } catch {
            completion(.failure(EndpointFailure.jsonFailure(message: "Failure Response: \(error.localizedDescription)")))
        }
    }
}
