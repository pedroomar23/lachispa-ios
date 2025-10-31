//
//  Presentation.swift
//  La Chispa
//
//  Created by Pedro Omar  on 9/12/25.
//

import SwiftUI

struct Presentation : View {
    
    @State var selectedTab = 0
    @State private var isFinish : Bool = false
    @Environment(\.colorScheme) var colorScheme 
    
    let totalPage = 3
    
    var body: some View {
        if isFinish {
            Login()
        } else {
            ZStack (alignment: .bottom) {
                TabView (selection: $selectedTab) {
                    View1()
                        .tag(0)
                    View2()
                        .tag(2)
                    View3(onFinish: {
                        withAnimation {
                            isFinish = true
                        }
                    })
                        .tag(3)
                }
                .tabViewStyle(PageTabViewStyle(indexDisplayMode: .always))
                .indexViewStyle(PageIndexViewStyle(backgroundDisplayMode: .always))
                
                if selectedTab < totalPage {
                    Button(action: goNext) {
                        HStack (spacing: 5) {
                            Text("presentation-button")
                                .font(.headline)
                                .foregroundColor(.white)
                            Image(systemName: "arrow.forward")
                                .font(.headline)
                                .foregroundColor(.white)
                        }
                        .padding(.vertical)
                        .frame(width: UIScreen.main.bounds.width - 270)
                        .background(Color.blue)
                        .clipShape(Capsule())
                    }
                    .padding(.horizontal)
                    .padding(.bottom, 50)
                    .transition(.opacity)
                }
            }.ignoresSafeArea(edges: .bottom)
        }
    }
    
    private func goNext() {
        withAnimation {
            selectedTab += 1
        }
    }
}

#Preview {
    Presentation()
}
