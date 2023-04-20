//
//  IDQHighlightEffectViewModifier.swift
//  iOSDevQuiz
//
//  Created by Daniel Karath on 4/20/23.
//

import Foundation
import SwiftUI

struct HighlightEffectModifier: ViewModifier {
    @State private var isHighlighted = false
    let highlightColor: Color

    func body(content: Content) -> some View {
        content
            .overlay(
                Rectangle()
                    .fill(isHighlighted ? highlightColor : Color.clear)
                    .opacity(isHighlighted ? 1 : 0)
                    .animation(.easeInOut(duration: 0.3), value: isHighlighted)
            )
            .simultaneousGesture(TapGesture().onEnded {
                isHighlighted = true
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                    isHighlighted = false
                }
            })
//            .onTapGesture {
//                isHighlighted = true
//                DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
//                    isHighlighted = false
//                }
//            }
            //.simultaneousGesture(TapGesture().onEnded { })
    }
}


extension View {
    func highlightEffect(color: Color, onTap: (() -> Void)? = nil) -> some View {
        self.modifier(HighlightEffectModifier(highlightColor: color))
    }
}
