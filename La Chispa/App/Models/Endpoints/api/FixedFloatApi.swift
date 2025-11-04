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
}
