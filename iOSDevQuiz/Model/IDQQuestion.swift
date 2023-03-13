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
    IDQQuestion(question: "What is a Tuple in Swift?", hint: "duck", difficulty: .medium, topic: .basics, answers: [idqAnswerList[4], idqAnswerList[5], idqAnswerList[6], idqAnswerList[7]]),
    IDQQuestion(question: "What does the Codable protocol do?", hint: "duck", difficulty: .medium, topic: .basics, answers: [idqAnswerList[8], idqAnswerList[9], idqAnswerList[10], idqAnswerList[11]]),
    IDQQuestion(question: "What are enums used for?", hint: "duck", difficulty: .easy, topic: .basics, answers: [idqAnswerList[12], idqAnswerList[13], idqAnswerList[14], idqAnswerList[15]]),
    IDQQuestion(question: "What are UserDefaults?", hint: "duck", difficulty: .easy, topic: .basics, answers: [idqAnswerList[16], idqAnswerList[17], idqAnswerList[18], idqAnswerList[19]]),
    IDQQuestion(question: "What is the difference between an Array and a Set?", hint: "duck", difficulty: .medium, topic: .basics, answers: [idqAnswerList[20], idqAnswerList[21], idqAnswerList[22], idqAnswerList[23]]),
    IDQQuestion(question: "What is the difference between a Float and a Double?", hint: "duck", difficulty: .easy, topic: .basics, answers: [idqAnswerList[24], idqAnswerList[25], idqAnswerList[26], idqAnswerList[27]]),
    IDQQuestion(question: "Which of the following methods is executed first in the AppDelegate before the others?", hint: "duck", difficulty: .easy, topic: .basics, answers: [idqAnswerList[28], idqAnswerList[29], idqAnswerList[30], idqAnswerList[31]]),
    IDQQuestion(question: "What is @frozen stands for in Swift?", hint: "duck", difficulty: .hard, topic: .basics, answers: [idqAnswerList[32], idqAnswerList[33], idqAnswerList[34], idqAnswerList[35]]),
    IDQQuestion(question: "To which of these protocols does NOT conform to a String?", hint: "duck", difficulty: .medium, topic: .basics, answers: [idqAnswerList[36], idqAnswerList[37], idqAnswerList[38], idqAnswerList[39]]), //10
    
    
    
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
    IDQAnswer(text: "A protocol that provides a standardized way to decode objects from JSON.", isCorrect: false, topic: .basics),
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
    
    //6 What is the difference between an array and a set?
    IDQAnswer(text: "An Array is a collection of elements that can be of different data types, while a Set can only contain elements of the same data type.", isCorrect: false, topic: .basics),
    IDQAnswer(text: "An Array is a dynamic collection of elements, you can add and remove elements from it as needed. A Set is a static collection of elements and cannot be modified.", isCorrect: false, topic: .basics),
    IDQAnswer(text: "A Set can only store two elements, while an Array can store an unlimited number of elements.", isCorrect: false, topic: .basics),
    IDQAnswer(text: "An array is a collection of elements that can contain duplicates and are ordered, while a set is an unordered collection of unique elements with no duplicates.", isCorrect: true, topic: .basics),
    
    //What is the difference between a Float and a Double?
    IDQAnswer(text: "A Float is a data type that can only store positive numbers, while a Double can store both positive and negative numbers.", isCorrect: false, topic: .basics),
    IDQAnswer(text: "Both the Float and the Double data types are double-precision floating-point numbers but Doubles usually require more memory to store them.", isCorrect: false, topic: .basics),
    IDQAnswer(text: "They are different types but identical in every way.", isCorrect: false, topic: .basics),
    IDQAnswer(text: "A Float is a data type that uses 32 bits of memory while a Double uses 64 bits of memory.", isCorrect: true, topic: .basics),
    
    //Which of the following methods is executed first in the AppDelegate?
    IDQAnswer(text: "applicationDidBecomeActive", isCorrect: false, topic: .basics),
    IDQAnswer(text: "application: willFinishLaunchingWithOptions: ", isCorrect: false, topic: .basics),
    IDQAnswer(text: "sceneDidBecomeActive", isCorrect: false, topic: .basics),
    IDQAnswer(text: "application: didFinishLaunchingWithOptions: ", isCorrect: true, topic: .basics),
    
    //What is @frozen stands for in Swift?
    IDQAnswer(text: "@frozen is a way to mark a function in Swift as being thread-safe and able to be called concurrently from multiple threads.", isCorrect: false, topic: .basics),
    IDQAnswer(text: "@frozen is an attribute that can be applied to classes in Swift, indicating that the class is immutable and cannot be extended in the future.", isCorrect: false, topic: .basics),
    IDQAnswer(text: "The @frozen attribute prevents the app from executing the function it is applied to more than once per app launch", isCorrect: false, topic: .basics),
    IDQAnswer(text: " is an attribute in Swift that indicates that the annotated type or member is immutable and cannot be extended or modified in the future.", isCorrect: true, topic: .basics),
    
    //To which of these protocols does NOT conform to a String?
    IDQAnswer(text: "Equatable", isCorrect: false, topic: .basics),
    IDQAnswer(text: "Collection", isCorrect: false, topic: .basics),
    IDQAnswer(text: "Hashable", isCorrect: false, topic: .basics),
    IDQAnswer(text: "It conforms to all of the above", isCorrect: true, topic: .basics),
    
]
