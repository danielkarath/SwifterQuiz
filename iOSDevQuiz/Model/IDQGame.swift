//
//  IDQGame.swift
//  iOSDevQuiz
//
//  Created by Daniel Karath on 3/8/23.
//

import UIKit


enum IDQGameType: CaseIterable {
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

enum IDQTopic: Codable, CaseIterable {
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
            return IDQConstants.basicImage  //IDQConstants.uikitImage
        case .swiftui:
            return IDQConstants.basicImage
        case .cloudKit:
            return IDQConstants.basicImage
        case .combine:
            return IDQConstants.basicImage
        case .rxSwift:
            return IDQConstants.basicImage
        case .metal:
            return IDQConstants.basicImage
        case .coreML:
            return IDQConstants.mlImage
        case .coreAnimation:
            return IDQConstants.basicImage
        case .avFoundation:
            return IDQConstants.basicImage
        case .widgetKit:
            return IDQConstants.basicImage
        case .arkit:
            return IDQConstants.arkitImage
        case .mapKit:
            return IDQConstants.basicImage
        case .healthKit:
            return IDQConstants.basicImage
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
