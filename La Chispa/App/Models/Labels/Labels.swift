//
//  Labels.swift
//  La Chispa
//
//  Created by Pedro Omar  on 9/12/25.
//

import Foundation
import SwiftUI

struct LabelImage : Identifiable {
    let id = UUID()
    let text: String 
}

struct LabelPass: Identifiable {
    let id = UUID()
    let icon: String
    let icon1: String 
}

struct LabelText: Identifiable {
    let id = UUID()
    let text: LocalizedStringKey
}

struct LabelTexts: Identifiable {
    let id = UUID()
    let text: LocalizedStringKey
    let text1: LocalizedStringKey
}

struct LabelIcon: Identifiable {
    let id = UUID()
    let text: LocalizedStringKey
    let icon: String 
}
