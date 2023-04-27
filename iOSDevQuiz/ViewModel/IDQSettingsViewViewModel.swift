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
    
    public var subtitle: String {
        return type.displaySubtitle
    }
    
}


enum IDQSettingsOption: CaseIterable {
    case quizSettings
    case about
    case rateApp
    case contact
    case donate
    
    var targetURL: URL? {
        switch self {
        case .quizSettings:
            return nil
        case .about:
            return nil
            //return URL(string: "https://danielkarath.com")
        case .rateApp:
            return nil
        case .contact:
            return nil
        case .donate:
            return URL(string: "https://github.com/danielkarath/iOSDevQuiz")
        }
    }
    
    var displayTitle: String {
        switch self {
        case .quizSettings:
            //return "Quiz settings"
            return "Disabled Questions"
        case .about:
            return "About"
        case .rateApp:
            return "Rate App"
        case .contact:
            return "Feedback"
        case .donate:
            return "Donate"
        }
        
    }
    
    var displaySubtitle: String {
        switch self {
        case .quizSettings:
            //return "Manage questions, topics, timers"
            return "Review your disabled questions"
        case .about:
            return "Learn more about the app"
        case .rateApp:
            return "Rate iOS Dev Quiz 5 stars"
        case .contact:
            return "Reach out to the developer"
        case .donate:
            return "Buy me a coffee"
        }
        
    }
    
    var iconImage: UIImage? {
        switch self {
        case .quizSettings:
            //return UIImage(systemName: "gear.badge.questionmark")
            return UIImage(systemName: "nosign")
        case .about:
            return UIImage(systemName: "person.fill")
        case .rateApp:
            return UIImage(systemName: "star.fill")
        case .contact:
            return UIImage(systemName: "envelope.fill")
        case .donate:
            return UIImage(systemName: "cup.and.saucer.fill")
        }
    }
}
