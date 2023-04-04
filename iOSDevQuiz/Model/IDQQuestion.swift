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
            IDQAnswer(text: "version control", isCorrect: false),
            IDQAnswer(text: "refactoring", isCorrect: false),
            IDQAnswer(text: "inheritance", isCorrect: false ),
            IDQAnswer(text: "initialization", isCorrect: true)
        ]
    ),
    
    IDQQuestion(
        question: "What is the logical 'or' operator in Swift?",
        explanation: "The logical OR operator is || in Swift",
        reference: "https://developer.apple.com/documentation/swift/operator-declarations",
        difficulty: .easy,
        topic: .basics,
        answers: [
            IDQAnswer(text: "??", isCorrect: false),
            IDQAnswer(text: "OR", isCorrect: false),
            IDQAnswer(text: "or", isCorrect: false ),
            IDQAnswer(text: "||", isCorrect: true)
        ]
    ),
    
    IDQQuestion(
        question: "What do we use the ternary operator for?",
        explanation: "condition ? valueIfTrue : valueIfFalse",
        reference: "https://developer.apple.com/documentation/swift/operator-declarations",
        difficulty: .easy,
        topic: .basics,
        answers: [
            IDQAnswer(text: "To unwrap optionals safely.", isCorrect: false),
            IDQAnswer(text: "To manage multiple async tasks.", isCorrect: false),
            IDQAnswer(text: "To ensure that certain conditions are met before executing the rest of the code in a function or method.", isCorrect: false ),
            IDQAnswer(text: "It allows you to write a concise expression to choose one of two values based on a condition.", isCorrect: true)
        ]
    ),
    
    IDQQuestion(
        question: "The __________ type represents a character made up of one (or more) Unicode scalar values.",
        explanation: "The Character represents a single extended grapheme cluster, which is a sequence of one or more Unicode scalars that produce a single human-readable letter or symbol.",
        reference: "https://developer.apple.com/documentation/swift/character",
        difficulty: .easy,
        topic: .basics,
        answers: [
            IDQAnswer(text: "UInt \t", isCorrect: false),
            IDQAnswer(text: "AnyObject \t", isCorrect: false),
            IDQAnswer(text: "String \t", isCorrect: false ),
            IDQAnswer(text: "Character \t", isCorrect: true)
        ]
    ),
    
    IDQQuestion(
        question: "A #selector expression is used to refer to __________",
        explanation: "A selector expression lets you access the selector used to refer to a method or to a property’s getter or setter in Objective-C.",
        reference: "https://docs.swift.org/swift-book/documentation/the-swift-programming-language/expressions/#Selector-Expression",
        difficulty: .easy,
        topic: .basics,
        answers: [
            IDQAnswer(text: "an object exposed to Swift or Objective-C.", isCorrect: false),
            IDQAnswer(text: "an object exposed to Objective-C.", isCorrect: false),
            IDQAnswer(text: "a method exposed to Swift or Objective-C.", isCorrect: false ),
            IDQAnswer(text: "a method exposed to Objective-C.", isCorrect: true)
        ]
    ),
    
    IDQQuestion(
        question: "What is the difference between Any and AnyObject?",
        explanation: "Any is a protocol that represents any type at all, including class types, struct types, enum types, and protocol types.. AnyObject is a protocol that represents any instance of a class type.",
        reference: "https://developer.apple.com/documentation/swift/anyobject",
        difficulty: .medium,
        topic: .basics,
        answers: [
            IDQAnswer(text: " Any can represent any instance of a class.\n AnyObject can represent any type including value types.", isCorrect: false),
            IDQAnswer(text: " Any can only represent value types.\n AnyObject can represent any instance of a class.", isCorrect: false),
            IDQAnswer(text: " Any represents class types, AnyObject represents struct.", isCorrect: false ),
            IDQAnswer(text: " Any can represent any type including value types.\n AnyObject can represent any instance of a class.", isCorrect: true)
        ]
    ),
    
    IDQQuestion(
        question: "What is type annotation?",
        explanation: "A type annotation explicitly specifies the type of a variable or expression.\nExample: let size: CGFloat = 10.0",
        reference: "https://docs.swift.org/swift-book/documentation/the-swift-programming-language/types/#Type-Annotation",
        difficulty: .easy,
        topic: .basics,
        answers: [
            IDQAnswer(text: "The creation of an optional type data object", isCorrect: false),
            IDQAnswer(text: "Creating new types by combining existing types.", isCorrect: false),
            IDQAnswer(text: "Automatically inferring the type of a variable or function parameter.", isCorrect: false ),
            IDQAnswer(text: "Explicitly specifying the type of a variable or function parameter.", isCorrect: true)
        ]
    ),
    
    IDQQuestion(
        question: "How can you create a multi-line String object in Swift?",
        explanation: "The Character type represents a character made up of one or more Unicode scalar values, grouped by a Unicode boundary algorithm.",
        reference: "https://docs.swift.org/swift-book/documentation/the-swift-programming-language/stringsandcharacters/#Multiline-String-Literals",
        difficulty: .medium,
        topic: .basics,
        answers: [
            IDQAnswer(text: "By the combination of a backslash and an asterisk,", isCorrect: false),
            IDQAnswer(text: "By using the backslash character at the end of each line,", isCorrect: false),
            IDQAnswer(text: "By separating each line with a semicolon", isCorrect: false ),
            IDQAnswer(text: "By enclosing the string in triple quotes", isCorrect: true)
        ]
    ),
    
    IDQQuestion(
        question: "What is the method deinit() used for?",
        explanation: "A deinitializer is called immediately before a class instance is deallocated.",
        reference: "https://docs.swift.org/swift-book/documentation/the-swift-programming-language/deinitialization/",
        difficulty: .medium,
        topic: .basics,
        answers: [
            IDQAnswer(text: "deinit() is called to create a new instance of a particular type", isCorrect: false),
            IDQAnswer(text: "The deinit() is called to unconditionally stop execution.", isCorrect: false),
            IDQAnswer(text: "The deinit() method is called on the app delegate when the app is about to move from the active to inactive state.", isCorrect: false),
            IDQAnswer(text: "The deinit() is called immediately before a class instance is deallocated.", isCorrect: true)
        ]
    ),
    
    IDQQuestion(
        question: "What is a Tuple in Swift?",
        explanation: "A tuple type is a comma-separated list of types, that can be of different types and is enclosed in parentheses.",
        reference: "https://docs.swift.org/swift-book/documentation/the-swift-programming-language/types/#Tuple-Type",
        difficulty: .easy,
        topic: .basics,
        answers: [
            IDQAnswer(text: "A control flow statement that allows you to break out of a loop or switch statement.", isCorrect: false),
            IDQAnswer(text: "A collection type that can store multiple values of the same type in an ordered list.", isCorrect: false),
            IDQAnswer(text: "A Tuple is collection of values of either Int, String or Bool types", isCorrect: false ),
            IDQAnswer(text: "A Tuple is a collection of values of any type, which can be of different types.", isCorrect: true)
        ]
    ),
    
    IDQQuestion(
        question: "What does the Codable protocol do?",
        explanation: "It's a combination of Decodable and Encodable. With it you can convert objects to and from a serialized format, such as JSON, that can be easily transmitted or stored.",
        reference: "https://developer.apple.com/documentation/swift/codable",
        difficulty: .medium,
        topic: .basics,
        answers: [
            IDQAnswer(text: "It defines methods for converting an object to and from a binary format.", isCorrect: false),
            IDQAnswer(text: "It provides methods for performing cryptographic operations.", isCorrect: false),
            IDQAnswer(text: "It provides a standardized way to decode objects from JSON.", isCorrect: false),
            IDQAnswer(text: "It provides a standardized way to encode and decode objects to and from JSON, or other data formats.", isCorrect: true)
        ]
    ),
    
    IDQQuestion(
        question: "What are enums in Swift?",
        explanation: "Enum stands for enumeration, and it defines a common type for a group of related values",
        reference: "https://docs.swift.org/swift-book/documentation/the-swift-programming-language/enumerations/",
        difficulty: .easy,
        topic: .basics,
        answers: [
            IDQAnswer(text: "Enums are a tool to debug errors.", isCorrect: false),
            IDQAnswer(text: "A type of array used to store multiple values of the same type.", isCorrect: false),
            IDQAnswer(text: "A collection type that can store multiple values of the same type in an ordered list.", isCorrect: false),
            IDQAnswer(text: "Enums are a way to define a group of related values.", isCorrect: true)
        ]
    ),
    
    
    IDQQuestion(
        question: "What are UserDefaults?",
        explanation: "An interface to the user’s defaults database, where you store key-value pairs persistently across launches of your app.",
        reference: "https://developer.apple.com/documentation/foundation/userdefaults",
        difficulty: .easy,
        topic: .basics,
        answers: [
            IDQAnswer(text: "A set of built-in methods that can be used to manipulate user interface elements.", isCorrect: false),
            IDQAnswer(text: "A type of in-memory cache that can be used to store frequently accessed data to improve the application's performance.", isCorrect: false),
            IDQAnswer(text: "Data structures to store and retrieve large amounts of data in a key-value format.", isCorrect: false),
            IDQAnswer(text: "A simple key-value store that allows the application to store and retrieve small pieces of data.", isCorrect: true)
        ]
    ),
    
    IDQQuestion(
        question: "what is an associated type?",
        explanation: "An associated type gives a placeholder name to a type that’s used as part of the protocol.",
        reference: "https://docs.swift.org/swift-book/documentation/the-swift-programming-language/generics/#Associated-Types",
        difficulty: .hard,
        topic: .basics,
        answers: [
            IDQAnswer(text: "It's used to hide a return values type.", isCorrect: false),
            IDQAnswer(text: "It's used to create an alias or alternative name for an existing type.", isCorrect: false),
            IDQAnswer(text: "It's used to define enums in Swift.", isCorrect: false),
            IDQAnswer(text: "It's used to define placeholder type used in a protocol.", isCorrect: true)
        ]
    ),
    
    IDQQuestion(
        question: "what is an opaque type?",
        explanation: "An opaque type is a way to hide the underlying implementation details of a type",
        reference: "https://docs.swift.org/swift-book/documentation/the-swift-programming-language/opaquetypes",
        difficulty: .hard,
        topic: .basics,
        answers: [
            IDQAnswer(text: "There is no opaque type in Swift.", isCorrect: false),
            IDQAnswer(text: "It's used to create an alias or alternative name for an existing type.", isCorrect: false),
            IDQAnswer(text: "It refers to the type of any type, including class types, structure types, enumeration types, and protocol types.", isCorrect: false),
            IDQAnswer(text: "A function or method with an opaque type hides its return value’s type information.", isCorrect: true)
        ]
    ),
    
    IDQQuestion(
        question: "What is the difference between an Array and a Set?",
        explanation: "A Set is unordered collection of unique elements. An Array is an ordered random-access collection.",
        reference: "https://developer.apple.com/documentation/swift/set",
        difficulty: .medium,
        topic: .basics,
        answers: [
            IDQAnswer(text: "An Array is a collection of elements that can be of different data types. A Set can only contain elements of the same data type.", isCorrect: false),
            IDQAnswer(text: "An Array is a dynamic collection of elements, while a Set is static and immutable.", isCorrect: false),
            IDQAnswer(text: "A Set can only store two elements, while an Array can store an unlimited number of elements.", isCorrect: false),
            IDQAnswer(text: "An Array is a collection of elements that can contain duplicates and are ordered, while a Set is an unordered collection of unique elements", isCorrect: true)
        ]
    ),
    
    IDQQuestion(
        question: "What is the difference between a Float and a Double?",
        explanation: "Double represents a 64-bit floating-point number while a Float represents a 32-bit floating-point number.",
        reference: "https://docs.swift.org/swift-book/documentation/the-swift-programming-language/thebasics/#Floating-Point-Numbers",
        difficulty: .easy,
        topic: .basics,
        answers: [
            IDQAnswer(text: "A Float is a data type that can only store positive numbers.", isCorrect: false),
            IDQAnswer(text: "Float is a one-precision while Dpuble is a double-precision floating point number.", isCorrect: false),
            IDQAnswer(text: "Both are floating-point numbers, but Float had been depricated in iOS 7.", isCorrect: false),
            IDQAnswer(text: "A Float uses 32 bits while a Double uses 64 bits of memory.", isCorrect: true)
        ]
    ),
    
    IDQQuestion(
        question: "Which of the following methods is executed first in the AppDelegate before the others?",
        explanation: "The application(_:willFinishLaunchingWithOptions:) tells the delegate that the launch process has begun but that state restoration hasn’t occured.",
        reference: "https://developer.apple.com/documentation/uikit/app_and_environment/responding_to_the_launch_of_your_app",
        difficulty: .easy,
        topic: .basics,
        answers: [
            IDQAnswer(text: "applicationDidBecomeActive(_:) \t", isCorrect: false),
            IDQAnswer(text: "application(_: didFinishLaunchingWithOptions:) \t", isCorrect: false),
            IDQAnswer(text: "sceneDidBecomeActive(_:) \t", isCorrect: false),
            IDQAnswer(text: "application(_: willFinishLaunchingWithOptions:) \t", isCorrect: true),
        ]
    ),
    
    
    IDQQuestion(
        question: "What does @frozen attribute stand for?",
        explanation: "Apply this attribute to a structure or enumeration declaration to restrict the kinds of changes you can make to the type.",
        reference: "https://docs.swift.org/swift-book/documentation/the-swift-programming-language/attributes/#frozen",
        difficulty: .hard,
        topic: .basics,
        answers: [
            IDQAnswer(text: "It grants a public getter but private setter to the object it's applied to", isCorrect: false),
            IDQAnswer(text: "There is no @frozen attribute in Swift", isCorrect: false),
            IDQAnswer(text: "It prevents the app from executing the function it's applied to more than once per app launch", isCorrect: false),
            IDQAnswer(text: "It indicates that the annotated type or member is immutable.", isCorrect: true)
        ]
    ),
    
    
    IDQQuestion(
        question: "StringProtocol conforms to which of these protocols?",
        explanation: "StringProtocol conforms to: BidirectionalCollection, Comparable, ExpressibleByStringInterpolation, Hashable, LosslessStringConvertible, TextOutputStream, TextOutputStreamable",
        reference: "https://developer.apple.com/documentation/swift/stringprotocol",
        difficulty: .medium,
        topic: .basics,
        answers: [
            IDQAnswer(text: "Comparable \t", isCorrect: false),
            IDQAnswer(text: "TextOutputStreamable \t", isCorrect: false),
            IDQAnswer(text: "Hashable \t", isCorrect: false),
            IDQAnswer(text: "It conforms to all of the listed protocols", isCorrect: true),
        ]
    ),
    
    
    IDQQuestion(
        question: "What is a UUID?",
        explanation: "A universally unique value to identify types, interfaces, and other items.",
        reference: "https://developer.apple.com/documentation/foundation/uuid",
        difficulty: .easy,
        topic: .basics,
        answers: [
            IDQAnswer(text: "A function to encode and decode Unicode characters.", isCorrect: false),
            IDQAnswer(text: "A data type used for storing GPS coordinates.", isCorrect: false),
            IDQAnswer(text: "A unique 256-bit value that provides identifiable data about an iCloud user.", isCorrect: false),
            IDQAnswer(text: "A unique 128-bit value that is used to identify information in a unique and standardized way.", isCorrect: true)
        ]
    ),
    
    IDQQuestion(
        question: "What is the lazy property in Swift?",
        explanation: "A lazy stored property is a property whose initial value isn’t calculated until the first time it’s used.",
        reference: "https://docs.swift.org/swift-book/documentation/the-swift-programming-language/properties/#Lazy-Stored-Properties",
        difficulty: .medium,
        topic: .basics,
        answers: [
            IDQAnswer(text: "It's a property that is only accessible within the scope of a particular function or method.", isCorrect: false),
            IDQAnswer(text: "A property that is automatically deallocated from memory when it is no longer needed.", isCorrect: false),
            IDQAnswer(text: "There is no lazy property in Swift", isCorrect: false),
            IDQAnswer(text: "It's a property that is only initialized when it is accessed for the first time.", isCorrect: true)
        ]
    ),
    
    IDQQuestion(
        question: "You can add an element to a specific index of an array by using __________ method",
        explanation: "The append(_:) method adds a new element to the end of the Array and the insert(_: at: ) adds a new element to a specific index.",
        reference: "https://developer.apple.com/documentation/swift/array/insert(_:at:)-3erb3",
        difficulty: .easy,
        topic: .basics,
        answers: [
            IDQAnswer(text: "the append(_:at:) \n", isCorrect: false),
            IDQAnswer(text: "the addElement(_:) \n", isCorrect: false),
            IDQAnswer(text: "the append(_:) \n", isCorrect: false),
            IDQAnswer(text: "the insert(_:at:) \n", isCorrect: true)
        ]
    ),
    
    IDQQuestion(
        question: "The zip() method in Swift is used to __________",
        explanation: "The zip() method combines two arrays into a single array of tuples, where each tuple contains one element from each of the input arrays at the same index.",
        reference: "https://developer.apple.com/documentation/swift/zip(_:_:)",
        difficulty: .medium,
        topic: .basics,
        answers: [
            IDQAnswer(text: "compress data into a smaller size before transmitting it over a network.", isCorrect: false),
            IDQAnswer(text: "convert an array of strings into an array of integers, by mapping each string to its corresponding ASCII code.", isCorrect: false),
            IDQAnswer(text: "extract files from a compressed archive.", isCorrect: false),
            IDQAnswer(text: "merge two sequences into a single sequence of tuples.", isCorrect: true)
        ]
    ),
    
    IDQQuestion(
        question: "When would you use Swift’s Result type?",
        explanation: "A value that represents either a success or a failure, including an associated value in each case.",
        reference: "https://developer.apple.com/documentation/swift/result",
        difficulty: .medium,
        topic: .basics,
        answers: [
            IDQAnswer(text: "The Result type is returned by the Core ML framework's removeCheckpoints(_:) at the end of an MLTrainingSession.", isCorrect: false),
            IDQAnswer(text: "It indicates the status of an operation that can return a success or a failure, or an unknown Result type.", isCorrect: false),
            IDQAnswer(text: "It's used to manage concurrency and synchronization in multi-threaded programs.", isCorrect: false),
            IDQAnswer(text: "It's used to indicate the outcome of a function or method that can either succeed or fail.", isCorrect: true)
        ]
    ),
    
    IDQQuestion(
        question: "The guard statement is __________",
        explanation: "With the guard statement we can implement checks into our code that prevents the current scope from continuing if certain conditions are not met.",
        reference: "https://docs.swift.org/swift-book/documentation/the-swift-programming-language/statements/#Guard-Statement",
        difficulty: .easy,
        topic: .basics,
        answers: [
            IDQAnswer(text: "a method that is used to encrypt data.", isCorrect: false),
            IDQAnswer(text: "a type of loop that repeats a block of code until a condition is met.", isCorrect: false),
            IDQAnswer(text: "A control flow statement that is always executed first in it's function or method.", isCorrect: false),
            IDQAnswer(text: "A control flow statement that is used to exit early from a function, method or loop if a condition isn't met.", isCorrect: true)
        ]
    ),
    
    IDQQuestion(
        question: "What is a delegate in Swift?",
        explanation: "Delegation is a design pattern that enables a class or structure to hand off (or delegate) some of its responsibilities to an instance of another type. Think of a delegator as a boss and a delegate as an employee.",
        reference: "https://docs.swift.org/swift-book/documentation/the-swift-programming-language/protocols/#Delegation",
        difficulty: .easy,
        topic: .basics,
        answers: [
            IDQAnswer(text: "A data structure that allows for the efficient storage and retrieval of key-value pairs.", isCorrect: false),
            IDQAnswer(text: "An object that broadcasts information to other objects without having to know about them directly.", isCorrect: false),
            IDQAnswer(text: "A delegator is an object that is responsible for handling specific tasks on behalf of another object, called the delegate.", isCorrect: false),
            IDQAnswer(text: "A delegate is an object that is responsible for handling specific tasks on behalf of another object, called the delegator.", isCorrect: true)
        ]
    ),
    
    IDQQuestion(
        question: "What are the advatages of the notification design pattern over the delegate pattern?",
        explanation: "Notifications can have multiple observers, they are flexible and notifications are delivered asynchronously.",
        reference: nil,
        difficulty: .easy,
        topic: .basics,
        answers: [
            IDQAnswer(text: "The notification pattern allows direct control over who receives the notifications.", isCorrect: false),
            IDQAnswer(text: "The notification pattern is generally more efficient then the delegate pattern.", isCorrect: false),
            IDQAnswer(text: "The delegate pattern is in every way superior to the notification pattern", isCorrect: false),
            IDQAnswer(text: "Notifications can have multiple observers, which allows for more flexibility", isCorrect: true)
        ]
    ),
    
    IDQQuestion(
        question: "With the __________ observers can be registered and unregistered dynamically at runtime without modifying the code of the notifying object.",
        explanation: "Both the notification pattern and key-value observing pattern is capable of it.",
        reference: nil,
        difficulty: .medium,
        topic: .basics,
        answers: [
            IDQAnswer(text: "delegate pattern", isCorrect: false),
            IDQAnswer(text: "key-value observing pattern", isCorrect: false),
            IDQAnswer(text: "notification pattern", isCorrect: false),
            IDQAnswer(text: "notification and KVO patterns", isCorrect: true)
        ]
    ),
    
    IDQQuestion(
        question: "What is the acronym KVO stands for in iOS development?",
        explanation: "KVO: Key-Value Observing which is a commonly used design pattern.",
        reference: "https://developer.apple.com/documentation/swift/using-key-value-observing-in-swift",
        difficulty: .easy,
        topic: .basics,
        answers: [
            IDQAnswer(text: "Key-View Object \t", isCorrect: false),
            IDQAnswer(text: "Key-View Observer \t", isCorrect: false),
            IDQAnswer(text: "Key-Value Object \t", isCorrect: false),
            IDQAnswer(text: "Key-Value Observing \t", isCorrect: true)
        ]
    ),
    
    IDQQuestion(
        question: "In MVC (design pattern) what does the V stand for?",
        explanation: "In the Model-View-Controller (MVC) design pattern the V stands for View",
        reference: "https://developer.apple.com/library/archive/documentation/General/Conceptual/DevPedia-CocoaCore/MVC.html",
        difficulty: .easy,
        topic: .basics,
        answers: [
            IDQAnswer(text: "Viewcontroller \t", isCorrect: false),
            IDQAnswer(text: "Version Control \t", isCorrect: false),
            IDQAnswer(text: "Vector \t", isCorrect: false),
            IDQAnswer(text: "View \t", isCorrect: true)
        ]
    ),
    
    IDQQuestion(
        question: "In the MVC design pattern what is the role of the Controller?",
        explanation: "The Controller mediates between the view and the model via the delegation pattern.",
        reference: "https://developer.apple.com/library/archive/documentation/General/Conceptual/DevPedia-CocoaCore/MVC.html",
        difficulty: .easy,
        topic: .basics,
        answers: [
            IDQAnswer(text: "There is no Controller in MVC.", isCorrect: false),
            IDQAnswer(text: "It represents the data and the logic of the application.", isCorrect: false),
            IDQAnswer(text: "It represents the user interface of the application.", isCorrect: false),
            IDQAnswer(text: "It acts as an intermediary between the model and the view.", isCorrect: true)
        ]
    ),
    
    IDQQuestion(
        question: "What is the difference between the MVVM and the Viper design patterns?",
        explanation: "The 'R' in VIPER stands for Router which alone handles navigation between screens.",
        reference: "https://www.kodeco.com/8440907-getting-started-with-the-viper-architecture-pattern",
        difficulty: .medium,
        topic: .basics,
        answers: [
            IDQAnswer(text: "MVVM separates the business logic from the data model.", isCorrect: false),
            IDQAnswer(text: "MVVM further separates view logic from the data logic than VIPER.", isCorrect: false),
            IDQAnswer(text: "MVVM and VIPER are the same, just have different namings.", isCorrect: false),
            IDQAnswer(text: "VIPER separates the navigation logic of the application.", isCorrect: true)
        ]
    ),
    
    IDQQuestion(
        question: "Which is NOT a component in the VIPER design pattern?",
        explanation: "VIPER as View-Interactor-Presenter-Entity-Router",
        reference: "https://www.kodeco.com/8440907-getting-started-with-the-viper-architecture-pattern",
        difficulty: .medium,
        topic: .basics,
        answers: [
            IDQAnswer(text: "Entity ", isCorrect: false),
            IDQAnswer(text: "Presenter ", isCorrect: false),
            IDQAnswer(text: "Interactor ", isCorrect: false),
            IDQAnswer(text: "Model ", isCorrect: true)
        ]
    ),
    
    IDQQuestion(
        question: "What is a singleton?",
        explanation: "A software design pattern that restricts the instantiation of a class to a singular instance.",
        reference: "https://developer.apple.com/library/archive/documentation/General/Conceptual/DevPedia-CocoaCore/Singleton.html",
        difficulty: .medium,
        topic: .basics,
        answers: [
            IDQAnswer(text: "A networking protocol used for transferring large files between computers.", isCorrect: false),
            IDQAnswer(text: "A design pattern where multiple instances of a class can exist simultaneously. ", isCorrect: false),
            IDQAnswer(text: "A programming language that only supports single-threaded applications.", isCorrect: false),
            IDQAnswer(text: "A design pattern that restricts the instantiation of a class to one object", isCorrect: true)
        ]
    ),
    
    IDQQuestion(
        question: "How can you declare optional methods in a protocol?",
        explanation: "With the @objc optional keywords. Note that all conforming types must be Objective-C compatible.",
        reference: "https://docs.swift.org/swift-book/documentation/the-swift-programming-language/protocols/#Optional-Protocol-Requirements",
        difficulty: .hard,
        topic: .basics,
        answers: [
            IDQAnswer(text: "It's not possible, except with an extension to the protocol where the optional method is used.", isCorrect: false),
            IDQAnswer(text: "By using the @abstract optional  keyword", isCorrect: false),
            IDQAnswer(text: "By using the @optional keywords", isCorrect: false),
            IDQAnswer(text: "By using @objc optional keywords.", isCorrect: true)
        ]
    ),
    
    IDQQuestion(
        question: "What is the difference between Size classes and Auto Layout?",
        explanation: "4 constraints are required to properly define the position of a UI element.",
        reference: nil,
        difficulty: .medium,
        topic: .basics,
        answers: [
            IDQAnswer(text: "Auto Layout cannot be modified later, unlike Size classes", isCorrect: false),
            IDQAnswer(text: "Auto Layout definitions always override size classes when the two are confliction.", isCorrect: false),
            IDQAnswer(text: "Auto Layout defines interface traits, Size classes positioning.", isCorrect: false),
            IDQAnswer(text: "Size classes define interface traits, Auto Layout positioning.", isCorrect: true)
        ]
    ),
    
    IDQQuestion(
        question: "Which one is printed out first?",
        explanation: "The print(\"first\") is executed firstly on the current thread. The rest is scheduled to be executed asynchronously on the main thread at some point in the future.",
        reference: nil,
        difficulty: .medium,
        topic: .basics,
        answers: [
            IDQAnswer(text: "DispatchQueue.main.async {\n\tprint(\"fist\")\n}", isCorrect: false),
            IDQAnswer(text: "DispatchQueue.main.asyncAfter (deadline: .now()) {\n\tprint(\"fist\")\n}", isCorrect: false),
            IDQAnswer(text: "Either one of the print statments called on the main thread.", isCorrect: false),
            IDQAnswer(text: "print(\"fist\")", isCorrect: true)
        ]
    ),
    
    IDQQuestion(
        question: "What is the difference between the main thread and the background threads?",
        explanation: "The main thread generally focuses on UI changes, the background threads for lengthier tasks",
        reference: "https://developer.apple.com/documentation/dispatch/dispatchqueue",
        difficulty: .medium,
        topic: .basics,
        answers: [
            IDQAnswer(text: "That there are only 2 main threads and 6 background threads.", isCorrect: false),
            IDQAnswer(text: "Methods called on the main thread are always executed before of those called on a background thread.", isCorrect: false),
            IDQAnswer(text: "The main thread typically handles the user interface while the background thread handles networking", isCorrect: false),
            IDQAnswer(text: "The main thread typically handles the user interface while the background threads handle large, time-consuming tasks.", isCorrect: true)
        ]
    ),
    
    IDQQuestion(
        question: "What the DispatchQoS is used for?",
        explanation: "The Dispatch Quality of Service sets the execution priority of tasks. It categorizes work to perform on a DispatchQueue. By specifying the quality of a task, you indicate its importance to your app.",
        reference: "https://developer.apple.com/documentation/dispatch/dispatchqos",
        difficulty: .medium,
        topic: .basics,
        answers: [
            IDQAnswer(text: "It's for a group of tasks that you monitor as a single unit.", isCorrect: false),
            IDQAnswer(text: "It's an object that manages operations on a file descriptor using either stream-based or random-access semantics.", isCorrect: false),
            IDQAnswer(text: "It's for an object that coordinates the processing of specific low-level system events.", isCorrect: false),
            IDQAnswer(text: "It's for setting the execution priority, to apply to tasks.", isCorrect: true)
        ]
    ),
    
    IDQQuestion(
        question: "Which qualty of service class has the lowest priority level?",
        explanation: "The background tasks have the lowest priority level of all tasks.",
        reference: "https://developer.apple.com/documentation/dispatch/dispatchqos/1780981-background",
        difficulty: .hard,
        topic: .basics,
        answers: [
            IDQAnswer(text: "userInitiated", isCorrect: false),
            IDQAnswer(text: "default", isCorrect: false),
            IDQAnswer(text: "utility", isCorrect: false),
            IDQAnswer(text: "background", isCorrect: true)
        ]
    ),
    
    IDQQuestion(
        question: "How would you set the position of a task's importance within its assigned quality of service (QoS) class?",
        explanation: "By setting the relativePriority of the service property.",
        reference: "https://developer.apple.com/documentation/dispatch/dispatchqos/1780953-relativepriority",
        difficulty: .hard,
        topic: .basics,
        answers: [
            IDQAnswer(text: "By using a semaphore to manage the priority", isCorrect: false),
            IDQAnswer(text: "With the priorityLevel property", isCorrect: false),
            IDQAnswer(text: "The priority in the same service class is fixed and can't be modified.", isCorrect: false),
            IDQAnswer(text: "With the relativePriority property", isCorrect: true)
        ]
    ),
    
    IDQQuestion(
        question: "What is a defer statement?",
        explanation: "A defer statement is used for executing code just before transferring program control outside of the scope that the defer statement appears in.",
        reference: "https://docs.swift.org/swift-book/documentation/the-swift-programming-language/statements/#Defer-Statement",
        difficulty: .medium,
        topic: .basics,
        answers: [
            IDQAnswer(text: "Inside switch statements the code within a defer case is executed only if no other cases match the control expression", isCorrect: false),
            IDQAnswer(text: "It causes a program to end execution of the current scope and begin error propagation to its enclosing scope.", isCorrect: false),
            IDQAnswer(text: "It is used to declare a function with a default value.", isCorrect: false),
            IDQAnswer(text: "It's used to execute a block of code just before the current scope is exited", isCorrect: true)
        ]
    ),
    
    IDQQuestion(
        question: "With what tools can you catch changes in a property's value in Swift?",
        explanation: "With property observers. The \"willSet\" and \"didSet\" observeres are called before/after a change in the observed property's value.",
        reference: "https://docs.swift.org/swift-book/documentation/the-swift-programming-language/properties/#Property-Observers",
        difficulty: .medium,
        topic: .basics,
        answers: [
            IDQAnswer(text: "With the defer statement", isCorrect: false),
            IDQAnswer(text: "With the @notify keyword and a unique notification identifier", isCorrect: false),
            IDQAnswer(text: "With property wrappers", isCorrect: false),
            IDQAnswer(text: "With property observers", isCorrect: true)
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
            IDQAnswer(text: "1", isCorrect: false),
            IDQAnswer(text: "2", isCorrect: false),
            IDQAnswer(text: "6", isCorrect: false),
            IDQAnswer(text: "4", isCorrect: true)
        ]
    ),
    
    IDQQuestion(
        question: "In UIKit when loading a view controller what method is called first from the listed below?",
        explanation: "The loadView() is called before the controller's view is loaded into memory.",
        reference: "https://developer.apple.com/documentation/uikit/uiviewcontroller/1621454-loadview",
        difficulty: .easy,
        topic: .uikit,
        answers: [
            IDQAnswer(text: "windowDidAppear()", isCorrect: false),
            IDQAnswer(text: "viewWillAppear", isCorrect: false),
            IDQAnswer(text: "viewDidLoad()", isCorrect: false),
            IDQAnswer(text: "loadView()", isCorrect: true)
        ]
    ),
    
    IDQQuestion(
        question: "In UIKit how can you programatically set a view controller (ExampleViewController) to be the first presented when launching the app?",
        explanation: "By setting the window property's rootViewController to ExampleViewController in the app's SceneDelegate.",
        reference: nil,
        difficulty: .medium,
        topic: .uikit,
        answers: [
            IDQAnswer(text: "By setting the ExampleViewController's level property to 0 inside the AppDelegate.", isCorrect: false),
            IDQAnswer(text: "By setting the isRottViewController property of the ExampleViewController to true in the SceneDelegate.", isCorrect: false),
            IDQAnswer(text: "By calling the app's root view controller's present() method in the AppDelegate.", isCorrect: false),
            IDQAnswer(text: "By setting the window property's rootViewController to ExampleViewController in the app's SceneDelegate.", isCorrect: true)
        ]
    ),
    
    IDQQuestion(
        question: "When setting custom constraints to a UI element we should set the element's ______________.",
        explanation: "If you want to use Auto Layout to dynamically calculate the size and position of your view, you must set this property to false",
        reference: "https://developer.apple.com/documentation/uikit/uiview/1622572-translatesautoresizingmaskintoco",
        difficulty: .easy,
        topic: .uikit,
        answers: [
            IDQAnswer(text: "clipsToBounds property to true", isCorrect: false),
            IDQAnswer(text: "clipsToBounds property to false", isCorrect: false),
            IDQAnswer(text: "translatesAutoresizingMaskIntoConstraints property to true", isCorrect: false),
            IDQAnswer(text: "translatesAutoresizingMaskIntoConstraints property to false", isCorrect: true)
        ]
    ),
    
    IDQQuestion(
        question: "Regarding the difference between push and modal segues which of the below statements is true?",
        explanation: "Push segues require a navigation view controller. The presented view controller has a back button and it, by default covers the entire screen.",
        reference: "https://developer.apple.com/library/archive/featuredarticles/ViewControllerPGforiPhoneOS/UsingSegues.html",
        difficulty: .medium,
        topic: .uikit,
        answers: [
            IDQAnswer(text: "The modal segue is only used for storyboard-based transitions, the push segue is for programatic transitions.", isCorrect: false),
            IDQAnswer(text: "The push segue presents the new content modally over the source view controller. ", isCorrect: false),
            IDQAnswer(text: "Modal segues have a back button built in the presented view controller by default", isCorrect: false),
            IDQAnswer(text: "Push segues require a navigation controller but modal segues don't", isCorrect: true)
        ]
    ),
    
    IDQQuestion(
        question: "What methods are required to be implemented when adopting the UICollectionViewDataSource protocol?",
        explanation: "At a minimum, all data source objects must implement the collectionView(_:numberOfItemsInSection:) and collectionView(_:cellForItemAt:) methods.",
        reference: "https://developer.apple.com/documentation/uikit/uicollectionviewdatasource",
        difficulty: .medium,
        topic: .uikit,
        answers: [
            IDQAnswer(text: "The UICollectionViewDataSource protocol has no required methods.", isCorrect: false),
            IDQAnswer(text: " collectionView(_:didSelectItemAt:) \n collectionView(_:numberOfItemsInSection:) \n  collectionView(_:cellForItemAt:)", isCorrect: false),
            IDQAnswer(text: " collectionView(_:numberOfItemsInSection:) \n collectionView(_:layout:sizeForItemAt:)", isCorrect: false),
            IDQAnswer(text: "collectionView(_:numberOfItemsInSection:) \n collectionView(_:cellForItemAt:)", isCorrect: true)
        ]
    ),
    
]
