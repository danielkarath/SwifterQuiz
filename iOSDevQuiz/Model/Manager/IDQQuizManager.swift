//
//  IDQQuizManager.swift
//  iOSDevQuiz
//
//  Created by Daniel Karath on 4/20/23.
//
import UIKit

final class IDQQuizManager {
    
    private let userManager = IDQUserManager()
    
    //MARK: - Public
    
    public func generateQuestions(game: IDQGame) -> [IDQQuestion]? {
        guard let user = userManager.fetchUser() else {return nil}
        let disabledQuestions: [IDQQuestion] = user.disabledQuestions as! [IDQQuestion]
        var questions: [IDQQuestion] = []
        var optionalQuestions: [IDQQuestion] = []
        for question in fullQuestionList {
            
            if !disabledQuestions.contains(where: { $0.question == question.question }) {
                if game.topics.contains(question.topic) {
                    optionalQuestions.append(question)
                }
            }
            
        }
        
        for _ in 0..<game.numberOfQuestions {
            let selectedQuestion = optionalQuestions.randomElement()
            questions.append(selectedQuestion!)
            
            if let index = optionalQuestions.firstIndex(where: { $0.question == selectedQuestion?.question }) {
                optionalQuestions.remove(at: index)
            }
        }
        return questions
    }
    
}
