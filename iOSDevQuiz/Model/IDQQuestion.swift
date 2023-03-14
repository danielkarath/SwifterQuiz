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
    IDQQuestion(question: "What does @frozen attribute stand for?", hint: "duck", difficulty: .hard, topic: .basics, answers: [idqAnswerList[32], idqAnswerList[33], idqAnswerList[34], idqAnswerList[35]]),
    IDQQuestion(question: "To which of these protocols does NOT conform to a String?", hint: "duck", difficulty: .medium, topic: .basics, answers: [idqAnswerList[36], idqAnswerList[37], idqAnswerList[38], idqAnswerList[39]]), //10
    
    IDQQuestion(question: "What is a UUID?", hint: "duck", difficulty: .easy, topic: .basics, answers: [idqAnswerList[40], idqAnswerList[41], idqAnswerList[42], idqAnswerList[43]]),
    IDQQuestion(question: "What is the lazy property in Swift?", hint: "duck", difficulty: .medium, topic: .basics, answers: [idqAnswerList[44], idqAnswerList[45], idqAnswerList[46], idqAnswerList[47]]),
    IDQQuestion(question: "You can add an element to an array in Swift by using __________", hint: "duck", difficulty: .easy, topic: .basics, answers: [idqAnswerList[48], idqAnswerList[49], idqAnswerList[50], idqAnswerList[51]]),
    IDQQuestion(question: "The zip() function in Swift is used to __________", hint: "duck", difficulty: .medium, topic: .basics, answers: [idqAnswerList[52], idqAnswerList[53], idqAnswerList[54], idqAnswerList[55]]),
    IDQQuestion(question: "When would you use Swift’s Result type?", hint: "duck", difficulty: .medium, topic: .basics, answers: [idqAnswerList[56], idqAnswerList[57], idqAnswerList[58], idqAnswerList[59]]),
    IDQQuestion(question: "The guard statement in Swift is __________", hint: "duck", difficulty: .easy, topic: .basics, answers: [idqAnswerList[60], idqAnswerList[61], idqAnswerList[62], idqAnswerList[63]]),
    IDQQuestion(question: "What is a delegate in Swift?", hint: "duck", difficulty: .easy, topic: .designPatterns, answers: [idqAnswerList[64], idqAnswerList[65], idqAnswerList[66], idqAnswerList[67]]),
    IDQQuestion(question: "What are the advatages of the notification design pattern over the delegate pattern?", hint: "duck", difficulty: .easy, topic: .designPatterns, answers: [idqAnswerList[68], idqAnswerList[69], idqAnswerList[70], idqAnswerList[71]]),
    IDQQuestion(question: "With the __________ observers can be registered and unregistered dynamically at runtime without modifying the code of the notifying object.", hint: "duck", difficulty: .medium, topic: .designPatterns, answers: [idqAnswerList[72], idqAnswerList[73], idqAnswerList[74], idqAnswerList[75]]),
    IDQQuestion(question: "What is the acronym KVO stands for in iOS development?", hint: "duck", difficulty: .easy, topic: .designPatterns, answers: [idqAnswerList[76], idqAnswerList[77], idqAnswerList[78], idqAnswerList[79]]),
    
    
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
    IDQAnswer(text: "Defines methods for converting an object to and from a binary format.", isCorrect: false, topic: .basics),
    IDQAnswer(text: "Provides methods for performing cryptographic operations.", isCorrect: false, topic: .basics),
    IDQAnswer(text: "Provides a standardized way to decode objects from JSON.", isCorrect: false, topic: .basics),
    IDQAnswer(text: "Provides a standardized way to encode and decode objects to and from JSON, or other data formats.", isCorrect: true, topic: .basics),
    
    //4 "What are enums used for?"
    IDQAnswer(text: "Enums are a tool to debug errors in Swift programming language.", isCorrect: false, topic: .basics),
    IDQAnswer(text: "Enums are a type of array used to store multiple values of the same type.", isCorrect: false, topic: .basics),
    IDQAnswer(text: "A collection type that can store multiple values of the same type in an ordered list.", isCorrect: false, topic: .basics),
    IDQAnswer(text: "Enums are a way to define a group of related values in Swift.", isCorrect: true, topic: .basics),
    
    //5 What are UserDefaults?
    IDQAnswer(text: "A set of built-in methods that can be used to manipulate user interface elements.", isCorrect: false, topic: .basics),
    IDQAnswer(text: "A type of in-memory cache that can be used to store frequently accessed data to improve the application's performance.", isCorrect: false, topic: .basics),
    IDQAnswer(text: "Data structures to store and retrieve large amounts of data in a key-value format.", isCorrect: false, topic: .basics),
    IDQAnswer(text: "A simple key-value store that allows the application to store and retrieve small pieces of data.", isCorrect: true, topic: .basics),
    
    //6 What is the difference between an array and a set?
    IDQAnswer(text: "An Array is a collection of elements that can be of different data types. A Set can only contain elements of the same data type.", isCorrect: false, topic: .basics),
    IDQAnswer(text: "An Array is a dynamic collection of elements, while a Set is static and immutable.", isCorrect: false, topic: .basics),
    IDQAnswer(text: "A Set can only store two elements, while an Array can store an unlimited number of elements.", isCorrect: false, topic: .basics),
    IDQAnswer(text: "An Array is a collection of elements that can contain duplicates and are ordered, while a Set is an unordered collection of unique elements", isCorrect: true, topic: .basics),
    
    //What is the difference between a Float and a Double?
    IDQAnswer(text: "A Float is a data type that can only store positive numbers.", isCorrect: false, topic: .basics),
    IDQAnswer(text: "Float is a one-precision while Dpuble is a double-precision floating point number.", isCorrect: false, topic: .basics),
    IDQAnswer(text: "Float had been depricated in iOS 7.", isCorrect: false, topic: .basics),
    IDQAnswer(text: "A Float is a data type that uses 32 bits of memory while a Double uses 64 bits of memory.", isCorrect: true, topic: .basics),
    
    //Which of the following methods is executed first in the AppDelegate?
    IDQAnswer(text: "applicationDidBecomeActive ", isCorrect: false, topic: .basics),
    IDQAnswer(text: "didFinishLaunchingWithOptions: ", isCorrect: false, topic: .basics),
    IDQAnswer(text: "sceneDidBecomeActive ", isCorrect: false, topic: .basics),
    IDQAnswer(text: "willFinishLaunchingWithOptions: ", isCorrect: true, topic: .basics),
    
    //What does @frozen attribute stand for?
    IDQAnswer(text: "The @frozen attribute grants a public getter but private setter to the object it's applied to", isCorrect: false, topic: .basics),
    IDQAnswer(text: "There is no @frozen attribute in Swift", isCorrect: false, topic: .basics),
    IDQAnswer(text: "It prevents the app from executing the function it's applied to more than once per app launch", isCorrect: false, topic: .basics),
    IDQAnswer(text: "It indicates that the annotated type or member is immutable.", isCorrect: true, topic: .basics),
    
    //To which of these protocols does NOT conform to a String?
    IDQAnswer(text: "Equatable ", isCorrect: false, topic: .basics),
    IDQAnswer(text: "Collection ", isCorrect: false, topic: .basics),
    IDQAnswer(text: "Hashable ", isCorrect: false, topic: .basics),
    IDQAnswer(text: "It conforms to all of the listed protocols", isCorrect: true, topic: .basics),
    
    
    
    //What is a UUID?
    IDQAnswer(text: "A function to encode and decode Unicode characters.", isCorrect: false, topic: .basics),
    IDQAnswer(text: "A UUID is a data type used for storing GPS coordinates.", isCorrect: false, topic: .basics),
    IDQAnswer(text: "A unique 256-bit value that provides identifiable data about an iCloud user.", isCorrect: false, topic: .basics),
    IDQAnswer(text: "A unique 128-bit value that is used to identify information in a unique and standardized way.", isCorrect: true, topic: .basics),
    
    //What is the lazy property in Swift?
    IDQAnswer(text: "It's a property that is only accessible within the scope of a particular function or method.", isCorrect: false, topic: .basics),
    IDQAnswer(text: "A property that is automatically deallocated from memory when it is no longer needed.", isCorrect: false, topic: .basics),
    IDQAnswer(text: "There is no lazy property in Swift", isCorrect: false, topic: .basics),
    IDQAnswer(text: "It's a property that is only initialized when it is accessed for the first time.", isCorrect: true, topic: .basics),
    
    //You can add an element to an array in Swift by using __________
    IDQAnswer(text: "the append(_: at:) method to add the new element to a specific index.", isCorrect: false, topic: .basics),
    IDQAnswer(text: "the addElement(_:) method to add the new element to the beginning of the array.", isCorrect: false, topic: .basics),
    IDQAnswer(text: "the append(_:) method to add the new element to the beginning of the array.", isCorrect: false, topic: .basics),
    IDQAnswer(text: "the insert(_: at:) method to insert the new element at a specific index.", isCorrect: true, topic: .basics),
    
    //The zip() function in Swift is used to __________
    IDQAnswer(text: "compress data into a smaller size before transmitting it over a network.", isCorrect: false, topic: .basics),
    IDQAnswer(text: "convert an array of strings into an array of integers, by mapping each string to its corresponding ASCII code.", isCorrect: false, topic: .basics),
    IDQAnswer(text: "extract files from a compressed archive.", isCorrect: false, topic: .basics),
    IDQAnswer(text: "combine two arrays into a single array of tuples, where each tuple contains one element from each of the input arrays at the same index.", isCorrect: true, topic: .basics),
    
    //When would you use Swift’s Result type?
    IDQAnswer(text: "The Result type is returned by the Core ML framework's removeCheckpoints(_:) at the end of an MLTrainingSession.", isCorrect: false, topic: .basics),
    IDQAnswer(text: "It indicates the status of an operation that can return a success or a failure, or an unknown Result type.", isCorrect: false, topic: .basics),
    IDQAnswer(text: "It's used to manage concurrency and synchronization in multi-threaded programs.", isCorrect: false, topic: .basics),
    IDQAnswer(text: "It's used to indicate the outcome of a function or method that can either succeed or fail.", isCorrect: true, topic: .basics),
    
    //The guard statement in Swift is __________
    IDQAnswer(text: "a method that is used to encrypt data.", isCorrect: false, topic: .basics),
    IDQAnswer(text: "a type of loop that repeats a block of code until a condition is met.", isCorrect: false, topic: .basics),
    IDQAnswer(text: "A control flow statement that is always executed first in it's function or method.", isCorrect: false, topic: .basics),
    IDQAnswer(text: "A control flow statement that is used to exit early from a function, method, or loop if a condition isn't met.", isCorrect: true, topic: .basics),
    
    //What is a delegate in Swift?
    IDQAnswer(text: "A delegate in Swift is a data structure that allows for the efficient storage and retrieval of key-value pairs.", isCorrect: false, topic: .designPatterns),
    IDQAnswer(text: "The delegate is an object that broadcasts information to other objects without having to know about them directly. ", isCorrect: false, topic: .designPatterns),
    IDQAnswer(text: "A delegate is handled for a specific task by an other object called the delegator. Think of a delegate as a boss and a delegator as an employee.", isCorrect: false, topic: .designPatterns),
    IDQAnswer(text: "A delegate is an object that is responsible for handling specific tasks on behalf of another object, called the delegator. Think of a delegator as a boss and a delegate as an employee.", isCorrect: true, topic: .designPatterns),
    
    //What are the advatages of the notification design pattern over the delegate pattern?
    IDQAnswer(text: "The notification pattern allows direct control over who receives the notifications while the delegate pattern does not.", isCorrect: false, topic: .designPatterns),
    IDQAnswer(text: "The notification pattern is generally more efficient then the delegate pattern as it involves fewer objects.", isCorrect: false, topic: .designPatterns),
    IDQAnswer(text: "The delegate pattern is in every way superior to the notification pattern", isCorrect: false, topic: .designPatterns),
    IDQAnswer(text: "Notifications can have multiple observers, which allows for more flexibility", isCorrect: true, topic: .designPatterns),
    
    //With the __________ observers can be registered and unregistered dynamically at runtime without modifying the code of the notifying object.
    IDQAnswer(text: "delegate pattern", isCorrect: false, topic: .designPatterns),
    IDQAnswer(text: "key-value observing pattern", isCorrect: false, topic: .designPatterns),
    IDQAnswer(text: "notification pattern", isCorrect: false, topic: .designPatterns),
    IDQAnswer(text: "notification and KVO patterns", isCorrect: true, topic: .designPatterns),
    
    //What is the acronym KVO stands for in iOS development?
    IDQAnswer(text: "Key-View Object", isCorrect: false, topic: .designPatterns),
    IDQAnswer(text: "Key-View Observer", isCorrect: false, topic: .designPatterns),
    IDQAnswer(text: "Key-Value Object", isCorrect: false, topic: .designPatterns),
    IDQAnswer(text: "Key-Value Observing", isCorrect: true, topic: .designPatterns),
]
