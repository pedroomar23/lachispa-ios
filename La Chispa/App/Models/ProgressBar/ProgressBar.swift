//
//  ProgressBar.swift
//  La Chispa
//
//  Created by Pedro Omar  on 9/12/25.
//

import SwiftUI

struct ProgressBar: View {
    
    @State private var shouldAnimate = false
    @State var color: Color
    
    var body: some View {
        HStack {
            Circle()
                .fill(color)
                .frame(width: 20, height: 20)
                .scaleEffect(shouldAnimate ? 1.0 : 0.5)
                .animation(.easeInOut(duration: 0.5).repeatForever(), value: UUID())
            Circle()
                .fill(color)
                .frame(width: 20, height: 20)
                .scaleEffect(shouldAnimate ? 1.0 : 0.5)
                .animation(.easeInOut(duration: 0.5).repeatForever().delay(0.3), value: UUID())
            Circle()
                .fill(color)
                .frame(width: 20, height: 20)
                .scaleEffect(shouldAnimate ? 1.0 : 0.5)
                .animation(.easeInOut(duration: 0.5).repeatForever().delay(0.6), value: UUID())
        }
        .onAppear {
            self.shouldAnimate = true
        }
    }
}

// MARK: - Circle Progress Bar Descargas

struct CircleProgressBar: View {
    
    @State var progress: Float
    
    var body: some View {
        ZStack {
            // Circulo de Fondo
            Circle()
                .stroke(lineWidth: 8)
                .opacity(0.3)
                .foregroundStyle(Color(.gray))
            // Circulo en Progreso
            Circle()
                .trim(from: 0.0, to: CGFloat(progress))
                .stroke(style: StrokeStyle(lineWidth: 8, lineCap: .round))
                .foregroundStyle(Color(.blue))
                .rotationEffect(Angle(degrees: -90))
                .animation(.linear, value: progress)
        }
        .frame(width: 50, height: 50)
    }
}
