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
            _view(label: LabelPre(text: "presentation-view2-text1", text1: "presentation-view2-text2", icon: "cloud"))
           Spacer()
        }
    }
    
    @ViewBuilder
    private func _view(label: LabelPre) -> some View {
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
                .padding()
        }
    }
}

#Preview {
    View2()
}
