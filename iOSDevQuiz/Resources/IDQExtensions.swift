//
//  IDQExtensions.swift
//  iOSDevQuiz
//
//  Created by Daniel Karath on 3/2/23.
//

import UIKit


extension UIView {
    func addSubviews(_ views: UIView...) {
        views.forEach ({
            addSubview($0)
        })
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
