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
    
}
