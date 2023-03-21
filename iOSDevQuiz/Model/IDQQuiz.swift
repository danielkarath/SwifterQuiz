//
//  IDQQuiz.swift
//  iOSDevQuiz
//
//  Created by Daniel Karath on 3/16/23.
//

import Foundation

struct IDQQuiz {
    let gamestyle: IDQGame
    var questions: [IDQQuestion]
    var totalScore: Int
    var time: Int
    let date: Date
}
