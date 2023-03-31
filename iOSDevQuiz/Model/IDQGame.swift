//
//  IDQGame.swift
//  iOSDevQuiz
//
//  Created by Daniel Karath on 3/8/23.
//

import UIKit


enum IDQGameType {
    case basic
    case trueOrFalse
    case countDown
    case specialist
    case custom
}

enum IDQGameQuestionTimer: CFTimeInterval {
    case cheetah = 20
    case gazelle = 40
    case zebra = 60
    case snail = 90
}

enum IDQTopic {
    case basics
    case uikit
    case swiftui
    case cloudKit
    case combine
    case rxSwift
    case metal
    case coreML
    case coreAnimation
    case avFoundation
    case widgetKit
    case arkit
    case mapKit
    case healthKit
    
}

struct IDQGame: Equatable {
    let gameName: String
    let type: IDQGameType
    var questionTimer: IDQGameQuestionTimer
    let topics: [IDQTopic]
    var numberOfQuestions: Int
}
