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

enum IDQTopic: CaseIterable {
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
    
    var image: UIImage {
        switch self {
        case .basics:
            return IDQConstants.basicImage
        case .uikit:
            return IDQConstants.uikitImage
        case .swiftui:
            return IDQConstants.uikitImage
        case .cloudKit:
            return IDQConstants.uikitImage
        case .combine:
            return IDQConstants.uikitImage
        case .rxSwift:
            return IDQConstants.uikitImage
        case .metal:
            return IDQConstants.uikitImage
        case .coreML:
            return IDQConstants.mlImage
        case .coreAnimation:
            return IDQConstants.uikitImage
        case .avFoundation:
            return IDQConstants.uikitImage
        case .widgetKit:
            return IDQConstants.uikitImage
        case .arkit:
            return IDQConstants.arkitImage
        case .mapKit:
            return IDQConstants.uikitImage
        case .healthKit:
            return IDQConstants.uikitImage
        }
    }
    
}

struct IDQGame: Equatable {
    let gameName: String
    let type: IDQGameType
    var questionTimer: IDQGameQuestionTimer
    let topics: [IDQTopic]
    var numberOfQuestions: Int
}
