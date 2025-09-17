//
//  Presentation.swift
//  La Chispa
//
//  Created by Pedro Omar  on 9/12/25.
//

import SwiftUI

struct Presentation : View {
    
    @State var selection = 0 
    @State private var isFinish : Bool = false
    
    var body: some View {
        if isFinish {
            Login()
        } else {
            ZStack (alignment: .bottom) {
                
            }.ignoresSafeArea(edges: .bottom)
        }
    }
}

#Preview {
    Presentation()
}
