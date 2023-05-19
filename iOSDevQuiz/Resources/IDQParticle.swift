//
//  IDQParticle.swift
//  iOSDevQuiz
//
//  Created by Daniel Karath on 5/19/23.
//

import Foundation
import SwiftUI

struct IDQParticle: Identifiable {
    var id: UUID = .init()
    var randomX: CGFloat = 0
    var randomY: CGFloat = 0
    var scale: CGFloat = 1
    var opacity: CGFloat = 1
    
    func reset() {
        var randomX = 0
        var randomY = 0
        var scale = 1
        var opacity = 1
    }
    
}
