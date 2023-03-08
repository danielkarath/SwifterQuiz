//
//  IDQGame.swift
//  iOSDevQuiz
//
//  Created by Daniel Karath on 3/8/23.
//

import Foundation

enum IDQGameType {
    case basic
    case trueOrFalse
    case countDown
    case specialist
    case custom
}

enum IDQGameQuestionTimer: Int {
    case cheetah = 15
    case gazelle = 30
    case zebra = 45
    case snail = 90
}

enum IDQTopic {
    case basics
    case coreData
    case cloudKit
    case combine
    case rxSwift
    case metal
    case coreML
    case coreAnimation
    case avFoundation
    case siriKit
    case widgetKit
    case mapKit
    case healthKit
    case architecturalPatterns
    
}

struct IDQGame: Equatable {
    let gameName: String
    let type: IDQGameType
    var questionTimer: IDQGameQuestionTimer
    let topics: [IDQTopic]
    var numberOfQuestions: Int
}
