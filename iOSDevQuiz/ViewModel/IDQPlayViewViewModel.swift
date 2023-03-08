//
//  IDQPlayViewViewModel.swift
//  iOSDevQuiz
//
//  Created by Daniel Karath on 3/8/23.
//

import UIKit

protocol IDQPlayViewViewModelDelegate: AnyObject {
    func didGenerateGame()
}

final class IDQPlayViewViewModel {
    
    public weak var delegate: IDQPlayViewViewModelDelegate?
    
    //MARK: - Init
    init(
        
    ) {
        
    }
    
    public func generateQuestions(game: IDQGame) -> [IDQQuestion] {
        var questions: [IDQQuestion] = []
        var optionalQuestions: [IDQQuestion] = []
        for question in idqQuestionList {
            if game.topics.contains(question.topic) {
                optionalQuestions.append(question)
            }
        }
        
        for _ in 0..<game.numberOfQuestions {
            let selectedQuestion = optionalQuestions.randomElement()
            questions.append(selectedQuestion!)
        }
        return questions
    }
    
}
