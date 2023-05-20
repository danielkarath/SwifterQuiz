//
//  IDQShimmeringViewMOdifier.swift
//  iOSDevQuiz
//
//  Created by Daniel Karath on 5/20/23.
//

import SwiftUI

struct ShimmeringViewModifier: ViewModifier {
    @State var isActive = false

    func body(content: Content) -> some View {
        content
            .overlay(
                LinearGradient(gradient: Gradient(colors: [Color.white.opacity(0.4), Color.white, Color.white.opacity(0.4)]), startPoint: .leading, endPoint: .trailing)
                    .mask(content)
                    .offset(x: isActive ? UIScreen.main.bounds.width : -UIScreen.main.bounds.width, y: 0)
            )
            .onAppear {
                withAnimation(Animation.linear(duration: 2.0).delay(1.0).repeatForever(autoreverses: false)) {
                    isActive = true
                }
            }
    }
}
