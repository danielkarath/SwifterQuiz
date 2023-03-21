////
////  IDQResultCollectionViewCellViewModel.swift
////  iOSDevQuiz
////
////  Created by Daniel Karath on 3/21/23.
////
//import Foundation
//
//struct IDQResultCollectionViewCellViewModel {
//    
//    public let question: IDQQuestion
//    public let questionDifficulty: IDQQuestionDifficulty
//    public let wasAnsweredCorrectly: Bool
//    
//    init(
//        question: IDQQuestion,
//        questionDifficulty: IDQQuestionDifficulty,
//        wasAnsweredCorrectly: Bool
//    ) {
//        self.question = question
//        self.questionDifficulty = questionDifficulty
//        self.wasAnsweredCorrectly = wasAnsweredCorrectly
//    }
//    
//    public var questionText: String {
//        return "\(question.question)"
//    }
//    
//    public var questionTopic: String {
//        return "\(question.topic)"
//    }
//    
//    public var questionReference: String {
//        guard question.reference != nil else { return "N/A" }
//        return question.reference!
//    }
//    
//}
