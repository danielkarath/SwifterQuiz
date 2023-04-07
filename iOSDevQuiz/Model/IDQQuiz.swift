//
//  IDQQuiz.swift
//  iOSDevQuiz
//
//  Created by Daniel Karath on 3/16/23.
//

import Foundation

struct IDQQuiz {
    let gamestyle: IDQGame
    let questions: [(question: IDQQuestion, answerType: IDQAnswerType)]
    let totalScore: Int
    let time: TimeInterval
    let date: Date
}
