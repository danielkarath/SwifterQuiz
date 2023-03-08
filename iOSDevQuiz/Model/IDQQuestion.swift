//
//  IDQQuestion.swift
//  iOSDevQuiz
//
//  Created by Daniel Karath on 3/8/23.
//

import Foundation

enum IDQQuestionDifficulty {
    case easy
    case medium
    case hard
}

struct IDQQuestion {
    let question: String
    let hint: String
    let difficulty: IDQQuestionDifficulty
    let topic: IDQTopic
    let answers: [IDQAnswer]
}

let idqQuestionList: [IDQQuestion] = [
    IDQQuestion(question: "What is the method deinit() used for?", hint: "duck", difficulty: .medium, topic: .basics, answers: [idqAnswerList[0], idqAnswerList[1], idqAnswerList[2], idqAnswerList[3]]),
]

let idqAnswerList: [IDQAnswer] = [
    IDQAnswer(answer: "deinit() is called to create a new instance of a particular type", isCorrect: false, topic: .basics),
    IDQAnswer(answer: "The deinit() is called to unconditionally stop execution.", isCorrect: false, topic: .basics),
    IDQAnswer(answer: "The deinit() method is called on the app delegate when the app is about to move from the active to inactive state.", isCorrect: false, topic: .basics),
    IDQAnswer(answer: "A deinitializer is called immediately before a class instance is deallocated.", isCorrect: true, topic: .basics),
    
    
]
