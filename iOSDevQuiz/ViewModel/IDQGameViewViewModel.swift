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
    private func createQuestionTuples(with questions: [IDQQuestion], with answers: [IDQAnswerType], for game: IDQGame) -> [(question: IDQQuestion, answerType: IDQAnswerType)] {
        
        if game.type == .basic {
            guard questions.count == answers.count else {
                fatalError("Question and answer arrays must have the same number of elements\nquestions.count: \(questions.count)\nanswers.count: \(answers.count)")
            }
            var questionsTuple: [(question: IDQQuestion, answerType: IDQAnswerType)] = []
            
            for (index, question) in questions.enumerated() {
                let answerType = answers[index]
                questionsTuple.append((question: question, answerType: answerType))
            }
            return questionsTuple
        } else if game.type == .trueOrFalse {
            var questionsTuple: [(question: IDQQuestion, answerType: IDQAnswerType)] = []
            var i = answers.count
            for (index, question) in questions.enumerated() {
                if i > 0 {
                    let answerType = answers[index]
                    questionsTuple.append((question: question, answerType: answerType))
                } else {
                    break
                }
                i -= 1
            }
            
            return questionsTuple
        } else {
            fatalError("Fatal Error: IDQGameViewViewModel createQuestionTuples game type not yet implemented")
        }

    }
    
    //MARK: - Public
    
    public func getQuizResults(game: IDQGame, questions: [IDQQuestion], isCorrect answerArray: [IDQAnswerType], totalScore: Int, quizDuration: TimeInterval) -> IDQQuiz {
        //Adjusted quiz duration due to the animations
        var adjustedQuizDuration: TimeInterval = Double(questions.count) * 0.80
        adjustedQuizDuration = quizDuration - adjustedQuizDuration
        if adjustedQuizDuration < 0 {
            adjustedQuizDuration = 0
        }
        let questionsTuple = createQuestionTuples(with: questions, with: answerArray, for: game)
        let quiz = IDQQuiz(
            gamestyle: game,
            questions: questionsTuple,
            totalScore: totalScore,
            quizDuration: adjustedQuizDuration,
            date: Date.currentTime
        )
        return quiz
    }
    
    public func isLastQuestion(game: IDQGame) -> Bool {
        var shouldDisplayResults: Bool?
        if quizRound != game.numberOfQuestions {
            quizRound += 1
            shouldDisplayResults = true
        } else {
            quizRound = 0
            shouldDisplayResults = false
        }
        guard let wasLastQuestion = shouldDisplayResults else { return false }
        return wasLastQuestion
    }
    
}
