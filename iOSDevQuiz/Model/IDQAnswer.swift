//
//  IDQAnswer.swift
//  iOSDevQuiz
//
//  Created by Daniel Karath on 3/8/23.
//

import Foundation

enum IDQAnswerType: Codable {
    case correct
    case wrong
    case passed
    case runOutOfTime
    case leftQuestion
}

struct IDQAnswer: Codable {
    let text: String
    let answerType: IDQAnswerType
}
