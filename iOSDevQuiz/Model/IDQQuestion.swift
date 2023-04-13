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
    let explanation: String
    let reference: String?
    let difficulty: IDQQuestionDifficulty
    let topic: IDQTopic
    let answers: [IDQAnswer]
}

let idqQuestionList: [IDQQuestion] = [
    
    //MARK: - Basics

    IDQQuestion(
        question: "The creation of a data object to a specific state or value is called __________.",
        explanation: "Initialization is the creation of a data object.",
        reference: "https://en.wikipedia.org/wiki/Initialization_(programming)",
        difficulty: .easy,
        topic: .basics,
        answers: [
            IDQAnswer(text: "version control", answerType: .wrong),
            IDQAnswer(text: "refactoring", answerType: .wrong),
            IDQAnswer(text: "inheritance", answerType: .wrong ),
            IDQAnswer(text: "initialization", answerType: .correct),
        ]
    ),

    IDQQuestion(
        question: "What is the logical 'or' operator in Swift?",
        explanation: "The logical OR operator is || in Swift",
        reference: "https://developer.apple.com/documentation/swift/operator-declarations",
        difficulty: .easy,
        topic: .basics,
        answers: [
            IDQAnswer(text: "??", answerType: .wrong),
            IDQAnswer(text: "OR", answerType: .wrong),
            IDQAnswer(text: "or", answerType: .wrong ),
            IDQAnswer(text: "||", answerType: .correct),
        ]
    ),

    IDQQuestion(
        question: "What do we use the ternary operator for?",
        explanation: "condition ? valueIfTrue : valueIfFalse",
        reference: "https://developer.apple.com/documentation/swift/operator-declarations",
        difficulty: .easy,
        topic: .basics,
        answers: [
            IDQAnswer(text: "To unwrap optionals safely.", answerType: .wrong),
            IDQAnswer(text: "To manage multiple async tasks.", answerType: .wrong),
            IDQAnswer(text: "To ensure that certain conditions are met before executing the rest of the code in a function or method.", answerType: .wrong ),
            IDQAnswer(text: "It allows you to write a concise expression to choose one of two values based on a condition.", answerType: .correct),
        ]
    ),

    IDQQuestion(
        question: "The __________ type represents a character made up of one (or more) Unicode scalar values.",
        explanation: "The Character represents a single extended grapheme cluster, which is a sequence of one or more Unicode scalars that produce a single human-readable letter or symbol.",
        reference: "https://developer.apple.com/documentation/swift/character",
        difficulty: .easy,
        topic: .basics,
        answers: [
            IDQAnswer(text: "UInt \t", answerType: .wrong),
            IDQAnswer(text: "AnyObject \t", answerType: .wrong),
            IDQAnswer(text: "String \t", answerType: .wrong ),
            IDQAnswer(text: "Character \t", answerType: .correct),
        ]
    ),

    IDQQuestion(
        question: "A #selector expression is used to refer to __________",
        explanation: "A selector expression lets you access the selector used to refer to a method or to a property’s getter or setter in Objective-C.",
        reference: "https://docs.swift.org/swift-book/documentation/the-swift-programming-language/expressions/#Selector-Expression",
        difficulty: .easy,
        topic: .basics,
        answers: [
            IDQAnswer(text: "an object exposed to Swift or Objective-C.", answerType: .wrong),
            IDQAnswer(text: "an object exposed to Objective-C.", answerType: .wrong),
            IDQAnswer(text: "a method exposed to Swift or Objective-C.", answerType: .wrong ),
            IDQAnswer(text: "a method exposed to Objective-C.", answerType: .correct),
        ]
    ),

    IDQQuestion(
        question: "What is the difference between Any and AnyObject?",
        explanation: "Any is a protocol that represents any type at all, including class types, struct types, enum types, and protocol types.. AnyObject is a protocol that represents any instance of a class type.",
        reference: "https://developer.apple.com/documentation/swift/anyobject",
        difficulty: .medium,
        topic: .basics,
        answers: [
            IDQAnswer(text: " Any can represent any instance of a class.\n AnyObject can represent any type including value types.", answerType: .wrong),
            IDQAnswer(text: " Any can only represent value types.\n AnyObject can represent any instance of a class.", answerType: .wrong),
            IDQAnswer(text: " Any represents class types, AnyObject represents struct.", answerType: .wrong ),
            IDQAnswer(text: " Any can represent any type including value types.\n AnyObject can represent any instance of a class.", answerType: .correct),
        ]
    ),

    IDQQuestion(
        question: "What is type annotation?",
        explanation: "A type annotation explicitly specifies the type of a variable or expression.\nExample: let size: CGFloat = 10.0",
        reference: "https://docs.swift.org/swift-book/documentation/the-swift-programming-language/types/#Type-Annotation",
        difficulty: .easy,
        topic: .basics,
        answers: [
            IDQAnswer(text: "The creation of an optional type data object", answerType: .wrong),
            IDQAnswer(text: "Creating new types by combining existing types.", answerType: .wrong),
            IDQAnswer(text: "Automatically inferring the type of a variable or function parameter.", answerType: .wrong ),
            IDQAnswer(text: "Explicitly specifying the type of a variable or function parameter.", answerType: .correct),
        ]
    ),

    IDQQuestion(
        question: "How can you create a multi-line String object in Swift?",
        explanation: "The Character type represents a character made up of one or more Unicode scalar values, grouped by a Unicode boundary algorithm.",
        reference: "https://docs.swift.org/swift-book/documentation/the-swift-programming-language/stringsandcharacters/#Multiline-String-Literals",
        difficulty: .medium,
        topic: .basics,
        answers: [
            IDQAnswer(text: "By the combination of a backslash and an asterisk,", answerType: .wrong),
            IDQAnswer(text: "By using the backslash character at the end of each line,", answerType: .wrong),
            IDQAnswer(text: "By separating each line with a semicolon", answerType: .wrong ),
            IDQAnswer(text: "By enclosing the string in triple quotes", answerType: .correct),
        ]
    ),

    IDQQuestion(
        question: "What is the method deinit() used for?",
        explanation: "A deinitializer is called immediately before a class instance is deallocated.",
        reference: "https://docs.swift.org/swift-book/documentation/the-swift-programming-language/deinitialization/",
        difficulty: .medium,
        topic: .basics,
        answers: [
            IDQAnswer(text: "deinit() is called to create a new instance of a particular type", answerType: .wrong),
            IDQAnswer(text: "The deinit() is called to unconditionally stop execution.", answerType: .wrong),
            IDQAnswer(text: "The deinit() method is called on the app delegate when the app is about to move from the active to inactive state.", answerType: .wrong),
            IDQAnswer(text: "The deinit() is called immediately before a class instance is deallocated.", answerType: .correct),
        ]
    ),

    IDQQuestion(
        question: "What is a Tuple in Swift?",
        explanation: "A tuple type is a comma-separated list of types, that can be of different types and is enclosed in parentheses.",
        reference: "https://docs.swift.org/swift-book/documentation/the-swift-programming-language/types/#Tuple-Type",
        difficulty: .easy,
        topic: .basics,
        answers: [
            IDQAnswer(text: "A control flow statement that allows you to break out of a loop or switch statement.", answerType: .wrong),
            IDQAnswer(text: "A collection type that can store multiple values of the same type in an ordered list.", answerType: .wrong),
            IDQAnswer(text: "A Tuple is collection of values of either Int, String or Bool types", answerType: .wrong),
            IDQAnswer(text: "A Tuple is a collection of values of any type, which can be of different types.", answerType: .correct),
        ]
    ),

    IDQQuestion(
        question: "What does the Codable protocol do?",
        explanation: "It's a combination of Decodable and Encodable. With it you can convert objects to and from a serialized format, such as JSON, that can be easily transmitted or stored.",
        reference: "https://developer.apple.com/documentation/swift/codable",
        difficulty: .medium,
        topic: .basics,
        answers: [
            IDQAnswer(text: "It defines methods for converting an object to and from a binary format.", answerType: .wrong),
            IDQAnswer(text: "It provides methods for performing cryptographic operations.", answerType: .wrong),
            IDQAnswer(text: "It provides a standardized way to decode objects from JSON.", answerType: .wrong),
            IDQAnswer(text: "It provides a standardized way to encode and decode objects to and from JSON, or other data formats.", answerType: .correct),
        ]
    ),

    IDQQuestion(
        question: "What are enums in Swift?",
        explanation: "Enum stands for enumeration, and it defines a common type for a group of related values",
        reference: "https://docs.swift.org/swift-book/documentation/the-swift-programming-language/enumerations/",
        difficulty: .easy,
        topic: .basics,
        answers: [
            IDQAnswer(text: "Enums are a tool to debug errors.", answerType: .wrong),
            IDQAnswer(text: "A type of array used to store multiple values of the same type.", answerType: .wrong),
            IDQAnswer(text: "A collection type that can store multiple values of the same type in an ordered list.", answerType: .wrong),
            IDQAnswer(text: "Enums are a way to define a group of related values.", answerType: .correct),
        ]
    ),


    IDQQuestion(
        question: "What are UserDefaults?",
        explanation: "An interface to the user’s defaults database, where you store key-value pairs persistently across launches of your app.",
        reference: "https://developer.apple.com/documentation/foundation/userdefaults",
        difficulty: .easy,
        topic: .basics,
        answers: [
            IDQAnswer(text: "A set of built-in methods that can be used to manipulate user interface elements.", answerType: .wrong),
            IDQAnswer(text: "A type of in-memory cache that can be used to store frequently accessed data to improve the application's performance.", answerType: .wrong),
            IDQAnswer(text: "Data structures to store and retrieve large amounts of data in a key-value format.", answerType: .wrong),
            IDQAnswer(text: "A simple key-value store that allows the application to store and retrieve small pieces of data.", answerType: .correct),
        ]
    ),

    IDQQuestion(
        question: "what is an associated type?",
        explanation: "An associated type gives a placeholder name to a type that’s used as part of the protocol.",
        reference: "https://docs.swift.org/swift-book/documentation/the-swift-programming-language/generics/#Associated-Types",
        difficulty: .hard,
        topic: .basics,
        answers: [
            IDQAnswer(text: "It's used to hide a return values type.", answerType: .wrong),
            IDQAnswer(text: "It's used to create an alias or alternative name for an existing type.", answerType: .wrong),
            IDQAnswer(text: "It's used to define enums in Swift.", answerType: .wrong),
            IDQAnswer(text: "It's used to define placeholder type used in a protocol.", answerType: .correct),
        ]
    ),

    IDQQuestion(
        question: "what is an opaque type?",
        explanation: "An opaque type is a way to hide the underlying implementation details of a type",
        reference: "https://docs.swift.org/swift-book/documentation/the-swift-programming-language/opaquetypes",
        difficulty: .hard,
        topic: .basics,
        answers: [
            IDQAnswer(text: "There is no opaque type in Swift.", answerType: .wrong),
            IDQAnswer(text: "It's used to create an alias or alternative name for an existing type.", answerType: .wrong),
            IDQAnswer(text: "It refers to the type of any type, including class types, structure types, enumeration types, and protocol types.", answerType: .wrong),
            IDQAnswer(text: "A function or method with an opaque type hides its return value’s type information.", answerType: .correct),
        ]
    ),

    IDQQuestion(
        question: "What is the difference between an Array and a Set?",
        explanation: "A Set is unordered collection of unique elements. An Array is an ordered random-access collection.",
        reference: "https://developer.apple.com/documentation/swift/set",
        difficulty: .medium,
        topic: .basics,
        answers: [
            IDQAnswer(text: "An Array is a collection of elements that can be of different data types. A Set can only contain elements of the same data type.", answerType: .wrong),
            IDQAnswer(text: "An Array is a dynamic collection of elements, while a Set is static and immutable.", answerType: .wrong),
            IDQAnswer(text: "A Set can only store two elements, while an Array can store an unlimited number of elements.", answerType: .wrong),
            IDQAnswer(text: "An Array is a collection of elements that can contain duplicates and are ordered, while a Set is an unordered collection of unique elements", answerType: .correct),
        ]
    ),

    IDQQuestion(
        question: "What is the difference between a Float and a Double?",
        explanation: "Double represents a 64-bit floating-point number while a Float represents a 32-bit floating-point number.",
        reference: "https://docs.swift.org/swift-book/documentation/the-swift-programming-language/thebasics/#Floating-Point-Numbers",
        difficulty: .easy,
        topic: .basics,
        answers: [
            IDQAnswer(text: "A Float is a data type that can only store positive numbers.", answerType: .wrong),
            IDQAnswer(text: "Float is a one-precision while Dpuble is a double-precision floating point number.", answerType: .wrong),
            IDQAnswer(text: "Both are floating-point numbers, but Float had been depricated in iOS 7.", answerType: .wrong),
            IDQAnswer(text: "A Float uses 32 bits while a Double uses 64 bits of memory.", answerType: .correct)
        ]
    ),

    IDQQuestion(
        question: "Which of the following methods is executed first in the AppDelegate before the others?",
        explanation: "The application(_:willFinishLaunchingWithOptions:) tells the delegate that the launch process has begun but that state restoration hasn’t occured.",
        reference: "https://developer.apple.com/documentation/uikit/app_and_environment/responding_to_the_launch_of_your_app",
        difficulty: .easy,
        topic: .basics,
        answers: [
            IDQAnswer(text: "applicationDidBecomeActive(_:) \t", answerType: .wrong),
            IDQAnswer(text: "application(_: didFinishLaunchingWithOptions:) \t", answerType: .wrong),
            IDQAnswer(text: "sceneDidBecomeActive(_:) \t", answerType: .wrong),
            IDQAnswer(text: "application(_: willFinishLaunchingWithOptions:) \t", answerType: .correct),
        ]
    ),


    IDQQuestion(
        question: "What does @frozen attribute stand for?",
        explanation: "Apply this attribute to a structure or enumeration declaration to restrict the kinds of changes you can make to the type.",
        reference: "https://docs.swift.org/swift-book/documentation/the-swift-programming-language/attributes/#frozen",
        difficulty: .hard,
        topic: .basics,
        answers: [
            IDQAnswer(text: "It grants a public getter but private setter to the object it's applied to", answerType: .wrong),
            IDQAnswer(text: "There is no @frozen attribute in Swift", answerType: .wrong),
            IDQAnswer(text: "It prevents the app from executing the function it's applied to more than once per app launch", answerType: .wrong),
            IDQAnswer(text: "It indicates that the annotated type or member is immutable.", answerType: .correct),
        ]
    ),


    IDQQuestion(
        question: "StringProtocol conforms to which of these protocols?",
        explanation: "StringProtocol conforms to: BidirectionalCollection, Comparable, ExpressibleByStringInterpolation, Hashable, LosslessStringConvertible, TextOutputStream, TextOutputStreamable",
        reference: "https://developer.apple.com/documentation/swift/stringprotocol",
        difficulty: .medium,
        topic: .basics,
        answers: [
            IDQAnswer(text: "Comparable \t", answerType: .wrong),
            IDQAnswer(text: "TextOutputStreamable \t", answerType: .wrong),
            IDQAnswer(text: "Hashable \t", answerType: .wrong),
            IDQAnswer(text: "It conforms to all of the listed protocols", answerType: .correct),
        ]
    ),


    IDQQuestion(
        question: "What is a UUID?",
        explanation: "A universally unique value to identify types, interfaces, and other items.",
        reference: "https://developer.apple.com/documentation/foundation/uuid",
        difficulty: .easy,
        topic: .basics,
        answers: [
            IDQAnswer(text: "A function to encode and decode Unicode characters.", answerType: .wrong),
            IDQAnswer(text: "A data type used for storing GPS coordinates.", answerType: .wrong),
            IDQAnswer(text: "A unique 256-bit value that provides identifiable data about an iCloud user.", answerType: .wrong),
            IDQAnswer(text: "A unique 128-bit value that is used to identify information in a unique and standardized way.", answerType: .correct),
        ]
    ),

    IDQQuestion(
        question: "What is the lazy property in Swift?",
        explanation: "A lazy stored property is a property whose initial value isn’t calculated until the first time it’s used.",
        reference: "https://docs.swift.org/swift-book/documentation/the-swift-programming-language/properties/#Lazy-Stored-Properties",
        difficulty: .medium,
        topic: .basics,
        answers: [
            IDQAnswer(text: "It's a property that is only accessible within the scope of a particular function or method.", answerType: .wrong),
            IDQAnswer(text: "A property that is automatically deallocated from memory when it is no longer needed.", answerType: .wrong),
            IDQAnswer(text: "There is no lazy property in Swift", answerType: .wrong),
            IDQAnswer(text: "It's a property that is only initialized when it is accessed for the first time.", answerType: .correct),
        ]
    ),

    IDQQuestion(
        question: "You can add an element to a specific index of an array by using __________ method",
        explanation: "The append(_:) method adds a new element to the end of the Array and the insert(_: at: ) adds a new element to a specific index.",
        reference: "https://developer.apple.com/documentation/swift/array/insert(_:at:)-3erb3",
        difficulty: .easy,
        topic: .basics,
        answers: [
            IDQAnswer(text: "the append(_:at:) \n", answerType: .wrong),
            IDQAnswer(text: "the addElement(_:) \n", answerType: .wrong),
            IDQAnswer(text: "the append(_:) \n", answerType: .wrong),
            IDQAnswer(text: "the insert(_:at:) \n", answerType: .correct),
        ]
    ),

    IDQQuestion(
        question: "The zip() method in Swift is used to __________",
        explanation: "The zip() method combines two arrays into a single array of tuples, where each tuple contains one element from each of the input arrays at the same index.",
        reference: "https://developer.apple.com/documentation/swift/zip(_:_:)",
        difficulty: .medium,
        topic: .basics,
        answers: [
            IDQAnswer(text: "compress data into a smaller size before transmitting it over a network.", answerType: .wrong),
            IDQAnswer(text: "convert an array of strings into an array of integers, by mapping each string to its corresponding ASCII code.", answerType: .wrong),
            IDQAnswer(text: "extract files from a compressed archive.", answerType: .wrong),
            IDQAnswer(text: "merge two sequences into a single sequence of tuples.", answerType: .correct),
        ]
    ),

    IDQQuestion(
        question: "When would you use Swift’s Result type?",
        explanation: "A value that represents either a success or a failure, including an associated value in each case.",
        reference: "https://developer.apple.com/documentation/swift/result",
        difficulty: .medium,
        topic: .basics,
        answers: [
            IDQAnswer(text: "The Result type is returned by the Core ML framework's removeCheckpoints(_:) at the end of an MLTrainingSession.", answerType: .wrong),
            IDQAnswer(text: "It indicates the status of an operation that can return a success or a failure, or an unknown Result type.", answerType: .wrong),
            IDQAnswer(text: "It's used to manage concurrency and synchronization in multi-threaded programs.", answerType: .wrong),
            IDQAnswer(text: "It's used to indicate the outcome of a function or method that can either succeed or fail.", answerType: .correct),
        ]
    ),

    IDQQuestion(
        question: "The guard statement is __________",
        explanation: "With the guard statement we can implement checks into our code that prevents the current scope from continuing if certain conditions are not met.",
        reference: "https://docs.swift.org/swift-book/documentation/the-swift-programming-language/statements/#Guard-Statement",
        difficulty: .easy,
        topic: .basics,
        answers: [
            IDQAnswer(text: "a method that is used to encrypt data.", answerType: .wrong),
            IDQAnswer(text: "a type of loop that repeats a block of code until a condition is met.", answerType: .wrong),
            IDQAnswer(text: "A control flow statement that is always executed first in it's function or method.", answerType: .wrong),
            IDQAnswer(text: "A control flow statement that is used to exit early from a function, method or loop if a condition isn't met.", answerType: .correct),
        ]
    ),

    IDQQuestion(
        question: "What is a delegate in Swift?",
        explanation: "Delegation is a design pattern that enables a class or structure to hand off (or delegate) some of its responsibilities to an instance of another type. Think of a delegator as a boss and a delegate as an employee.",
        reference: "https://docs.swift.org/swift-book/documentation/the-swift-programming-language/protocols/#Delegation",
        difficulty: .easy,
        topic: .basics,
        answers: [
            IDQAnswer(text: "A data structure that allows for the efficient storage and retrieval of key-value pairs.", answerType: .wrong),
            IDQAnswer(text: "An object that broadcasts information to other objects without having to know about them directly.", answerType: .wrong),
            IDQAnswer(text: "A delegator is an object that is responsible for handling specific tasks on behalf of another object, called the delegate.", answerType: .wrong),
            IDQAnswer(text: "A delegate is an object that is responsible for handling specific tasks on behalf of another object, called the delegator.", answerType: .correct),
        ]
    ),

    IDQQuestion(
        question: "What are the advatages of the notification design pattern over the delegate pattern?",
        explanation: "Notifications can have multiple observers, they are flexible and notifications are delivered asynchronously.",
        reference: nil,
        difficulty: .easy,
        topic: .basics,
        answers: [
            IDQAnswer(text: "The notification pattern allows direct control over who receives the notifications.", answerType: .wrong),
            IDQAnswer(text: "The notification pattern is generally more efficient then the delegate pattern.", answerType: .wrong),
            IDQAnswer(text: "The delegate pattern is in every way superior to the notification pattern", answerType: .wrong),
            IDQAnswer(text: "Notifications can have multiple observers, which allows for more flexibility", answerType: .correct),
        ]
    ),

    IDQQuestion(
        question: "With the __________ observers can be registered and unregistered dynamically at runtime without modifying the code of the notifying object.",
        explanation: "Both the notification pattern and key-value observing pattern is capable of it.",
        reference: nil,
        difficulty: .medium,
        topic: .basics,
        answers: [
            IDQAnswer(text: "delegate pattern", answerType: .wrong),
            IDQAnswer(text: "key-value observing pattern", answerType: .wrong),
            IDQAnswer(text: "notification pattern", answerType: .wrong),
            IDQAnswer(text: "notification and KVO patterns", answerType: .correct),
        ]
    ),

    IDQQuestion(
        question: "What is the acronym KVO stands for in iOS development?",
        explanation: "KVO: Key-Value Observing which is a commonly used design pattern.",
        reference: "https://developer.apple.com/documentation/swift/using-key-value-observing-in-swift",
        difficulty: .easy,
        topic: .basics,
        answers: [
            IDQAnswer(text: "Key-View Object \t", answerType: .wrong),
            IDQAnswer(text: "Key-View Observer \t", answerType: .wrong),
            IDQAnswer(text: "Key-Value Object \t", answerType: .wrong),
            IDQAnswer(text: "Key-Value Observing \t", answerType: .correct),
        ]
    ),

    IDQQuestion(
        question: "In MVC (design pattern) what does the V stand for?",
        explanation: "In the Model-View-Controller (MVC) design pattern the V stands for View",
        reference: "https://developer.apple.com/library/archive/documentation/General/Conceptual/DevPedia-CocoaCore/MVC.html",
        difficulty: .easy,
        topic: .basics,
        answers: [
            IDQAnswer(text: "Viewcontroller \t", answerType: .wrong),
            IDQAnswer(text: "Version Control \t", answerType: .wrong),
            IDQAnswer(text: "Vector \t", answerType: .wrong),
            IDQAnswer(text: "View \t", answerType: .correct),
        ]
    ),

    IDQQuestion(
        question: "In the MVC design pattern what is the role of the Controller?",
        explanation: "The Controller mediates between the view and the model via the delegation pattern.",
        reference: "https://developer.apple.com/library/archive/documentation/General/Conceptual/DevPedia-CocoaCore/MVC.html",
        difficulty: .easy,
        topic: .basics,
        answers: [
            IDQAnswer(text: "There is no Controller in MVC.", answerType: .wrong),
            IDQAnswer(text: "It represents the data and the logic of the application.", answerType: .wrong),
            IDQAnswer(text: "It represents the user interface of the application.", answerType: .wrong),
            IDQAnswer(text: "It acts as an intermediary between the model and the view.", answerType: .correct),
        ]
    ),

    IDQQuestion(
        question: "What is the difference between the MVVM and the Viper design patterns?",
        explanation: "The 'R' in VIPER stands for Router which alone handles navigation between screens.",
        reference: "https://www.kodeco.com/8440907-getting-started-with-the-viper-architecture-pattern",
        difficulty: .medium,
        topic: .basics,
        answers: [
            IDQAnswer(text: "MVVM separates the business logic from the data model.", answerType: .wrong),
            IDQAnswer(text: "MVVM further separates view logic from the data logic than VIPER.", answerType: .wrong),
            IDQAnswer(text: "MVVM and VIPER are the same, just have different namings.", answerType: .wrong),
            IDQAnswer(text: "VIPER separates the navigation logic of the application.", answerType: .correct),
        ]
    ),

    IDQQuestion(
        question: "Which is NOT a component in the VIPER design pattern?",
        explanation: "VIPER as View-Interactor-Presenter-Entity-Router",
        reference: "https://www.kodeco.com/8440907-getting-started-with-the-viper-architecture-pattern",
        difficulty: .medium,
        topic: .basics,
        answers: [
            IDQAnswer(text: "Entity ", answerType: .wrong),
            IDQAnswer(text: "Presenter ", answerType: .wrong),
            IDQAnswer(text: "Interactor ", answerType: .wrong),
            IDQAnswer(text: "Model ", answerType: .correct),
        ]
    ),

    IDQQuestion(
        question: "What is a singleton?",
        explanation: "A software design pattern that restricts the instantiation of a class to a singular instance.",
        reference: "https://developer.apple.com/library/archive/documentation/General/Conceptual/DevPedia-CocoaCore/Singleton.html",
        difficulty: .medium,
        topic: .basics,
        answers: [
            IDQAnswer(text: "A networking protocol used for transferring large files between computers.", answerType: .wrong),
            IDQAnswer(text: "A design pattern where multiple instances of a class can exist simultaneously. ", answerType: .wrong),
            IDQAnswer(text: "A programming language that only supports single-threaded applications.", answerType: .wrong),
            IDQAnswer(text: "A design pattern that restricts the instantiation of a class to one object", answerType: .correct),
        ]
    ),

    IDQQuestion(
        question: "How can you declare optional methods in a protocol?",
        explanation: "With the @objc optional keywords. Note that all conforming types must be Objective-C compatible.",
        reference: "https://docs.swift.org/swift-book/documentation/the-swift-programming-language/protocols/#Optional-Protocol-Requirements",
        difficulty: .hard,
        topic: .basics,
        answers: [
            IDQAnswer(text: "It's not possible, except with an extension to the protocol where the optional method is used.", answerType: .wrong),
            IDQAnswer(text: "By using the @abstract optional  keyword", answerType: .wrong),
            IDQAnswer(text: "By using the @optional keywords", answerType: .wrong),
            IDQAnswer(text: "By using @objc optional keywords.", answerType: .correct),
        ]
    ),

    IDQQuestion(
        question: "What is the difference between Size classes and Auto Layout?",
        explanation: "4 constraints are required to properly define the position of a UI element.",
        reference: nil,
        difficulty: .medium,
        topic: .basics,
        answers: [
            IDQAnswer(text: "Auto Layout cannot be modified later, unlike Size classes", answerType: .wrong),
            IDQAnswer(text: "Auto Layout definitions always override size classes when the two are confliction.", answerType: .wrong),
            IDQAnswer(text: "Auto Layout defines interface traits, Size classes positioning.", answerType: .wrong),
            IDQAnswer(text: "Size classes define interface traits, Auto Layout positioning.", answerType: .correct),
        ]
    ),

    IDQQuestion(
        question: "Which one is printed out first?",
        explanation: "The print(\"first\") is executed firstly on the current thread. The rest is scheduled to be executed asynchronously on the main thread at some point in the future.",
        reference: nil,
        difficulty: .medium,
        topic: .basics,
        answers: [
            IDQAnswer(text: "DispatchQueue.main.async {\n\tprint(\"fist\")\n}", answerType: .wrong),
            IDQAnswer(text: "DispatchQueue.main.asyncAfter (deadline: .now()) {\n\tprint(\"fist\")\n}", answerType: .wrong),
            IDQAnswer(text: "Either one of the print statments called on the main thread.", answerType: .wrong),
            IDQAnswer(text: "print(\"fist\")", answerType: .correct),
        ]
    ),

    IDQQuestion(
        question: "What is the difference between the main thread and the background threads?",
        explanation: "The main thread generally focuses on UI changes, the background threads for lengthier tasks",
        reference: "https://developer.apple.com/documentation/dispatch/dispatchqueue",
        difficulty: .medium,
        topic: .basics,
        answers: [
            IDQAnswer(text: "That there are only 2 main threads and 6 background threads.", answerType: .wrong),
            IDQAnswer(text: "Methods called on the main thread are always executed before of those called on a background thread.", answerType: .wrong),
            IDQAnswer(text: "The main thread typically handles the user interface while the background thread handles networking", answerType: .wrong),
            IDQAnswer(text: "The main thread typically handles the user interface while the background threads handle large, time-consuming tasks.", answerType: .correct),
        ]
    ),

    IDQQuestion(
        question: "What the DispatchQoS is used for?",
        explanation: "The Dispatch Quality of Service sets the execution priority of tasks. It categorizes work to perform on a DispatchQueue. By specifying the quality of a task, you indicate its importance to your app.",
        reference: "https://developer.apple.com/documentation/dispatch/dispatchqos",
        difficulty: .medium,
        topic: .basics,
        answers: [
            IDQAnswer(text: "It's for a group of tasks that you monitor as a single unit.", answerType: .wrong),
            IDQAnswer(text: "It's an object that manages operations on a file descriptor using either stream-based or random-access semantics.", answerType: .wrong),
            IDQAnswer(text: "It's for an object that coordinates the processing of specific low-level system events.", answerType: .wrong),
            IDQAnswer(text: "It's for setting the execution priority, to apply to tasks.", answerType: .correct),
        ]
    ),

    IDQQuestion(
        question: "Which qualty of service class has the lowest priority level?",
        explanation: "The background tasks have the lowest priority level of all tasks.",
        reference: "https://developer.apple.com/documentation/dispatch/dispatchqos/1780981-background",
        difficulty: .hard,
        topic: .basics,
        answers: [
            IDQAnswer(text: "userInitiated", answerType: .wrong),
            IDQAnswer(text: "default", answerType: .wrong),
            IDQAnswer(text: "utility", answerType: .wrong),
            IDQAnswer(text: "background", answerType: .correct),
        ]
    ),

    IDQQuestion(
        question: "How would you set the position of a task's importance within its assigned quality of service (QoS) class?",
        explanation: "By setting the relativePriority of the service property.",
        reference: "https://developer.apple.com/documentation/dispatch/dispatchqos/1780953-relativepriority",
        difficulty: .hard,
        topic: .basics,
        answers: [
            IDQAnswer(text: "By using a semaphore to manage the priority", answerType: .wrong),
            IDQAnswer(text: "With the priorityLevel property", answerType: .wrong),
            IDQAnswer(text: "The priority in the same service class is fixed and can't be modified.", answerType: .wrong),
            IDQAnswer(text: "With the relativePriority property", answerType: .correct),
        ]
    ),

    IDQQuestion(
        question: "What is a defer statement?",
        explanation: "A defer statement is used for executing code just before transferring program control outside of the scope that the defer statement appears in.",
        reference: "https://docs.swift.org/swift-book/documentation/the-swift-programming-language/statements/#Defer-Statement",
        difficulty: .medium,
        topic: .basics,
        answers: [
            IDQAnswer(text: "Inside switch statements the code within a defer case is executed only if no other cases match the control expression", answerType: .wrong),
            IDQAnswer(text: "It causes a program to end execution of the current scope and begin error propagation to its enclosing scope.", answerType: .wrong),
            IDQAnswer(text: "It is used to declare a function with a default value.", answerType: .wrong),
            IDQAnswer(text: "It's used to execute a block of code just before the current scope is exited", answerType: .correct),
        ]
    ),

    IDQQuestion(
        question: "With what tools can you catch changes in a property's value in Swift?",
        explanation: "With property observers. The \"willSet\" and \"didSet\" observeres are called before/after a change in the observed property's value.",
        reference: "https://docs.swift.org/swift-book/documentation/the-swift-programming-language/properties/#Property-Observers",
        difficulty: .medium,
        topic: .basics,
        answers: [
            IDQAnswer(text: "With the defer statement", answerType: .wrong),
            IDQAnswer(text: "With the @notify keyword and a unique notification identifier", answerType: .wrong),
            IDQAnswer(text: "With property wrappers", answerType: .wrong),
            IDQAnswer(text: "With property observers", answerType: .correct),
        ]
    ),


    //MARK: - UIKit
    IDQQuestion(
        question: "In UIKit how many constraints are needed at minimum to correctly determine the position of a UI element?",
        explanation: "4 constraints are required to properly define the position of a UI element.",
        reference: nil,
        difficulty: .easy,
        topic: .uikit,
        answers: [
            IDQAnswer(text: "1", answerType: .wrong),
            IDQAnswer(text: "2", answerType: .wrong),
            IDQAnswer(text: "6", answerType: .wrong),
            IDQAnswer(text: "4", answerType: .correct),
        ]
    ),

    IDQQuestion(
        question: "In UIKit when loading a view controller what method is called first from the listed below?",
        explanation: "The loadView() is called before the controller's view is loaded into memory.",
        reference: "https://developer.apple.com/documentation/uikit/uiviewcontroller/1621454-loadview",
        difficulty: .easy,
        topic: .uikit,
        answers: [
            IDQAnswer(text: "windowDidAppear() \t", answerType: .wrong),
            IDQAnswer(text: "viewWillAppear() \t", answerType: .wrong),
            IDQAnswer(text: "viewDidLoad() \t", answerType: .wrong),
            IDQAnswer(text: "loadView() \t", answerType: .correct),
        ]
    ),

    IDQQuestion(
        question: "In UIKit how can you programatically set a view controller (ExampleViewController) to be the first presented when launching the app?",
        explanation: "By setting the window property's rootViewController to ExampleViewController in the app's SceneDelegate.",
        reference: nil,
        difficulty: .medium,
        topic: .uikit,
        answers: [
            IDQAnswer(text: "By setting the ExampleViewController's level property to 0 inside the AppDelegate.", answerType: .wrong),
            IDQAnswer(text: "By setting the isRottViewController property of the ExampleViewController to true in the SceneDelegate.", answerType: .wrong),
            IDQAnswer(text: "By calling the app's root view controller's present() method in the AppDelegate.", answerType: .wrong),
            IDQAnswer(text: "By setting the window property's rootViewController to ExampleViewController in the app's SceneDelegate.", answerType: .correct),
        ]
    ),

    IDQQuestion(
        question: "When setting custom constraints to a UI element we should set the element's ______________.",
        explanation: "If you want to use Auto Layout to dynamically calculate the size and position of your view, you must set this property to false",
        reference: "https://developer.apple.com/documentation/uikit/uiview/1622572-translatesautoresizingmaskintoco",
        difficulty: .easy,
        topic: .uikit,
        answers: [
            IDQAnswer(text: "clipsToBounds property to true", answerType: .wrong),
            IDQAnswer(text: "clipsToBounds property to false", answerType: .wrong),
            IDQAnswer(text: "translatesAutoresizingMaskIntoConstraints property to true", answerType: .wrong),
            IDQAnswer(text: "translatesAutoresizingMaskIntoConstraints property to false", answerType: .correct),
        ]
    ),

    IDQQuestion(
        question: "Regarding the difference between push and modal segues which of the below statements is true?",
        explanation: "Push segues require a navigation view controller. The presented view controller has a back button and it, by default covers the entire screen.",
        reference: "https://developer.apple.com/library/archive/featuredarticles/ViewControllerPGforiPhoneOS/UsingSegues.html",
        difficulty: .medium,
        topic: .uikit,
        answers: [
            IDQAnswer(text: "The modal segue is only used for storyboard-based transitions, the push segue is for programatic transitions.", answerType: .wrong),
            IDQAnswer(text: "The push segue presents the new content modally over the source view controller. ", answerType: .wrong),
            IDQAnswer(text: "Modal segues have a back button built in the presented view controller by default", answerType: .wrong),
            IDQAnswer(text: "Push segues require a navigation controller but modal segues don't", answerType: .correct),
        ]
    ),

    IDQQuestion(
        question: "What methods are required to be implemented when adopting the UICollectionViewDataSource protocol?",
        explanation: "At a minimum, all data source objects must implement the collectionView(_:numberOfItemsInSection:) and collectionView(_:cellForItemAt:) methods.",
        reference: "https://developer.apple.com/documentation/uikit/uicollectionviewdatasource",
        difficulty: .medium,
        topic: .uikit,
        answers: [
            IDQAnswer(text: "The UICollectionViewDataSource protocol has no required methods.", answerType: .wrong),
            IDQAnswer(text: " collectionView(_:didSelectItemAt:) \n collectionView(_:numberOfItemsInSection:) \n  collectionView(_:cellForItemAt:)", answerType: .wrong),
            IDQAnswer(text: " collectionView(_:numberOfItemsInSection:) \n collectionView(_:layout:sizeForItemAt:)", answerType: .wrong),
            IDQAnswer(text: "collectionView(_:numberOfItemsInSection:) \n collectionView(_:cellForItemAt:)", answerType: .correct),
        ]
    ),

    IDQQuestion(
        question: "Regarding the difference between UITableView and UICollectionView which statment is INCORRECT?",
        explanation: "The UITableView does not allow varying sized cells is the false statment. With the tableView(_:heightForRowAt:) method you can modify a given row's height.",
        reference: "https://developer.apple.com/documentation/uikit/uitableviewdelegate/1614998-tableview",
        difficulty: .medium,
        topic: .uikit,
        answers: [
            IDQAnswer(text: "Only the UICollectionView offeres built in transitions effects when changing it's layout.", answerType: .wrong),
            IDQAnswer(text: "The UITableView is designed to display data in a single column", answerType: .wrong),
            IDQAnswer(text: "The UICollectionView allow you to move items around based on user interactions.", answerType: .wrong),
            IDQAnswer(text: "The UITableView does not allow varying sized cells.", answerType: .correct),
        ]
    ),

    IDQQuestion(
        question: "In UIKit use __________ to force the view to update its layout immediately.",
        explanation: "Use layoutIfNeeded() to force the view to update its layout immediately. When using Auto Layout, the layout engine updates the position of views as needed to satisfy changes in constraints.",
        reference: "https://developer.apple.com/documentation/uikit/uiview/1622507-layoutifneeded",
        difficulty: .medium,
        topic: .uikit,
        answers: [
            IDQAnswer(text: "sizeToFit() \t", answerType: .wrong),
            IDQAnswer(text: "updateConstraints() \t", answerType: .wrong),
            IDQAnswer(text: "setNeedsLayout() \t", answerType: .wrong),
            IDQAnswer(text: "layoutIfNeeded() \t", answerType: .correct),
        ]
    ),
    
    IDQQuestion(
        question: "What is the default value for tableView(_:heightForRowAt:) if the table view is not empty?",
        explanation: "automaticDimension is the default value that is used for the height or width of a UI element, such as a table view cell or a collection view cell.",
        reference: "https://developer.apple.com/documentation/uikit/uitableview/1614961-automaticdimension",
        difficulty: .medium,
        topic: .uikit,
        answers: [
            IDQAnswer(text: "UITableView.estimatedRowHeight \t", answerType: .wrong),
            IDQAnswer(text: "By default it's the first row's height.", answerType: .wrong),
            IDQAnswer(text: "nil \t", answerType: .wrong),
            IDQAnswer(text: "UITableView.automaticDimension \t", answerType: .correct),
        ]
    ),
    
    IDQQuestion(
        question: "When subclassing UICollectionViewCell and implementing the prepareForReuse() without calling the super.prepareForResue() the intended purpose of the method __________ ?",
        explanation: "If you override the prepareForReuse() method in a subclass of UICollectionViewCell and you don't call super.prepareForReuse(), the default implementation of prepareForReuse() provided by UICollectionViewCell may not be executed.",
        reference: "https://developer.apple.com/documentation/uikit/uicollectionreusableview/1620141-prepareforreuse",
        difficulty: .medium,
        topic: .uikit,
        answers: [
            IDQAnswer(text: "won't happen and you'll get an error", answerType: .wrong),
            IDQAnswer(text: "will happen because the subclass by default overrides the parent class.", answerType: .wrong),
            IDQAnswer(text: "may not happen as this is overriden by the UICollectionView's collectionView(_:willDisplay:forItemAt:) method", answerType: .wrong),
            IDQAnswer(text: "may not happen as it's overriden by the parent class.", answerType: .correct),
        ]
    ),
    
    IDQQuestion(
        question: "How can you implement a dynamic font size in UILabel?",
        explanation: "By setting the adjustsFontSizeToFitWidth property true and specifying a minimumScaleFactor the label's fontsize will dynamically be set based on the label’s bounding rectangle.",
        reference: "https://developer.apple.com/documentation/uikit/uilabel/1620546-adjustsfontsizetofitwidth",
        difficulty: .medium,
        topic: .uikit,
        answers: [
            IDQAnswer(text: "Dynamic font size is only available in SwiftUI", answerType: .wrong),
            IDQAnswer(text: "Set the label's adjustsFontSizeToFit property to true. Set its minimumScaleSize and maximumScaleSize to some CGFLoat values.", answerType: .wrong),
            IDQAnswer(text: "Set the label's adjustsFontSizeToFit property to true and its minimumScaleFactor property to a value greater than or equal to 0.", answerType: .wrong),
            IDQAnswer(text: "Set the label's adjustsFontSizeToFitWidth property to true and its minimumScaleFactor property to a value greater than or equal to 0.", answerType: .correct),
        ]
    ),
    
    IDQQuestion(
        question: "How can you horizontally center the text of a UILabel?",
        explanation: "With the label's textAlignment property set to center",
        reference: "https://developer.apple.com/documentation/uikit/uilabel/1620541-textalignment",
        difficulty: .easy,
        topic: .uikit,
        answers: [
            IDQAnswer(text: "Set the label's centerXAnchor property to centered", answerType: .wrong),
            IDQAnswer(text: "Set the label's layer.frame.horizontalAlignment property to center", answerType: .wrong),
            IDQAnswer(text: "Set the label's contentMode property to center.", answerType: .wrong),
            IDQAnswer(text: "Set the label's textAlignment property to center.", answerType: .correct),
        ]
    ),
    
    IDQQuestion(
        question: "When working with UIKit what would you use to make sure the user can enter a large amount of text into your app?",
        explanation: "The UITextView is by default a multiline, scrollable text region which is perfect for entering or editing a larger body of text.",
        reference: "https://developer.apple.com/documentation/uikit/uitextview",
        difficulty: .easy,
        topic: .uikit,
        answers: [
            IDQAnswer(text: "A UITextField that has the numberOfLines set to 0 and the content mode set to scaled", answerType: .wrong),
            IDQAnswer(text: "A UITextField that has the numberOfLines set to some Int larger than 1", answerType: .wrong),
            IDQAnswer(text: "Either a UITextField with numberOfLines set to 0 or UITextView with contentMode set to scaled", answerType: .wrong),
            IDQAnswer(text: "A UITextView which is multiline by default", answerType: .correct),
        ]
    ),
    
    IDQQuestion(
        question: "How would you build a slider in UIKit that allows the user to select a range of values?",
        explanation: "The only slider Apple offers is the UISlider() which only allows the selection of a single value from a range of values. You need to use third party libraries or place two sliders on top of each other.",
        reference: "https://developer.apple.com/documentation/uikit/uicontrol",
        difficulty: .medium,
        topic: .uikit,
        answers: [
            IDQAnswer(text: "By using a UISlider() with it's numberOfThumbs property set to 2", answerType: .wrong),
            IDQAnswer(text: "By using a UIRangeSlider() that by default has two thumbs which allows range selection.", answerType: .wrong),
            IDQAnswer(text: "By using a UISlider() with it's numberOfThumbs property set to 2 and it's selectionStyle set to range", answerType: .wrong),
            IDQAnswer(text: "UIKit does not have a UIControl that allows this. You may have to use third party libraries", answerType: .correct),
        ]
    ),
    
    
]

