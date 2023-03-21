//
//  IDQGameViewModel.swift
//  iOSDevQuiz
//
//  Created by Daniel Karath on 3/8/23.
//

import UIKit

final class IDQGameViewViewModel {
        
    
    /// The current round of a IDQQuiz
    public var quizRound: Int = 0
    
    //MARK: - Init
    init(
        
    ) {
        
    }
    //MARK: - Private
    
    /// Combines an Array of IDQQuestions and an array of Bool into a Tuple. Works with two array of the same size.
    /// - Parameters:
    ///   - questions: An Array of IDQQuestions
    ///   - answers: An Array of Bool representing whether the Question was answered correctlt by the user or not.
    /// - Returns: An Array of (IDQQuestion, Bool) Tuples
    private func createQuestionTuples(with questions: [IDQQuestion], with answers: [Bool]) -> [(question: IDQQuestion, answeredCorrectly: Bool)] {
        guard questions.count == answers.count else {
            
            fatalError("Question and answer arrays must have the same number of elements\nquestions.count: \(questions.count)\nanswers.count: \(answers.count)")
        }
        var questionsTuple: [(question: IDQQuestion, answeredCorrectly: Bool)] = []
        
        for (index, question) in questions.enumerated() {
            let isAnsweredCorrectly = answers[index]
            questionsTuple.append((question: question, answeredCorrectly: isAnsweredCorrectly))
        }
        return questionsTuple
    }
    
    //MARK: - Public
    
    public func getQuizResults(game: IDQGame, questions: [IDQQuestion], isCorrect answerArray: [Bool], totalScore: Int, quizDuration: Int) -> IDQQuiz {
        let questionsTuple = createQuestionTuples(with: questions, with: answerArray)
        let quiz = IDQQuiz(
            gamestyle: game,
            questions: questionsTuple,
            totalScore: totalScore,
            time: quizDuration,
            date: Date()
        )
        return quiz
    }
    
    public func didTapContinue(game: IDQGame) -> Bool {
        var wasLastQuestion: Bool?
        if quizRound != game.numberOfQuestions {
            quizRound += 1
            wasLastQuestion = false
        } else {
            quizRound = 0
            wasLastQuestion = true
        }
        guard let wasLastQuestion = wasLastQuestion else { return false } 
        return wasLastQuestion
    }
    
}
