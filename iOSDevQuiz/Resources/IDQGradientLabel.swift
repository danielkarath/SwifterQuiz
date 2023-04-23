//
//  IDQGradientLabel.swift
//  iOSDevQuiz
//
//  Created by Daniel Karath on 4/22/23.
//

import Foundation
import UIKit

class GradientLabel: UILabel {
    
    var gradientColors: [CGColor] = [
        IDQConstants.highlightedLightOrange.cgColor,
        IDQConstants.highlightedDarkOrange.cgColor
    ]
    
    override func layoutSubviews() {
        super.layoutSubviews()
        applyGradient()
    }
    
    private func applyGradient() {
        // Remove any existing layers
        layer.sublayers?.forEach { layer in
            layer.removeFromSuperlayer()
        }
        
        // Create the gradient layer
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = bounds
        gradientLayer.colors = gradientColors
        gradientLayer.startPoint = CGPoint(x: 1.0, y: 0.0)
        gradientLayer.endPoint = CGPoint(x: 0.0, y: 1.0)
        
        // Create the text layer
        let textLayer = CATextLayer()
        textLayer.string = text
        textLayer.font = font
        textLayer.fontSize = font.pointSize
        textLayer.foregroundColor = UIColor.white.cgColor
        textLayer.contentsScale = UIScreen.main.scale
        textLayer.alignmentMode = .center
        textLayer.frame = bounds
        
        // Apply the mask and add the gradient layer
        gradientLayer.mask = textLayer
        layer.addSublayer(gradientLayer)
    }
}
