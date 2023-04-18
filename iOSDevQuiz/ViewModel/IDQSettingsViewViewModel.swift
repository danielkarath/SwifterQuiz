//
//  IDQSettingsViewViewModel.swift
//  iOSDevQuiz
//
//  Created by Daniel Karath on 4/18/23.
//

import UIKit

struct IDQSettingsViewViewModel {
    let cellViewModels: [IDQSettingsCellViewModel]
}

struct IDQSettingsCellViewModel: Identifiable {
    
    var id = UUID()
    
    //MARK: - Init
    
    init(type: IDQSettingsOption, onTapHandler: @escaping (IDQSettingsOption) -> Void) {
        self.type = type
        self.onTapHandler = onTapHandler
    }
    
    
    //MARK: Public
    
    public let type: IDQSettingsOption
    
    public let onTapHandler: (IDQSettingsOption) -> Void
    
    public var image: UIImage? {
        return type.iconImage
    }
    public var title: String {
        return type.displayTitle
    }
    
    public var iconContainerColor: UIColor? {
        return type.iconContainerColor
    }
}


enum IDQSettingsOption: CaseIterable {
    case about
    case rateApp
    case contact
    case viewCode
    
    var targetURL: URL? {
        switch self {
        case .about:
            return nil
            //return URL(string: "https://danielkarath.com")
        case .rateApp:
            return nil
        case .contact:
            return nil
        case .viewCode:
            return URL(string: "https://github.com/danielkarath/iOSDevQuiz")
        }
    }
    
    var displayTitle: String {
        switch self {
        case .about:
            return "About"
        case .rateApp:
            return "Rate App"
        case .contact:
            return "Contact Developer"
        case .viewCode:
            return "View source Code"
        }
        
    }
    
    var iconContainerColor: UIColor {
        
        return IDQConstants.highlightedDarkOrange
        
//        switch self {
//        case .about:
//            return UIColor(named: "mainColor") ?? .systemGreen
//        case .rateApp:
//            return .systemYellow
//        case .contact:
//            return .systemOrange
//        case .viewCode:
//            return .systemBlue
//        }
    }
    
    var iconImage: UIImage? {
        switch self {
        case .about:
            return UIImage(systemName: "person.fill")
        case .rateApp:
            return UIImage(systemName: "star.fill")
        case .contact:
            return UIImage(systemName: "envelope.fill")
        case .viewCode:
            return UIImage(systemName: "hammer.fill")
        }
    }
}
