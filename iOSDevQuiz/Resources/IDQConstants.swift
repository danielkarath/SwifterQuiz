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
    
    static let keywords: [(keword: String, keyColor: UIColor)] = [
        ("deinit()", funcKeywordColor),
        ("init()", funcKeywordColor),
        ("@frozen", funcKeywordColor),
        ("lazy", funcKeywordColor),
        
        ("append", propertyKeywordColor),
        ("insert", propertyKeywordColor),
        ("addElement", propertyKeywordColor),
        ("zip", propertyKeywordColor),
        ("removeCheckpoints", propertyKeywordColor),
        
        ("applicationDidBecomeActive", variableKeywordColor),
        ("willFinishLaunchingWithOptions", variableKeywordColor),
        ("sceneDidBecomeActive", variableKeywordColor),
        ("didFinishLaunchingWithOptions", variableKeywordColor),
                
        ("CustomStringConvertible", otherKeywordColor),
        ("Equatable", otherKeywordColor),
        ("Hashable", otherKeywordColor),
        ("Comparable", otherKeywordColor),
        ("Collection", otherKeywordColor),
        ("Sequence", otherKeywordColor),
        ("IteratorProtocol", otherKeywordColor),
        ("Codable", otherKeywordColor),
        ("Encodable", otherKeywordColor),
        ("Decodable", otherKeywordColor),
        ("Error", otherKeywordColor),
        ("ExpressibleByArrayLiteral", otherKeywordColor),
        ("ExpressibleByBooleanLiteral", otherKeywordColor),
        ("ExpressibleByDictionaryLiteral", otherKeywordColor),
        ("ExpressibleByFloatLiteral", otherKeywordColor),
        ("ExpressibleByIntegerLiteral", otherKeywordColor),
        ("ExpressibleByNilLiteral", otherKeywordColor),
        ("ExpressibleByStringLiteral", otherKeywordColor),
        ("BinaryInteger", otherKeywordColor),
        ("SignedInteger", otherKeywordColor),
        ("UnsignedInteger", otherKeywordColor),
        ("FloatingPoint", otherKeywordColor),
        ("RandomNumberGenerator", otherKeywordColor),
        ("RawRepresentable", otherKeywordColor),
        ("Strideable", otherKeywordColor),
        ("CustomReflectable", otherKeywordColor),
        ("CustomPlaygroundDisplayConvertible", otherKeywordColor),
        ("AnyObject", otherKeywordColor),
        ("AnyHashable", otherKeywordColor),
        ("DynamicCallable", otherKeywordColor),
        
        ("Int", classTypeKeywordColor),
        ("Double", classTypeKeywordColor),
        ("Float", classTypeKeywordColor),
        ("Bool", classTypeKeywordColor),
        ("String", classTypeKeywordColor),
        ("Character", classTypeKeywordColor),
        ("Optional", classTypeKeywordColor),
        ("Array", classTypeKeywordColor),
        ("Dictionary", classTypeKeywordColor),
        ("Set", classTypeKeywordColor),
        ("Tuple", classTypeKeywordColor),
        ("Enum", classTypeKeywordColor),
        ("Struct", classTypeKeywordColor),
        ("Class", classTypeKeywordColor),
        ("Protocol", classTypeKeywordColor),
        ("Extension", classTypeKeywordColor),
        ("Function", classTypeKeywordColor),
        ("Closure", classTypeKeywordColor),
        ("Any", classTypeKeywordColor),
        ("AnyObject", classTypeKeywordColor),
        ("Typealias", classTypeKeywordColor),
        ("Range", classTypeKeywordColor),
        ("ClosedRange", classTypeKeywordColor),
        ("CountableRange", classTypeKeywordColor),
        ("CountableClosedRange", classTypeKeywordColor),
        ("Error", classTypeKeywordColor),
        ("Sequence", classTypeKeywordColor),
        ("IteratorProtocol", classTypeKeywordColor),
        ("Collection", classTypeKeywordColor),
        ("MutableCollection", classTypeKeywordColor),
        ("UserDefaults", classTypeKeywordColor),
        ("Result", classTypeKeywordColor),
        ("UUID", classTypeKeywordColor)
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
    
    ///The brandingColor is for the very main UI element of the app.
    static let funcKeywordColor: UIColor = UIColor(named: "funcKeywordColor") ?? UIColor(red: 230/255, green: 90/255, blue: 135/255, alpha: 1.0)
    
    static let classTypeKeywordColor: UIColor = UIColor(named: "classTypeKeywordColor") ?? UIColor(red: 180/255, green: 135/255, blue: 235/255, alpha: 1.0)
    
    static let otherKeywordColor: UIColor = UIColor(named: "otherKeywordColor") ?? UIColor(red: 140/255, green: 130/255, blue: 240/255, alpha: 1.0)
    
    static let propertyKeywordColor: UIColor = UIColor(named: "propertyKeywordColor") ?? UIColor(red: 85/255, green: 100/255, blue: 225/255, alpha: 1.0)
    
    static let variableKeywordColor: UIColor = UIColor(named: "variableKeywordColor") ?? UIColor(red: 60/255, green: 130/255, blue: 250/255, alpha: 1.0)
    
    ///The correctColor is representative for the correctly answered questions
    static let correctColor: UIColor = UIColor(named: "correctColor")!
    
    ///The errorColor is representative for the wrongly answered questions
    static let errorColor: UIColor = UIColor(named: "errorColor")!
    
    
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
    
    //MARK: Font
    public static func setFont(fontSize: CGFloat, isBold: Bool) -> UIFont {
        if isBold {
            return UIFont(name: "Kailasa Bold", size: fontSize)!
        } else {
            return UIFont(name: "Kailasa Regular", size: fontSize)!
        }
    }
    
}
