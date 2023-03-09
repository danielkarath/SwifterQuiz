//
//  IDQExtensions.swift
//  iOSDevQuiz
//
//  Created by Daniel Karath on 3/2/23.
//

import UIKit


extension UIView {
    
    enum GradientDirection {
        case horizontal
        case vertical
        case bottomLeftToTopRight
        case topLeftToBottomRight
    }
    
    func addSubviews(_ views: UIView...) {
        views.forEach ({
            addSubview($0)
        })
    }
    
    
    /// Add custom CAGradientLayer to the UIView
    /// - Parameters:
    ///   - colors: Add any number of colors and the gradient will show them from left buttom to the right top of your superview
    ///   - gradientDirection: Set a direction for the gradient colors
    func gradient(_ colors: CGColor..., direction gradientDirection: GradientDirection) {
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = colors
        
        switch gradientDirection {
        case .horizontal:
            gradientLayer.startPoint = CGPoint(x: 0.0, y: 0.5)
            gradientLayer.endPoint = CGPoint(x: 1.0, y: 0.5)
        case .vertical:
            gradientLayer.startPoint = CGPoint(x: 0.5, y: 0.0)
            gradientLayer.endPoint = CGPoint(x: 0.5, y: 1.0)
        case .bottomLeftToTopRight:
            gradientLayer.startPoint = CGPoint(x: 1.0, y: 0.0)
            gradientLayer.endPoint = CGPoint(x: 0.0, y: 1.0)
        case .topLeftToBottomRight:
            gradientLayer.startPoint = CGPoint(x: 0.0, y: 1.0)
            gradientLayer.endPoint = CGPoint(x: 1.0, y: 0.0)
        }
        
        gradientLayer.frame.size = CGSize(width: self.layer.frame.size.width, height: self.layer.frame.size.height)
        gradientLayer.cornerRadius = self.layer.cornerRadius
        gradientLayer.frame = self.bounds
        gradientLayer.layoutIfNeeded()
        self.layer.insertSublayer(gradientLayer, at: 0)
    }
}


extension UIButton {
    
    /// Add attributedString to a UIButton
    /// - Parameters:
    ///   - title: The title of the button
    ///   - fontSize: The fontsize of the button
    ///   - attributedTextColor: The font color in normal state
    ///   - attributedTextHighlightedColor: The font color in highlighted state
    ///   - isBold: If true, the font is bold in both states. By default it's false
    func addAttributedTitle(title: String, fontSize: CGFloat, fontColor attributedTextColor: UIColor, highlightColor attributedTextHighlightedColor: UIColor, isBold: Bool = false) {
        let selectedColor: UIColor = attributedTextHighlightedColor
        let range = (title as NSString).range(of: title)
        let attributedText = NSMutableAttributedString(string: title, attributes: [NSMutableAttributedString.Key.font: IDQConstants.setFont(fontSize: fontSize, isBold: isBold)])
        attributedText.addAttribute(NSAttributedString.Key.foregroundColor, value: attributedTextColor, range: range)
        let attributedTextHighlighted = NSMutableAttributedString(string: title, attributes: [NSMutableAttributedString.Key.font: IDQConstants.setFont(fontSize: fontSize, isBold: isBold)])
        attributedTextHighlighted.addAttribute(NSAttributedString.Key.foregroundColor, value: selectedColor, range: range)
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.alignment = .center
        attributedText.addAttribute(.paragraphStyle, value: paragraphStyle, range: NSRange(location: 0, length: attributedText.length))
        attributedTextHighlighted.addAttribute(.paragraphStyle, value: paragraphStyle, range: NSRange(location: 0, length: attributedTextHighlighted.length))
        self.setAttributedTitle(attributedText, for: .normal)
        self.setAttributedTitle(attributedTextHighlighted, for: .highlighted)
        self.contentHorizontalAlignment = .center
        self.contentVerticalAlignment = .center
    }
}

extension UIBlurEffect.Style {
    
    static var automatic: UIBlurEffect.Style {
        if #available(iOS 13.0, *) {
            let currentStyle = UITraitCollection.current.userInterfaceStyle
            if currentStyle == .dark {
                return .dark
            } else {
                return .light
            }
        } else {
            return.extraLight
        }
    }
    
}

extension String {
    func addWhitespaceBeforeCapitalLetters() -> String {
        guard !self.isEmpty else { return self }
        
        var output = ""
        output.append(self.first!) // Add the first character to the output string
        
        for (previous, current) in zip(self, self.dropFirst()) {
            if CharacterSet.uppercaseLetters.contains(current.unicodeScalars.first!) && !CharacterSet.uppercaseLetters.contains(previous.unicodeScalars.first!) {
                // If the current character is a capital letter and the previous character is not, insert a whitespace
                output.append(" ")
            }
            output.append(current) // Add the current character to the output string
        }
        
        return output
    }
}


extension Bundle {
    var appName: String? {
        return object(forInfoDictionaryKey: "CFBundleName") as? String
    }
    
    var displayName: String? {
        return object(forInfoDictionaryKey: "CFBundleDisplayName") as? String
    }
    
    var appVersion: String? {
        return object(forInfoDictionaryKey: "CFBundleShortVersionString") as? String
    }
    
    var buildNumber: String? {
        return object(forInfoDictionaryKey: "CFBundleVersion") as? String
    }
}