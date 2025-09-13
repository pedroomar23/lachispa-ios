//
//  ContentNavigation.swift
//  La Chispa
//
//  Created by Pedro Omar  on 9/12/25.
//

import SwiftUI

struct ContentNavigation<Content: View>: View {
    let content: Content
    
    init(@ViewBuilder content: () -> Content) {
        self.content = content()
    }
    
    var body: some View {
        Group {
            if #available(iOS 16, *) {
                NavigationStack {
                    content
                }
            } else {
                NavigationView {
                    content
                }.navigationViewStyle(.stack)
            }
        }
    }
}
