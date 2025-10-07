//
//  View2.swift
//  La Chispa
//
//  Created by Pedro Omar  on 9/14/25.
//

import SwiftUI

struct View2 : View {
    
    @Environment(\.colorScheme) var colorScheme
    
    var body: some View {
        VStack {
            _view(label: LabelImages(icon: "cloud", text: "Favorite Server", text1: "Init with your favorite server for a better experiencie with Bitcoin"))
           Spacer()
        }.padding(.top)
    }
    
    @ViewBuilder
    private func _view(label: LabelImages) -> some View {
        VStack {
            Text(label.text)
                .fontWeight(.semibold)
                .font(.title)
            Image(systemName: label.icon)
                .foregroundStyle(colorScheme == .dark ? .white : .blue)
                .font(.system(size: 70, weight: .medium))
                .padding()
            Text(label.text1)
                .fontWeight(.semibold)
        }
    }
}

#Preview {
    View2()
}
