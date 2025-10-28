//
//  Boltz.swift
//  La Chispa
//
//  Created by Pedro Omar  on 10/26/25.
//

import SwiftUI

struct Boltz : View {
    
    @StateObject var boltzRequest = BoltzRequest()
    @Environment(\.colorScheme) var colorScheme
    
    var body : some View {
        ContentNavigation {
            
        }
    }
}

#Preview {
    Boltz()
}
