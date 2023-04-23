//
//  RMConstants.swift
//  RickAndMorty
//
//  Created by Daniel Karath on 1/16/23.
//

import UIKit

/// The constants used everywhere in the app like UIColors, Font sizes, etc
struct IDQConstants {
    
    static let appID: String = "" //Add your App ID here
    
    //MARK: - AllowedDomains
    static let allowedDomainStrings: [String] = [
        "developer.apple.com",
        "docs.swift.org",
        "en.wikipedia.org",
        "www.kodeco.com"
    ]
    
    //MARK: - Keywords
    
    static let keywords: [String] = [
        "open",
        "public",
        "internal",
        "private",
        "fileprivate",
        "protected",
        "do-while",
        "repeat-while",
        "fallthrough",
        "return",
        "break",
        "pass",
        "override",
        "init",
        "mutating",
        "switch",
        "deinit()",
        "init()",
        "#selector",
        "@frozen",
        "@objc",
        "@optional",
        "@abstract",
        "lazy",
        "map(_:)",
        "compactMap(_:)",
        "filter()",
        "flatMap(_:)",
        "prefix(_:)",
        "becomeFirstResponder()",
        "showKeyboard()",
        "UserDefault",
        "integer(forKey:)",
        "append",
        "insert",
        "addElement",
        "zip",
        "clipsToBounds",
        "defer",
        "translatesAutoresizingMaskIntoConstraints",
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
        "UInt",
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
        "UICollectionViewDataSource",
        "MutableCollection",
        "UserDefaults",
        "Result",
        "UUID",
        "DispatchQueue.main.async",
        "DispatchQueue.main.asyncAfter",
        "collectionView(_:didSelectItemAt:)",
        "collectionView(_:numberOfItemsInSection:)",
        "collectionView(_:cellForItemAt:)",
        "collectionView(_:layout:sizeForItemAt:)",
        "collectionView(_:cellForItemAt:)",
        "sizeForItemAt",
        "append(_:at:)",
        "addElement(_:)",
        "append(_:)",
        "insert(_:at:)",
        "applicationDidBecomeActive(_:)",
        "application(_:",
        "didFinishLaunchingWithOptions:)",
        "application(_: didFinishLaunchingWithOptions: )",
        "sceneDidBecomeActive(_:)",
        "application(_:",
        "willFinishLaunchingWithOptions:)",
        "application(_: willFinishLaunchingWithOptions: )",
        "loadView()",
        "viewDidLoad()",
        "viewWillAppear()",
        "windowDidAppear()",
        "UICollectionViewCell",
        "UITableView",
        "UICollectionView",
        "layoutIfNeeded()",
        "setNeedsLayout()",
        "updateConstraints()",
        "sizeToFit()",
        "tableView(_:heightForRowAt:)",
        "UITableView.estimatedRowHeight",
        "UITableView.automaticDimension",
        "collectionView(_:willDisplay:forItemAt:)",
        "automaticDimension",
        "nil",
        "UIControl",
        "prepareForReuse()",
        "super.prepareForReuse()",
        "UISlider()",
        "UIRangeSlider()",
        "foregroundColor(_:)",
        "textColor(_:)",
        "backgroundColor(_:)",
        "SetTintColor()",
        "Color.orange",
        "ColorScheme",
        "@State",
        "@Binding",
        "@Environment",
        "UserInterfaceStyle",
        "traitCollectionDidChange",
        "onAppear(perform:)",
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
    static let darkOrange = UIColor(red: 235/255, green: 95/255, blue: 60/255, alpha: 1.0)
    
    ///The brandingColor light end for gradients.
    static let lightOrange = UIColor(red: 235/255, green: 120/255, blue: 50/255, alpha: 1.0)
    
    ///The highlighted brandingColor dark end for gradients.
    static let highlightedDarkOrange = UIColor(red: 246/255, green: 49/255, blue: 28/255, alpha: 1.0)
    
    ///The highlighted brandingColor light end for gradients.
    static let highlightedLightOrange = UIColor(red: 251/255, green: 169/255, blue: 25/255, alpha: 1.0)
    
    ///whiteColor for fonts mostly
    static let whiteColor = UIColor(red: 234/255, green: 235/255, blue: 238/255, alpha: 1.0)
    
    ///blackColor for fonts mostly
    static let blackColor = UIColor(red: 51/255, green: 51/255, blue: 54/255, alpha: 1.0)
    
    
    //MARK: - Images
    
    ///Transparent miniature of the app icon with the orange, branding color
    static let appIconMiniature: UIImage = UIImage(named: "appIconMiniature")!
    
    ///Stats icon for the total score
    static let trophyImage: UIImage = UIImage(named: "trophyImage")!
    
    ///Stats icon for the inactive trophy
    static let inactiveTrophyImage: UIImage = UIImage(named: "inactiveTrophyImage")!
    
    ///Stats icon for the total percentage
    static let targetImage: UIImage = UIImage(named: "targetImage")!
    
    ///Stats icon for the inactive total percentage
    static let inactiveTargetIcon: UIImage = UIImage(named: "inactiveTargetIcon")!
    
    ///Stats icon for the current streak
    static let streakIcon: UIImage = UIImage(named: "streakIcon")!
    
    ///Stats icon for the inactive streak
    static let inactiveStreakIcon: UIImage = UIImage(named: "inactiveStreakIcon")!
    
    static let twitterIcon: UIImage = UIImage(named: "twitterIcon")!
    
    ///Basic icon
    static let basicImage: UIImage = UIImage(named: "basicIcon")!
    
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
