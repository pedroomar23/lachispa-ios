//
//  Login.swift
//  La Chispa
//
//  Created by Pedro Omar  on 9/12/25.
//

import SwiftUI

struct Login : View {
    
    var body : some View {
        ContentNavigation {
            VStack {
               _preview(label: LabelImage(text: "LaunchImage"))
                Spacer()
            }
        }
    }
    
    @ViewBuilder
    private func _preview(label: LabelImage) -> some View {
        Image(label.text)
            .resizable()
            .frame(width: 60, height: 60)
            .cornerRadius(20)
            .padding(.top)
    }
}

#Preview {
    Login()
}
