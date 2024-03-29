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
    var quizDuration: TimeInterval
    let date: Date
}

