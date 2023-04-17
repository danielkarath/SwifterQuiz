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
//    
//    init(text: String, answerType: IDQAnswerType) throws {
//            guard text.count <= 16 else {
//                throw IDQAnswerError.textTooLong
//            }
//            self.text = text
//            self.answerType = answerType
//        }
//    
//    enum IDQAnswerError: Error {
//        case textTooLong
//    }
}
