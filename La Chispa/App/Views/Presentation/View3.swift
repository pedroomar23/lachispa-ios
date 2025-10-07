//
//  View3.swift
//  La Chispa
//
//  Created by Pedro Omar  on 9/14/25.
//

import SwiftUI

struct View3 : View {
    
    @StateObject var security = Security()
    @Environment(\.colorScheme) var colorScheme
    var onFinish : () -> Void = {}
    
    var body: some View {
        VStack {
            _view(label: LabelImages(icon: "bitcoinsign", text: "Send and Receive Satochis", text1: "Send and Receive satochis with a better security, and pay with lightning network diferents plataforms"))
            
            Spacer()
        }
        .padding(.top)
        .safeAreaInset(edge: .bottom) {
            Button {
                security.mostrar = false
                onFinish()
            } label: {
                _buttonLabel(label: LabelText(text: "Comenzar"))
            }
            .buttonStyle(.plain)
            .padding(.bottom, 20)
            .padding(.horizontal)
        }
    }
    
    @ViewBuilder
    private func _view(label: LabelImages) -> some View {
        VStack {
            Text(label.text)
                .fontWeight(.semibold)
                .font(.title)
            Image(systemName: label.icon)
                .foregroundStyle(colorScheme == .dark ? .orange : .orange)
                .font(.system(size: 70, weight: .medium))
                .padding()
            Text(label.text1)
                .fontWeight(.semibold)
        }.padding(.horizontal)
    }
    
    @ViewBuilder
    private func _buttonLabel(label: LabelText) -> some View {
        Text(label.text)
            .font(.headline)
            .foregroundColor(.white)
            .padding(.vertical)
            .frame(width: UIScreen.main.bounds.width - 270)
            .background(Color.blue)
            .clipShape(Capsule())
    }
}

