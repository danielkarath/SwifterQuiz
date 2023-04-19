//
//  IDQAboutViewViewModel.swift
//  iOSDevQuiz
//
//  Created by Daniel Karath on 4/19/23.
//
import UIKit
import SwiftUI
import SafariServices

class IDQAboutViewViewModel: ObservableObject {
        
    //MARK: - Private
    private func loadSafariView(with url: URL) {
          UIApplication.shared.open(url)
    }
    
    //MARK: Public
    public func didTap(on option: IDQAboutOption) {
        switch option {
        case .twitter:
            guard let url = option.targetURL else {return}
            
            let appURL = URL(string: "twitter://user?screen_name=DanielKarath")!
            
            if UIApplication.shared.canOpenURL(appURL) {
                UIApplication.shared.open(appURL, options: [:], completionHandler: nil)
            } else {
                UIApplication.shared.open(url, options: [:], completionHandler: nil)
            }

        case .website:
            guard let url = option.targetURL else {return}
            loadSafariView(with: url)
        case .viewCode:
            guard let githubAppURL = option.targetURL else {return}
            if UIApplication.shared.canOpenURL(githubAppURL) {
                UIApplication.shared.open(githubAppURL, options: [:], completionHandler: nil)
            } else {
                loadSafariView(with: githubAppURL)
            }
        }
    }
    
}

enum IDQAboutOption: CaseIterable {
    case website
    case viewCode
    case twitter
    
    var targetURL: URL? {
        switch self {
        case .website:
            return URL(string: "https://danielkarath.com")
        case .viewCode:
            return URL(string: "https://github.com/danielkarath/iOSDevQuiz")
        case .twitter:
            return URL(string: "https://twitter.com/DanielKarath")
        }
    }
    
}
