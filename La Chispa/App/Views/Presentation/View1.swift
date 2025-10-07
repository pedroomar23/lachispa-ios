//
//  View1.swift
//  La Chispa
//
//  Created by Pedro Omar  on 9/14/25.
//

import SwiftUI

struct View1 : View {
    
    var body : some View {
        VStack {
            _view(label: LabelImages(icon: "LaunchImage", text: "LaChispa does is for you", text1: "v1.0"))
            Spacer()
        }.padding(.top)
    }
    
    @ViewBuilder
    private func _view(label: LabelImages) -> some View {
        VStack {
            Text(label.text)
                .fontWeight(.semibold)
                .font(.title)
                .padding()
            Image(label.icon)
                .resizable()
                .frame(width: 90, height: 90)
                .cornerRadius(20)
            Text(label.text1)
                .fontWeight(.bold)
                .font(.headline)
        }
    }
}

#Preview {
    View1()
}
