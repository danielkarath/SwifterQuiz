//
//  IDQGradientImageView.swift
//  iOSDevQuiz
//
//  Created by Daniel Karath on 4/23/23.
//

import UIKit

class GradientImageView: UIView {
    
    var gradientColors: [CGColor] = [
        IDQConstants.highlightedLightOrange.cgColor,
        IDQConstants.highlightedDarkOrange.cgColor
    ]
    
    var image: UIImage? {
        didSet {
            applyGradient()
        }
    }
    
    init(image: UIImage) {
        self.image = image
        super.init(frame: .zero)
        backgroundColor = .clear
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        applyGradient()
    }
    
    private func applyGradient() {
        guard let image = image else { return }
        
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
        
        // Create the image layer
        let imageLayer = CALayer()
        imageLayer.contents = image.cgImage
        imageLayer.frame = bounds
        imageLayer.contentsGravity = .resizeAspect
        
        // Apply the mask and add the gradient layer
        gradientLayer.mask = imageLayer
        layer.addSublayer(gradientLayer)
    }
}
