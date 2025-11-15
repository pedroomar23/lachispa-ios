//
//  Environments.swift
//  La Chispa
//
//  Created by Pedro Omar  on 9/16/25.
//

import Foundation
import SwiftUI


fileprivate struct ScreenSize : EnvironmentKey {
    static let defaultValue : CGSize = .zero
}

extension EnvironmentValues {
    var screenSize : CGSize {
        get { self[ScreenSize.self] }
        set { self[ScreenSize.self] = newValue }
    }
}


