//
//  IDQAnswer.swift
//  iOSDevQuiz
//
//  Created by Daniel Karath on 3/8/23.
//

import Foundation

enum IDQAnswerType {
    case correct
    case wrong
    case passed
    case runOutOfTime
}

struct IDQAnswer {
    let text: String
    let answerType: IDQAnswerType
}
