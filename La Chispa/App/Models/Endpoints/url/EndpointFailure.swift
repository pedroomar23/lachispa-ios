//
//  EndpointFailure.swift
//  La Chispa
//
//  Created by Pedro Omar  on 9/12/25.
//

import Foundation

enum EndpointFailure: Error {
    case jsonFailure(message: String)
}
