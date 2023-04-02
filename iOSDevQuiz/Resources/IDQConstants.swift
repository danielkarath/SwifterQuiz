//
//  RMConstants.swift
//  RickAndMorty
//
//  Created by Daniel Karath on 1/16/23.
//

import UIKit

/// The constants used everywhere in the app like UIColors, Font sizes, etc
struct IDQConstants {
     
    //MARK: - Keywords
    
    static let keywords: [String] = [
        "deinit()",
        "init()",
        "@frozen",
        "lazy",
        "append",
        "insert",
        "addElement",
        "zip",
        "removeCheckpoints",
        "CustomStringConvertible",
        "Equatable",
        "Hashable",
        "Comparable",
        "Collection",
        "TextOutputStreamable",
        "Sequence",
        "IteratorProtocol",
        "Codable",
        "Encodable",
        "Decodable",
        "Error",
        "ExpressibleByArrayLiteral",
        "ExpressibleByBooleanLiteral",
        "ExpressibleByDictionaryLiteral",
        "ExpressibleByFloatLiteral",
        "ExpressibleByIntegerLiteral",
        "ExpressibleByNilLiteral",
        "ExpressibleByStringLiteral",
        "BinaryInteger",
        "SignedInteger",
        "UnsignedInteger",
        "FloatingPoint",
        "RandomNumberGenerator",
        "RawRepresentable",
        "Strideable",
        "CustomReflectable",
        "CustomPlaygroundDisplayConvertible",
        "AnyObject",
        "AnyHashable",
        "DynamicCallable",
        "Int",
        "Double",
        "Float",
        "Bool",
        "String",
        "Character",
        "Optional",
        "Array",
        "Dictionary",
        "Set",
        "Tuple",
        "Enum",
        "Struct",
        "Class",
        "Protocol",
        "Extension",
        "Function",
        "Closure",
        "Any",
        "AnyObject",
        "Typealias",
        "Range",
        "ClosedRange",
        "CountableRange",
        "CountableClosedRange",
        "Error",
        "Sequence",
        "IteratorProtocol",
        "Collection",
        "MutableCollection",
        "UserDefaults",
        "Result",
        "UUID"
    ]
    
    //MARK: - Background colors
    
    ///The backgroundColor is the UIColor for simple background areas.
    static let backgroundColor: UIColor = UIColor(named: "backgroundColor")!
    
    ///The contentBackgroundColor is the UIColor for differentiated, container backgrounds.
    static let contentBackgroundColor: UIColor = UIColor(named: "contentBackgroundColor")!
    
    ///The highlightedContentBackgroundColor is the UIColor for differentiated & highlighted, container backgrounds.
    static let highlightedContentBackgroundColor: UIColor = UIColor(named: "highlightedContentBackgroundColor")!
    
    //MARK: - Text colors
    
    ///The basicFontColor is the UIColor for basic UILabels, TextFields, UIButtons...
    static let basicFontColor: UIColor = UIColor(named: "basicFontColor")!
    
    ///The highlightFontColor is the UIColor for highlighted UILabels, TextFields, UIButtons...
    static let highlightFontColor: UIColor = UIColor(named: "highlightFontColor")!
    
    ///The activeBackgroundColor is the UIColor for active or highlighted, backgrounds. It's the same color as the keyboard
    static let secondaryFontColor: UIColor = UIColor(named: "secondaryFontColor")!
    
    
    //MARK: - Branding Colors
    
    ///The correctColor is representative for the correctly answered questions
    static let correctColor: UIColor = UIColor(named: "correctColor") ?? UIColor(red: 10/255, green: 190/255, blue: 35/255, alpha: 1.0)
    
    ///The correctBackgroundColor is for the background color for the correctly answered questions IDQAnswerResultView
    static let correctBackgroundColor = UIColor { (traitCollection: UITraitCollection) -> UIColor in
        if traitCollection.userInterfaceStyle == .dark {
            return UIColor(named: "correctBackgroundColor") ?? UIColor(red: 240/255, green: 255/255, blue: 235/255, alpha: 1.00)
        } else {
            return UIColor(named: "correctBackgroundColor") ?? UIColor(red: 34/255, green: 40/255, blue: 34/255, alpha: 1.00)
        }
    }
    
    ///The errorColor is representative for the wrongly answered questions
    static let errorColor: UIColor = UIColor(named: "errorColor") ?? UIColor(red: 245/255, green: 61/255, blue: 73/255, alpha: 1.0)
    
    //////The errorBackgroundColor is for the background color for the correctly answered questions IDQAnswerResultView
    static let errorBackgroundColor = UIColor { (traitCollection: UITraitCollection) -> UIColor in
        if traitCollection.userInterfaceStyle == .dark {
            return UIColor(named: "errorBackgroundColor") ?? UIColor(red: 44/255, green: 30/255, blue: 33/255, alpha: 1.0)
        } else {
            return UIColor(named: "errorBackgroundColor") ?? UIColor(red: 255/255, green: 226/255, blue: 228/255, alpha: 1.0)
        }
    }
    
    ///The warningColor is representative for the missed or passed, unanswered questions
    static let warningColor: UIColor = UIColor(named: "warningColor") ?? UIColor(red: 245/255, green: 130/255, blue: 55/255, alpha: 1.0)
    
    ///The backgroundErrorColor is for the background color for the wrongly answered questions IDQAnswerResultView
    static let warningBackgroundColor = UIColor { (traitCollection: UITraitCollection) -> UIColor in
        if traitCollection.userInterfaceStyle == .dark {
            return UIColor(named: "warningBackgroundColor")  ?? UIColor(red: 38/255, green: 37/255, blue: 35/255, alpha: 1.00)
        } else {
            return UIColor(named: "warningBackgroundColor")  ?? UIColor(red: 254/255, green: 240/255, blue: 215/255, alpha: 1.00)
        }
    }
    
    //MARK: - Gradient Colors
    
    ///The brandingColor dark end for gradients.
    static let darkOrange = UIColor(red: 224/255, green: 80/255, blue: 52/255, alpha: 1.0)
    
    ///The brandingColor light end for gradients.
    static let lightOrange = UIColor(red: 244/255, green: 128/255, blue: 47/255, alpha: 1.0)
    
    ///The highlighted brandingColor dark end for gradients.
    static let highlightedDarkOrange = UIColor(red: 246/255, green: 49/255, blue: 28/255, alpha: 1.0)
    
    ///The highlighted brandingColor light end for gradients.
    static let highlightedLightOrange = UIColor(red: 251/255, green: 169/255, blue: 25/255, alpha: 1.0)
    
    //MARK: - Images
    
    ///Transparent miniature of the app icon with the orange, branding color
    static let appIconMiniature: UIImage = UIImage(named: "appIconMiniature")!
    
    /// UIKit icon
    static let uikitImage: UIImage = UIImage(named: "uikitIcon")!
    
    ///MLCore image
    static let mlImage: UIImage = UIImage(named: "mlIcon")!
    
    /// ARKit icon
    static let arkitImage: UIImage = UIImage(named: "arkitIcon")!
    
    //MARK: Font
    public static func setFont(fontSize: CGFloat, isBold: Bool) -> UIFont {
        if isBold {
            return UIFont(name: "Kailasa Bold", size: fontSize)!
        } else {
            return UIFont(name: "Kailasa Regular", size: fontSize)!
        }
    }
    
}
