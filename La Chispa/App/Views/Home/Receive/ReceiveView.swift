//
//  ReceiveView.swift
//  La Chispa
//
//  Created by Pedro Omar  on 10/28/25.
//

import SwiftUI

struct ReceiveView : View {
    
    @StateObject var loginRequest = LoginRequests()
    @Environment(\.colorScheme) var colorScheme 
    
    var body : some View {
        ContentNavigation {
            
        }
    }
}

#Preview {
    ReceiveView()
}
