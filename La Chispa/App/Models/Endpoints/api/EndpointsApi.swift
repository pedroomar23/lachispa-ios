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
        request.timeoutInterval = 10
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        logger.info("Iniciando Solicitud a POST: \(EndpointUrl.login.url.absoluteString)")
        
        let loginRequest = LoginRequest(
            username: username,
            password: password
        )
        print("JSON Response: \(loginRequest)")
        
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
                    let errorDetails = String(data: data, encoding: .utf8)
                    print("Error: \(String(describing: errorDetails))")
                default:
                    completion(.failure(EndpointFailure.jsonFailure(message: "Server Error: \(httpResponse.statusCode)")))
                }
            }
        } catch {
            completion(.failure(EndpointFailure.jsonFailure(message: "JSON Failure: \(error.localizedDescription)")))
        }
    }
    
    // MARK: - GetUserAuth 
    
    func getAuthUser(usr: String, cookie_acccess_token: String, completion: @escaping @Sendable (Result<LoginAuth, EndpointFailure>) -> Void) async {
        let decoder = JSONDecoder()
        var request = URLRequest(url: EndpointUrl.userAuth.url)
        request.httpMethod = "GET"
        request.timeoutInterval = 10
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("Bearer\(cookie_acccess_token)", forHTTPHeaderField: "Authorization")
        request.setValue("a8efab8aa61846fda7084dfb417af0a9", forHTTPHeaderField: "X-Api-Key")
        
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
                    let errorDetails = String(data: data, encoding: .utf8)
                    print("Error: \(String(describing: errorDetails))")
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
        request.timeoutInterval = 10
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("a8efab8aa61846fda7084dfb417af0a9", forHTTPHeaderField: "X-Api-Key")
        
        logger.info("Iniciando Solicitud a POST: \(EndpointUrl.register.url.absoluteString)")
        
        let register = RegisterRequest(
            email: email,
            username: username,
            password: password,
            password_repeat: password_repeat
        )
        print("JSON Response: \(register)")
        
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
                    let errorDetails = String(data: data, encoding: .utf8)
                    print("Error: \(String(describing: errorDetails))")
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
        request.timeoutInterval = 10
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("a8efab8aa61846fda7084dfb417af0a9", forHTTPHeaderField: "X-Api-Key")
        
        logger.info("Iniciando Solicitud a PUT: \(EndpointUrl.changePass.url.absoluteString)")
        
        let changeRequest: [String: Any] = [
            "reset_key": reset_key,
            "password": password,
            "password_repeat": password_repeat
        ]
        print("JSON Response: \(changeRequest)")
        
        do {
            let jsonBody = try JSONSerialization.data(withJSONObject: changeRequest)
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
                    let errorDetails = String(data: data, encoding: .utf8)
                    print("Error: \(String(describing: errorDetails))")
                default:
                    completion(.failure(EndpointFailure.jsonFailure(message: "Server Response Failure: \(httpResponse.statusCode)")))
                }
            }
        } catch {
            completion(.failure(EndpointFailure.jsonFailure(message: "Failure Response: \(error.localizedDescription)")))
        }
    }
    
    // MARK: - Payments
    
    func payLNURL(description_hash: String, callback: String, amount: Int, comment: String, description: String, unit: String, completion: @escaping @Sendable (Result<PayLNURLResponse, EndpointFailure>) -> Void) async {
        let decoder = JSONDecoder()
        var request = URLRequest(url: EndpointUrl.payLNURL.url)
        request.httpMethod = "POST"
        request.timeoutInterval = 10
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        request.setValue("c38ef8a288024b82a5951bcc06143999", forHTTPHeaderField: "X-Api-Key")
        
        logger.info("Initializing Solicite: \(EndpointUrl.payLNURL.url.absoluteString)")
        
        let payLNURL = PayLNURLRequest(
            description_hash: description_hash,
            callback: callback,
            amount: amount,
            comment: comment,
            description: description,
            unit: "sat"
        )
        print("JSON Response: \(payLNURL)")
        
        do {
            let jsonBody = try JSONEncoder().encode(payLNURL)
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
                    let payLNURLResponse = try decoder.decode(PayLNURLResponse.self, from: data)
                    print("JSON Response: \(payLNURLResponse)")
                    completion(.success(payLNURLResponse))
                case 401:
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
    
    func createPayments(bolt11: String, out: Bool, amount: Int, unit: String, completion: @escaping @Sendable (Result<CreateInvoiceResponse, EndpointFailure>) -> Void) async {
        let decoder = JSONDecoder()
        var request = URLRequest(url: EndpointUrl.createPayments.url)
        request.httpMethod = "POST"
        request.timeoutInterval = 10
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        request.setValue("c38ef8a288024b82a5951bcc06143999", forHTTPHeaderField: "X-Api-Key")
        
        logger.info("Iniciando Solicitud a POST: \(EndpointUrl.createPayments.url.absoluteString)")
        
        let payments: [String: Any] = [
            "bolt11": bolt11,
            "out": out,
            "amount": amount,
            "unit": unit
        ]
        print("JSON Response: \(payments)")
        
        do {
            let jsonBody = try JSONSerialization.data(withJSONObject: payments)
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
                    let paymentsResponse = try decoder.decode(CreateInvoiceResponse.self, from: data)
                    print("JSON Response: \(paymentsResponse)")
                    completion(.success(paymentsResponse))
                case 400:
                    let errorDetails = String(data: data, encoding: .utf8)
                    print("Error: \(String(describing: errorDetails))")
                default:
                    completion(.failure(EndpointFailure.jsonFailure(message: "Server Failure Response: \(httpResponse.statusCode)")))
                }
            }
        } catch {
            completion(.failure(EndpointFailure.jsonFailure(message: "JSON Response Failure: \(error.localizedDescription)")))
        }
    }
    
    func createInvoice(out: Bool, amount: Int, unit: String, memo: String?, completion: @escaping @Sendable (Result<CreateInvoiceResponse, EndpointFailure>) -> Void) async {
        let decoder = JSONDecoder()
        var request = URLRequest(url: EndpointUrl.createPayments.url)
        request.httpMethod = "POST"
        request.timeoutInterval = 10
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        request.setValue("c38ef8a288024b82a5951bcc06143999", forHTTPHeaderField: "X-Api-Key")
        
        logger.info("Iniciando Solicitud a POST: \(EndpointUrl.createPayments.url.absoluteString)")
        
        let createInvoice: [String: Any] = [
            "out": out,
            "amount": amount,
            "unit": unit,
            "memo": memo ?? ""
        ]
        print("JSON Response: \(createInvoice)")
        
        do {
            let jsonBody = try JSONSerialization.data(withJSONObject: createInvoice)
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
                    let createInvoiceJSON = try decoder.decode(CreateInvoiceResponse.self, from: data)
                    completion(.success(createInvoiceJSON))
                    print("JSON Response: \(createInvoiceJSON)")
                case 400:
                    let errorDetails = String(data: data, encoding: .utf8)
                    print("Error: \(String(describing: errorDetails))")
                default:
                    completion(.failure(EndpointFailure.jsonFailure(message: "Server Response Failure: \(httpResponse.statusCode)")))
                }
            }
        } catch {
            completion(.failure(EndpointFailure.jsonFailure(message: "JSON Failure: \(error.localizedDescription)")))
        }
    }
    
    // MARK: - Get Payments
    
    func getPayments(completion: @escaping @Sendable (Result<[GetPayments], EndpointFailure>) -> Void) async {
        let decoder = JSONDecoder()
        var request = URLRequest(url: EndpointUrl.getPayments.url)
        request.httpMethod = "GET"
        request.timeoutInterval = 10
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        request.setValue("c38ef8a288024b82a5951bcc06143999", forHTTPHeaderField: "X-Api-Key")
        
        logger.info("Iniciando Solicitud a GET: \(EndpointUrl.getPayments.url.absoluteString)")
        
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
                    let getPaymentsJSON = try decoder.decode([GetPayments].self, from: data)
                    print("JSON Response: \(getPaymentsJSON)")
                    completion(.success(getPaymentsJSON))
                case 400:
                    let errorDetails = String(data: data, encoding: .utf8)
                    print("Error Details: \(String(describing: errorDetails))")
                default:
                    completion(.failure(EndpointFailure.jsonFailure(message: "Server Reponse: \(httpResponse.statusCode)")))
                }
            }
        } catch {
            completion(.failure(EndpointFailure.jsonFailure(message: "Failure JSON Response: \(error.localizedDescription)")))
        }
    }
    
    func getLNURl(username: String, completion: @escaping @Sendable (Result<GetLNURLUsername, EndpointFailure>) -> Void) async {
        let decoder = JSONDecoder()
        let requestURL = EndpointLNUrl.getLNURLP(username: username).urlLNP
        var request = URLRequest(url: requestURL)
        request.httpMethod = "GET"
        request.timeoutInterval = 10
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        
        logger.info("Iniciando Solicitud a Get")
        
        print("Username Encontrado: \(username)")
        
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
                    let getLNURLJSON = try decoder.decode(GetLNURLUsername.self, from: data)
                    completion(.success(getLNURLJSON))
                    print("JSON Response: \(getLNURLJSON)")
                case 400:
                    let errorDetails = String(data: data, encoding: .utf8)
                    print("JSON Failure Response: \(String(describing: errorDetails))")
                default:
                    completion(.failure(EndpointFailure.jsonFailure(message: "Server Failure Response: \(httpResponse.statusCode)")))
                }
            }
        } catch {
            completion(.failure(EndpointFailure.jsonFailure(message: "Failure JSON Response: \(error.localizedDescription)")))
        }
    }
    
    // MARK: - Historial for day
    
    func getHistorial(completion: @escaping @Sendable (Result<[HistorialResponse], EndpointFailure>) -> Void) async {
        let decoder = JSONDecoder()
        var request = URLRequest(url: EndpointUrl.paymentsForDay.url)
        request.httpMethod = "GET"
        request.timeoutInterval = 10
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        request.setValue("c38ef8a288024b82a5951bcc06143999", forHTTPHeaderField: "X-Api-Key")
        
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
                    let errorDetails = String(data: data, encoding: .utf8)
                    print("Server Response: \(String(describing: errorDetails))")
                default:
                    completion(.failure(EndpointFailure.jsonFailure(message: "Server Failure Response: \(httpResponse.statusCode)")))
                }
            }
        } catch {
            completion(.failure(EndpointFailure.jsonFailure(message: "JSON Failure Response: \(error.localizedDescription)")))
        }
    }
}
