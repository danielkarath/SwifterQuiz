//
//  IDQUserActivityManager.swift
//  iOSDevQuiz
//
//  Created by Daniel Karath on 4/23/23.
//

import Foundation
import UIKit

struct IDQUserActivityManager {
    
    enum IDQUserDefaults {
        case launchCount
        case quizMenuCount
        case didrateApp
        case didDismissRate
    }
    
    static let shared = IDQUserActivityManager()
    
    public let userDefaults = UserDefaults.standard
    
    
    ///Increments the number of times the app was launched by 1
    public func launchCount() {
        let launchCount = userDefaults.integer(forKey: "launchCount")
        DispatchQueue.global(qos: .utility).async {
            let updatedLaunchCount = launchCount + 1
            userDefaults.set(updatedLaunchCount, forKey: "launchCount")
            userDefaults.setValue(false, forKey: "didDismissRateMe")
        }
    }
    
    ///Increments the number of times the user navigated to the quiz menu. The primary purpose of this counter will be to occasionnaly display the rate the app view for ratings.
    public func quizMenuCount() {
        let quizMenuCount = userDefaults.integer(forKey: "quizMenuCount")
        DispatchQueue.global(qos: .utility).async {
            let updatedquizMenuCount = quizMenuCount + 1
            userDefaults.set(updatedquizMenuCount, forKey: "quizMenuCount")
        }
    }
    
    public func didRateApp() {
        let didRateAppKey = "didRateApp"
        let didRateApp = userDefaults.bool(forKey: didRateAppKey)
        DispatchQueue.global(qos: .background).async {
            userDefaults.setValue(true, forKey: didRateAppKey)
        }
    }
    
    public func toggle(boolean userDefaultEnum: IDQUserDefaults) {
        var userDefaultKey: String?
        if userDefaultEnum == .didDismissRate {
            userDefaultKey = "didDismissRateMe"
        } else if userDefaultEnum == .didrateApp {
            userDefaultKey = "didRateApp"
        }
        guard let key = userDefaultKey else {return}
        DispatchQueue.global(qos: .background).async {
            var userDefault = userDefaults.bool(forKey: key)
            var userdefault = userDefault.toggle()
            self.userDefaults.setValue(true, forKey: key)
        }
        
    }
    
}
