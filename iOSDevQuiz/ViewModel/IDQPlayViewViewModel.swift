//
//  IDQPlayViewViewModel.swift
//  iOSDevQuiz
//
//  Created by Daniel Karath on 3/8/23.
//

import UIKit

final class IDQPlayViewViewModel {
    
    enum IDQGameType {
        case quicQuiz
        case trueOrFalse
        case countDown
        case specialist
        case custom
        case tester
    }
    
    private let userManager = IDQUserManager()
    
    private let idqGameList: [IDQGame] = [
        IDQGame(gameName: "Default", type: .basic, questionTimer: .gazelle, topics: [.basics, .uikit], numberOfQuestions: 10),
        IDQGame(gameName: "True Or False", type: .trueOrFalse, questionTimer: .cheetah, topics: [.basics, .cloudKit, .combine, .cloudKit], numberOfQuestions: 15),
        IDQGame(gameName: "Count Down", type: .trueOrFalse, questionTimer: .cheetah, topics: [.basics], numberOfQuestions: 15),
        IDQGame(gameName: "Tester", type: .basic, questionTimer: .cheetah, topics: [.basics, .uikit], numberOfQuestions: 2),
    ]
    
    //MARK: - Public
    
    public let userDefaults = UserDefaults.standard
    
    public func shouldDisplay(view: UIView) -> Bool {
        let launchCountKey = "launchCount"
        let appLaunchCount = userDefaults.integer(forKey: launchCountKey)
        
        let menuLoadKey = "quizMenuCount"
        let menuLoadCount = UserDefaults.standard.integer(forKey: menuLoadKey)
        
        let didRateAppKey = "didRateApp"
        let didRateApp = UserDefaults.standard.bool(forKey: didRateAppKey)
        
        let didDismissRateMeKey = "didDismissRateMe"
        let didDismissRateMe = UserDefaults.standard.bool(forKey: didDismissRateMeKey)
        
        if !didRateApp && !didDismissRateMe {
            if appLaunchCount == 2 {
                return true
            } else if menuLoadCount == 2 ||  menuLoadCount % 7 == 0 {
                return true
            } else {
                return false
            }
        } else {
            return false
        }
    }
    
    public func didTapButton(for game: IDQGameType) -> IDQGame {
        switch game {
        case .quicQuiz:
            return idqGameList[0]
        case .trueOrFalse:
            return idqGameList[1]
        case .countDown:
            return idqGameList[2]
        case .specialist:
            print("NOT YET IMPLEMENTED")
            return idqGameList[0]
        case .custom:
            print("NOT YET IMPLEMENTED")
            return idqGameList[0]
        case .tester:
            return idqGameList[3]
        default:
            return idqGameList[0]
        }
    }
    
    public func didCloseRate() {
        IDQUserActivityManager.shared.toggle(boolean: .didDismissRate)
    }
    
    public func didRateApp() {
        IDQUserActivityManager.shared.toggle(boolean: .didrateApp)
    }
    
    public func fetchBookmarkedQuestions() -> [IDQQuestion] {
        guard let user = userManager.fetchUser() else {return []}
        return user.bookmarkedQuestions as! [IDQQuestion]
    }
    
}
