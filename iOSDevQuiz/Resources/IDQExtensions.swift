//
//  IDQExtensions.swift
//  iOSDevQuiz
//
//  Created by Daniel Karath on 3/2/23.
//

import UIKit
import MessageUI

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
    
    func didHighlight(with color: UIColor) {
        let overlayView = UIView(frame: self.bounds)
        overlayView.backgroundColor = color
        overlayView.alpha = 0
        
        self.addSubview(overlayView)
        
        UIView.animate(withDuration: 0.1, animations: {
            overlayView.alpha = 1
        }, completion: { _ in
            UIView.animate(withDuration: 0.2, delay: 0.1, options: [], animations: {
                overlayView.alpha = 0
            }, completion: { _ in
                overlayView.removeFromSuperview()
            })
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
        self.layer.mask = gradientLayer
        gradientLayer.layoutIfNeeded()
        self.layer.insertSublayer(gradientLayer, at: 0)
    }
    
    func pulseAnimation(targetSize: CGFloat, duration: TimeInterval = 1.0, resetAfter: Bool = true) {
        let originalWidth: CGFloat = self.frame.size.width
        let originalHeight: CGFloat = self.frame.size.width
        let originalAlpha: CGFloat = self.alpha
        
        let targetCoordinate: CGFloat = self.frame.origin.x - targetSize/2
        
        if self.isHidden {
            self.isHidden = false
        }
        UIView.animate(withDuration: duration, animations: {
            self.alpha = 0.0
            self.layer.frame.size = CGSize(width: targetSize, height: targetSize)
            self.frame = CGRect(x: targetCoordinate, y: targetCoordinate, width: targetSize, height: targetSize)
            self.layer.cornerRadius = targetSize/2
        }, completion: { finished in
            if resetAfter {
                self.isHidden = true
                self.alpha = originalAlpha
                self.layer.frame.size = CGSize(width: originalWidth, height: originalHeight)
                self.frame = CGRect(x: targetCoordinate + targetSize/2, y: targetCoordinate + targetSize/2, width: originalWidth, height: originalHeight)
                self.layer.cornerRadius = 0
            }
        })
    }
    
    func getViewController() -> UIViewController? {
        var nextResponder: UIResponder? = self
        while let responder = nextResponder {
            if let viewController = responder as? UIViewController {
                return viewController
            }
            nextResponder = responder.next
        }
        return nil
    }
    
    
}

extension UIViewController: MFMailComposeViewControllerDelegate {
    
    public func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        
        switch result {
        case .cancelled:
            print("Cancelled")
        case .failed:
            print("Failed to send email")
        case .saved:
            print("Message draft saved")
        case .sent:
            print("Message sent")
            //special toast here!!
        default:
            print("Unknown error occured when trying to open mail composer")
        }
        controller.dismiss(animated: true)
    }
}

extension UICollectionView {
    func slide(_ cell: UICollectionViewCell, at indexPath: IndexPath, delay: Double = 0.6) {
        cell.transform = CGAffineTransform(translationX: -self.bounds.width, y: 0)
        
        // Calculate delay for this cell based on its index path
        let adjustedDelay = delay * Double(indexPath.item)
        
        // Apply animation to slide cell into view with delay
        UIView.animate(withDuration: 0.60, delay: adjustedDelay, usingSpringWithDamping: 0.70, initialSpringVelocity: 0.40, options: [], animations: {
            cell.transform = CGAffineTransform.identity
        }, completion: nil)
    }
}

extension UIImage {
    func withGradient(colors: [CGColor]) -> UIImage? {
        UIGraphicsBeginImageContextWithOptions(size, false, scale)
        guard let context = UIGraphicsGetCurrentContext() else { return nil }
        
        draw(in: CGRect(origin: .zero, size: size), blendMode: .normal, alpha: 1)
        context.clip(to: CGRect(origin: .zero, size: size), mask: cgImage!)
        
        let gradient = CGGradient(colorsSpace: CGColorSpaceCreateDeviceRGB(), colors: colors as CFArray, locations: nil)!
        let startPoint = CGPoint(x: 0, y: 0)
        let endPoint = CGPoint(x: size.width, y: size.height)
        
        context.drawLinearGradient(gradient, start: startPoint, end: endPoint, options: [])
        
        let imageWithGradient = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return imageWithGradient
    }
}

extension UIStackView {
    
    func addArrangedSubviews(_ views: UIView...) {
        views.forEach ({
            addArrangedSubview($0)
        })
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

extension UILabel {
    
    func formatGradientLabel(gradientView: UIView) {
        //gradientView.frame = self.frame //CGRect(x: self.layer.frame.minX, y: self.layer.frame.minY, width: self.layer.frame.size.width, height: self.layer.frame.size.height)
        let attributedString = NSMutableAttributedString(string: self.text!)
        attributedString.addAttribute(NSAttributedString.Key.kern, value: CGFloat(6.0), range: NSRange(location: 0, length: attributedString.length))
        self.attributedText = attributedString
        
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = gradientView.bounds
        
        gradientLayer.colors = [UIColor.black.withAlphaComponent(1.0).cgColor,
                                UIColor.black.withAlphaComponent(0.0).cgColor]
        
        if UIScreen.main.traitCollection.userInterfaceStyle == .light {
            gradientLayer.colors = [UIColor.init(displayP3Red: 255.0/255.0, green: 154.0/255.0, blue: 60.0/255.0, alpha: 1.0).cgColor, UIColor.init(displayP3Red: 226.0/255.0, green: 62.0/255.0, blue: 87.0/255.0, alpha: 1.0).cgColor]
        } else {
            gradientLayer.colors = [UIColor.init(displayP3Red: 161.0/255.0, green: 205.0/255.0, blue: 245.0/255.0, alpha: 1.0).cgColor, UIColor.init(displayP3Red: 95.0/255.0, green: 48.0/255.0, blue: 245.0/255.0, alpha: 1.0).cgColor]
        }
        
        gradientLayer.startPoint = CGPoint(x: 0.0, y: 0.5)
        gradientLayer.endPoint = CGPoint(x: 1.0, y: 0.5)
        
        gradientView.layer.addSublayer(gradientLayer)
        
        gradientView.mask = self
    }
    
    func configureFor(_ keywordColors: [String]) {
        guard let labelText = text else {
            return
        }
        let color = IDQConstants.highlightedDarkOrange
        let attributedString = NSMutableAttributedString(string: labelText)
        
        let fontSize: CGFloat = self.font.pointSize
        
        let words = labelText.split(separator: " ")
        for word in words {
            if keywordColors.contains(String(word)) {
                let range = (labelText as NSString).range(of: String(word))
                attributedString.addAttribute(.foregroundColor, value: color, range: range)
                attributedString.addAttribute(.font, value: IDQConstants.setFont(fontSize: fontSize, isBold: true), range: range)
            }
        }
        attributedText = attributedString
        
        //        for (word) in keywordColors {
        //            let range = (labelText as NSString).range(of: word)
        //            attributedString.addAttribute(.foregroundColor, value: color, range: range)
        //            attributedString.addAttribute(.font, value: IDQConstants.setFont(fontSize: fontSize, isBold: true), range: range)
        //        }
        //
        //        attributedText = attributedString
    }
    
}

extension UITextView {
    
    func configureFor(_ keywordColors: [String], fontSize: CGFloat, keywordcolor: UIColor) {
        guard let labelText = text else {
            return
        }
        let attributedString = NSMutableAttributedString(string: labelText)
        
        let pattern = "(?:\\b\\w+\\b|[():;])"
        let regex: NSRegularExpression
        do {
            regex = try NSRegularExpression(pattern: pattern, options: [])
        } catch {
            print("Error creating regular expression: \(error.localizedDescription)")
            return
        }
        
        let matches = regex.matches(in: labelText, options: [], range: NSRange(location: 0, length: labelText.count))
        for match in matches {
            let word = (labelText as NSString).substring(with: match.range)
            if keywordColors.contains(String(word)) {
                attributedString.addAttribute(.foregroundColor, value: keywordcolor, range: match.range)
                attributedString.addAttribute(.font, value: IDQConstants.setFont(fontSize: fontSize-1, isBold: true), range: match.range)
            } else {
                attributedString.addAttribute(.foregroundColor, value: UIColor.label, range: match.range)
                attributedString.addAttribute(.font, value: IDQConstants.setFont(fontSize: fontSize, isBold: false), range: match.range)
            }
        }
        attributedText = attributedString
    }
}

extension Array where Element == UIColor {
    func toCGColors() -> [CGColor] {
        return self.map { $0.cgColor }
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

extension UIBarButtonItem {
    convenience init(image :UIImage, title :String, color: UIColor, target: Any?, action: Selector?) {
        let button = UIButton(type: .custom)
        button.setImage(image, for: .normal)
        button.setTitle(title, for: .normal)
        button.setTitleColor(color, for: .normal)
        button.frame = CGRect(x: 0, y: 0, width: image.size.width, height: image.size.height)
        
        if let target = target, let action = action {
            button.addTarget(target, action: action, for: .touchUpInside)
        }
        
        self.init(customView: button)
    }
}

extension Date {
    static var currentTime: Date {
        let now = Date()
        let secondsFromGMT = TimeZone.current.secondsFromGMT(for: now)
        return now.addingTimeInterval(TimeInterval(secondsFromGMT))
    }
}

extension Calendar {
    func numberOfDaysInCurrentMonth() -> Int {
        let date = Date()
        let range = self.range(of: .day, in: .month, for: date)!
        let numberOfDays = range.count
        return numberOfDays
    }
}

extension UIScreen {
    
    static var screenWidth: CGFloat {
        let screenSize = UIScreen.main.bounds.size
        if screenSize.width < screenSize.height {
            return UIScreen.main.bounds.width
        } else {
            return UIScreen.main.bounds.height
        }
    }
    
    static var screenHeight: CGFloat {
        let screenSize = UIScreen.main.bounds.size
        if screenSize.width > screenSize.height {
            return UIScreen.main.bounds.width
        } else {
            return UIScreen.main.bounds.height
        }
    }
    
    //static let screenWidth = UIScreen.main.bounds.width
    //static let screenHeight = UIScreen.main.bounds.height
    static let screenSize = UIScreen.main.bounds
    
    static var physicalScreenHeight: CGFloat {
        let screenBounds = UIScreen.main.bounds.size
        let isPortrait = UIApplication.shared.statusBarOrientation.isPortrait
        return isPortrait ? max(screenBounds.width, screenBounds.height) : min(screenBounds.width, screenBounds.height)
    }
    
    static var physicalScreenWidth: CGFloat {
        let screenBounds = UIScreen.main.bounds.size
        let isPortrait = UIApplication.shared.statusBarOrientation.isLandscape
        return isPortrait ? max(screenBounds.width, screenBounds.height) : min(screenBounds.width, screenBounds.height)
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

extension Notification.Name {
    static let exitQuizPressed = Notification.Name("ExitQuizPressedNotification")
}

extension UIDevice {
    static var isLandscape: Bool {
        let screenSize = UIScreen.main.bounds.size
        return screenSize.width > screenSize.height
    }
}
