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
    
    // MARK: - Login
    
    func login(username: String, password: String, completion: @escaping @Sendable (Result<LoginResponse, EndpointFailure>) -> Void) async {
        let decoder = JSONDecoder()
        var request = URLRequest(url: EndpointUrl.login.url)
        request.httpMethod = "POST"
        request.timeoutInterval = 15
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        logger.info("Iniciando Solicitud a POST: \(EndpointUrl.login.url.absoluteString)")
        
        let loginRequest = LoginRequest(username: username, password: password)
        
        do {
            let jsonBody = try JSONEncoder().encode(loginRequest)
            request.httpBody = jsonBody
          
            let (data, response) = try await session.data(for: request)
            
            if let httpResponse = response as? HTTPURLResponse {
                print("Status Code: \(httpResponse.statusCode)")
            
                if let jsonData = String(data: data, encoding: .utf8) {
                    print("Server Response: \(jsonData)")
                } else {
                    print("Failure Server Response")
                }
                
                switch httpResponse.statusCode {
                case 200:
                    let loginJSON = try decoder.decode(LoginResponse.self, from: data)
                    print("JSON Response: \(loginJSON)")
                    completion(.success(loginJSON))
                case 422:
                    completion(.failure(EndpointFailure.jsonFailure(message: "Invalid Dates")))
                default:
                    completion(.failure(EndpointFailure.jsonFailure(message: "Server Error: \(httpResponse.statusCode)")))
                }
            }
        } catch {
            completion(.failure(EndpointFailure.jsonFailure(message: "JSON Failure: \(error.localizedDescription)")))
        }
    }
    
    func getAuthUser(usr: String, cookie_acccess_token: String, completion: @escaping @Sendable (Result<LoginAuth, EndpointFailure>) -> Void) async {
        let decoder = JSONDecoder()
        var request = URLRequest(url: EndpointUrl.userAuth.url)
        request.httpMethod = "GET"
        request.timeoutInterval = 15
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("Bearer\(cookie_acccess_token)", forHTTPHeaderField: "Authorization")
        
        logger.info("Iniciando Solicitud GET: \(EndpointUrl.userAuth.url.absoluteString)")
        
        do {
            let (data, response) = try await session.data(for: request)
            
            if let httpResponse = response as? HTTPURLResponse {
                print("Server Response: \(httpResponse.statusCode)")
                
                if let jsonData = String(data: data, encoding: .utf8) {
                    print("Server Response: \(jsonData)")
                } else {
                    print("Server Failre Response")
                }
                
                switch httpResponse.statusCode {
                case 200:
                    let loginAuth = try decoder.decode(LoginAuth.self, from: data)
                    print("JSON Response: \(loginAuth)")
                    completion(.success(loginAuth))
                case 400:
                    completion(.failure(EndpointFailure.jsonFailure(message: "Server Failure Response")))
                default:
                    completion(.failure(EndpointFailure.jsonFailure(message: "Server Failre Response: \(httpResponse.statusCode)")))
                }
            }
        } catch {
            completion(.failure(EndpointFailure.jsonFailure(message: "JSON Response Failure: \(error.localizedDescription)")))
        }
    }
    
    // MARK: - Register
    
    func register(email: String, username: String, password: String, password_repeat: String, completion: @escaping @Sendable (Result<RegisterResponse, EndpointFailure>) -> Void) async {
        let decoder = JSONDecoder()
        var request = URLRequest(url: EndpointUrl.register.url)
        request.httpMethod = "POST"
        request.timeoutInterval = 15
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        request.setValue("application/json", forHTTPHeaderField: "Content_Type")
        
        logger.info("Iniciando Solicitud a POST: \(EndpointUrl.register.url.absoluteString)")
        
        let register = RegisterRequest(email: email, username: username, password: password, password_repeat: password_repeat)
        
        do {
            let jsonBody = try JSONEncoder().encode(register)
            request.httpBody = jsonBody
            
            let (data, response) = try await session.data(for: request)
            
            if let httpResponse = response as? HTTPURLResponse {
                print("Server Response: \(httpResponse.statusCode)")
                
                if let jsonData = String(data: data, encoding: .utf8) {
                    print("Server Response: \(jsonData)")
                } else {
                    print("Failure Server Response")
                }
                
                switch httpResponse.statusCode {
                case 200:
                    let registerJSON = try decoder.decode(RegisterResponse.self, from: data)
                    print("JSON Response: \(registerJSON)")
                    completion(.success(registerJSON))
                case 400:
                    completion(.failure(EndpointFailure.jsonFailure(message: "Invalid Dates")))
                default:
                    completion(.failure(EndpointFailure.jsonFailure(message: "Server Failure: \(httpResponse.statusCode)")))
                }
            }
        } catch {
            completion(.failure(EndpointFailure.jsonFailure(message: "Failure Response: \(error.localizedDescription)")))
        }
    }
    
    // MARK: - Change Password
    
    func changePass(reset_key: String, password: String, password_repeat: String, completion: @escaping @Sendable (Result<PasswordResponse, EndpointFailure>) -> Void) async {
        let decoder = JSONDecoder()
        var request = URLRequest(url: EndpointUrl.changePass.url)
        request.httpMethod = "PUT"
        request.timeoutInterval = 15
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        logger.info("Iniciando Solicitud a PUT: \(EndpointUrl.changePass.url.absoluteString)")
        
        let changeRequet = PasswordRequest(reset_key: reset_key, password: password, password_repeat: password_repeat)
        
        do {
            let jsonBody = try JSONEncoder().encode(changeRequet)
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
                    let changeJSON = try decoder.decode(PasswordResponse.self, from: data)
                    print("Respuesta del JSON: \(changeJSON)")
                    completion(.success(changeJSON))
                case 422:
                    completion(.failure(EndpointFailure.jsonFailure(message: "Invalid Dates")))
                default:
                    completion(.failure(EndpointFailure.jsonFailure(message: "Server Response Failure: \(httpResponse.statusCode)")))
                }
            }
        } catch {
            completion(.failure(EndpointFailure.jsonFailure(message: "Failure Response: \(error.localizedDescription)")))
        }
    }
    
    // MARK: - Payments
    
    func payments(unit: String, internal: Bool, out: Bool, amount: Int, memo: String, description_hash: String, unhashed_description: String, expiry: Int, extra: Extra, webhook: String, bolt11: String, lnurl_callback: String, fiat_provider: String, completion: @escaping @Sendable (Result<CreateInvoiceResponse, EndpointFailure>) -> Void) async {
        let decoder = JSONDecoder()
        var request = URLRequest(url: EndpointUrl.createPayments.url)
        request.httpMethod = "POST"
        request.timeoutInterval = 15
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        
        logger.info("Iniciando Solicitud a POST: \(EndpointUrl.createPayments.url.absoluteString)")
        
        let payments = CreateInvoiceRequest(unit: unit, internal: `internal`, out: out, amount: amount, memo: memo, description_hash: description_hash, unhashed_description: unhashed_description, expiry: expiry, extra: extra, webhook: webhook, bolt11: bolt11, lnurl_callback: lnurl_callback, fiat_provider: fiat_provider)
        
        do {
            let jsonBody = try JSONEncoder().encode(payments)
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
                    let paymentsResponse = try decoder.decode(CreateInvoiceResponse.self, from: data)
                    print("JSON Response: \(paymentsResponse)")
                    completion(.success(paymentsResponse))
                case 400:
                    completion(.failure(EndpointFailure.jsonFailure(message: "Server Failure Response")))
                default:
                    completion(.failure(EndpointFailure.jsonFailure(message: "Server Failure Response: \(httpResponse.statusCode)")))
                }
            }
        } catch {
            completion(.failure(EndpointFailure.jsonFailure(message: "JSON Response Failure: \(error.localizedDescription)")))
        }
    }
    
    // MARK: - Historial for day
    
    func getHistorial(completion: @escaping @Sendable (Result<[HistorialResponse], EndpointFailure>) -> Void) async {
        let decoder = JSONDecoder()
        var request = URLRequest(url: EndpointUrl.paymentsForDay.url)
        request.httpMethod = "GET"
        request.timeoutInterval = 15
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        
        logger.info("Iniciando Solicitud a GET: \(EndpointUrl.paymentsForDay.url.absoluteString)")
        
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
                    let historialJSON = try decoder.decode([HistorialResponse].self, from: data)
                    print("JSON Response: \(historialJSON)")
                    completion(.success(historialJSON))
                case 400:
                    completion(.failure(EndpointFailure.jsonFailure(message: "Server Failure Response")))
                default:
                    completion(.failure(EndpointFailure.jsonFailure(message: "Server Failure Response: \(httpResponse.statusCode)")))
                }
            }
        } catch {
            completion(.failure(EndpointFailure.jsonFailure(message: "JSON Failure Response: \(error.localizedDescription)")))
        }
    }
}
