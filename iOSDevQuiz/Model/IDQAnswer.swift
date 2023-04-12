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
