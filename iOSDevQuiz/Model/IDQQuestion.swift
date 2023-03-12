//
//  IDQQuestion.swift
//  iOSDevQuiz
//
//  Created by Daniel Karath on 3/8/23.
//

import Foundation

enum IDQQuestionDifficulty: String {
    case easy = "easy"
    case medium = "medium"
    case hard = "hard"
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
    IDQQuestion(question: "What are tuples?", hint: "duck", difficulty: .medium, topic: .basics, answers: [idqAnswerList[4], idqAnswerList[5], idqAnswerList[6], idqAnswerList[7]]),
    IDQQuestion(question: "What does the Codable protocol do?", hint: "duck", difficulty: .medium, topic: .basics, answers: [idqAnswerList[8], idqAnswerList[9], idqAnswerList[10], idqAnswerList[11]]),
    IDQQuestion(question: "What are enums used for?", hint: "duck", difficulty: .medium, topic: .basics, answers: [idqAnswerList[12], idqAnswerList[13], idqAnswerList[14], idqAnswerList[15]]),
    IDQQuestion(question: "What are UserDefaults?", hint: "duck", difficulty: .medium, topic: .basics, answers: [idqAnswerList[16], idqAnswerList[17], idqAnswerList[18], idqAnswerList[19]]),
    
]

let idqAnswerList: [IDQAnswer] = [
    //1 What is the method deinit() used for?
    IDQAnswer(text: "deinit() is called to create a new instance of a particular type", isCorrect: false, topic: .basics),
    IDQAnswer(text: "The deinit() is called to unconditionally stop execution.", isCorrect: false, topic: .basics),
    IDQAnswer(text: "The deinit() method is called on the app delegate when the app is about to move from the active to inactive state.", isCorrect: false, topic: .basics),
    IDQAnswer(text: "The deinit() is called immediately before a class instance is deallocated.", isCorrect: true, topic: .basics),
    
    //2 What are tuples?
    IDQAnswer(text: "A control flow statement that allows you to break out of a loop or switch statement.", isCorrect: false, topic: .basics),
    IDQAnswer(text: "A collection type that can store multiple values of the same type in an ordered list.", isCorrect: false, topic: .basics),
    IDQAnswer(text: "A Tuple is collection of values of either Int, String or Bool types", isCorrect: false, topic: .basics),
    IDQAnswer(text: "A Tuple is a collection of values of any type, which can be of different types.", isCorrect: true, topic: .basics),
    
    //3 What does the Codable protocol do?
    IDQAnswer(text: "A protocol that defines methods for converting a Swift object to and from a binary format.", isCorrect: false, topic: .basics),
    IDQAnswer(text: "A protocol that defines methods for performing cryptographic operations in Swift.", isCorrect: false, topic: .basics),
    IDQAnswer(text: "A protocol that provides a standardized way to decode objects from JSON, binary, or other data formats.", isCorrect: false, topic: .basics),
    IDQAnswer(text: "A protocol that provides a standardized way to encode and decode objects to and from JSON, binary, or other data formats.", isCorrect: true, topic: .basics),
    
    //4 "What are enums used for?"
    IDQAnswer(text: "Enums are a tool to debug errors in Swift programming language.", isCorrect: false, topic: .basics),
    IDQAnswer(text: "Enums are a type of array used to store multiple values of the same type.", isCorrect: false, topic: .basics),
    IDQAnswer(text: "A collection type that can store multiple values of the same type in an ordered list.", isCorrect: false, topic: .basics),
    IDQAnswer(text: "Enums are a way to define a group of related values in Swift.", isCorrect: true, topic: .basics),
    
    //5 What are UserDefaults?
    IDQAnswer(text: "UserDefaults are a set of built-in functions and methods that can be used to manipulate user interface elements such as buttons and labels.", isCorrect: false, topic: .basics),
    IDQAnswer(text: "UserDefaults are a type of in-memory cache that can be used to store frequently accessed data to improve the application's performance.", isCorrect: false, topic: .basics),
    IDQAnswer(text: "UserDefaults are complex data structures that allow you to store and retrieve large amounts of data in a key-value format.", isCorrect: false, topic: .basics),
    IDQAnswer(text: "UserDefaults are a simple key-value store that allows an application to store and retrieve small pieces of data in the form of key-value pairs.", isCorrect: true, topic: .basics),
]
