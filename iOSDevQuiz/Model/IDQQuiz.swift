//
//  IDQQuiz.swift
//  iOSDevQuiz
//
//  Created by Daniel Karath on 3/16/23.
//

import Foundation

struct IDQQuiz {
    let gamestyle: IDQGame
    let questions: [(question: IDQQuestion, answeredCorrectly: Bool)]
    let totalScore: Int
    let time: Int
    let date: Date
}