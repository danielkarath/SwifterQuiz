//
//  IDQQuestion.swift
//  iOSDevQuiz
//
//  Created by Daniel Karath on 3/8/23.
//

import Foundation

enum IDQReference: String, CaseIterable, Codable {
    case appleDocumentation = "Apple Documentation"
    case swiftDocumentation = "swift.org"
    case wikipedia = "wikipedia"
}

enum IDQQuestionDifficulty: String, CaseIterable, Codable {
    case veryEasy = "very easy"
    case easy = "easy"
    case medium = "medium"
    case hard = "hard"
    case veryHard = "very hard"
}

struct IDQQuestion: Codable {
    let question: String
    var questionSerialNum: Int
    let explanation: String
    let reference: IDQReference?
    let referenceURLString: String?
    let difficulty: IDQQuestionDifficulty
    let topic: IDQTopic
    let answers: [IDQAnswer]
}

class IDQQuestionArrayValueTransformer: ValueTransformer {
    private let encoder = JSONEncoder()
    private let decoder = JSONDecoder()
    
    override func transformedValue(_ value: Any?) -> Any? {
        guard let questions = value as? [IDQQuestion] else { return nil }
        return try? encoder.encode(questions)
    }
    
    override func reverseTransformedValue(_ value: Any?) -> Any? {
        guard let data = value as? Data else { return nil }
        return try? decoder.decode([IDQQuestion].self, from: data)
    }
}

let fullQuestionList = quickQuizQuestionList.enumerated().map { (index, question) in
    var updatedQuestion = question
    updatedQuestion.questionSerialNum = index + 1
    return updatedQuestion
}

let quickQuizQuestionList: [IDQQuestion] = [
    
    //MARK: - Basics
    
    IDQQuestion(
        question: "The creation of a data object to a specific state or value is called __________.",
        questionSerialNum: 0,
        explanation: "Initialization is the creation of a data object.",
        reference: .wikipedia  ,
        referenceURLString: "https://en.wikipedia.org/wiki/Initialization_(programming)",
        difficulty: .veryEasy,
        topic: .basics,
        answers: [
            IDQAnswer(text: "version control", answerType: .wrong),
            IDQAnswer(text: "refactoring", answerType: .wrong),
            IDQAnswer(text: "inheritance", answerType: .wrong ),
            IDQAnswer(text: "initialization", answerType: .correct),
        ]
    ),
    
    IDQQuestion(
        question: "What is the keyword used to declare constants in Swift?",
        questionSerialNum: 0,
        explanation: "Constants are declared with the let keyword. Variables are with var.",
        reference: .swiftDocumentation,
        referenceURLString: "https://docs.swift.org/swift-book/documentation/the-swift-programming-language/thebasics#Declaring-Constants-and-Variables",
        difficulty: .veryEasy,
        topic: .basics,
        answers: [
            IDQAnswer(text: "val", answerType: .wrong),
            IDQAnswer(text: "final", answerType: .wrong),
            IDQAnswer(text: "const", answerType: .wrong ),
            IDQAnswer(text: "let", answerType: .correct),
        ]
    ),
    
    IDQQuestion(
        question: "What is the result of -11 % 4 ?",
        questionSerialNum: 0,
        explanation: "The correct answer is: -3 The remainder operator (a % b) works out how many multiples of b will fit inside a and returns the value that’s left over (known as the remainder).",
        reference: .swiftDocumentation,
        referenceURLString: "https://docs.swift.org/swift-book/documentation/the-swift-programming-language/basicoperators#Remainder-Operator",
        difficulty: .veryEasy,
        topic: .basics,
        answers: [
            IDQAnswer(text: "-1", answerType: .wrong),
            IDQAnswer(text: "-2", answerType: .wrong),
            IDQAnswer(text: "1", answerType: .wrong ),
            IDQAnswer(text: "-3", answerType: .correct),
        ]
    ),
    
    IDQQuestion(
        question: "How would you call the below function?\nfunc didGet(_ points: Int?)",
        questionSerialNum: 0,
        explanation: "didGet(5)\nThe function has an underscore as an external parameter label, which indicates that it does't have an external name when calling the function. Points is it's internal parameter label.",
        reference: .swiftDocumentation,
        referenceURLString: "https://docs.swift.org/swift-book/documentation/the-swift-programming-language/functions/#Defining-and-Calling-Functions",
        difficulty: .veryEasy,
        topic: .basics,
        answers: [
            IDQAnswer(text: "didGet(points: nil) ", answerType: .wrong),
            IDQAnswer(text: "didGet()", answerType: .wrong),
            IDQAnswer(text: "didGet(points: 5)", answerType: .wrong ),
            IDQAnswer(text: "didGet(5) ", answerType: .correct),
        ]
    ),
    
    IDQQuestion(
        question: "__________ is the mechanism in object-oriented programming where a class can derive properties and behavior from a parent class.",
        questionSerialNum: 0,
        explanation: "In object-oriented programming, inheritance is the mechanism of basing an object or class upon another object or class.",
        reference: .swiftDocumentation,
        referenceURLString: "https://docs.swift.org/swift-book/documentation/the-swift-programming-language/inheritance/",
        difficulty: .veryEasy,
        topic: .basics,
        answers: [
            IDQAnswer(text: "polymorphism", answerType: .wrong),
            IDQAnswer(text: "enumeration", answerType: .wrong),
            IDQAnswer(text: "initialization", answerType: .wrong ),
            IDQAnswer(text: "inheritance", answerType: .correct),
        ]
    ),
    
    IDQQuestion(
        question: "The __________ keyword is used to indicate that a subclass is providing its own implementation of a method or property inherited from a superclass.",
        questionSerialNum: 0,
        explanation: "In object-oriented programming, inheritance is the mechanism of basing an object or class upon another object or class.",
        reference: .swiftDocumentation,
        referenceURLString: "https://docs.swift.org/swift-book/documentation/the-swift-programming-language/inheritance/#Overriding",
        difficulty: .veryEasy,
        topic: .basics,
        answers: [
            IDQAnswer(text: "defer", answerType: .wrong),
            IDQAnswer(text: "mutating", answerType: .wrong),
            IDQAnswer(text: "init", answerType: .wrong ),
            IDQAnswer(text: "override", answerType: .correct),
        ]
    ),
    
    IDQQuestion(
        question: "What is the logical 'or' operator in Swift?",
        questionSerialNum: 0,
        explanation: "The logical OR operator is || in Swift",
        reference: .appleDocumentation,
        referenceURLString: "https://developer.apple.com/documentation/swift/operator-declarations",
        difficulty: .veryEasy,
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
        questionSerialNum: 0,
        explanation: "condition ? valueIfTrue : valueIfFalse",
        reference: .appleDocumentation,
        referenceURLString: "https://developer.apple.com/documentation/swift/operator-declarations",
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
        question: "What is optional binding in Swift?",
        questionSerialNum: 0,
        explanation: "Constants are declared with the let keyword. Variables are with var.",
        reference: .swiftDocumentation,
        referenceURLString: "https://docs.swift.org/swift-book/documentation/the-swift-programming-language/thebasics#Optional-Binding",
        difficulty: .veryEasy,
        topic: .basics,
        answers: [
            IDQAnswer(text: "It's the initialization of lazily declared properties.", answerType: .wrong),
            IDQAnswer(text: "A technique to declare optional variables without assigning a value.", answerType: .wrong),
            IDQAnswer(text: "A technique to force-unwrap optionals without checking for nil.", answerType: .wrong ),
            IDQAnswer(text: "A way to find out if an optional contains a value, and if so, to make that value available as a temporary constant or variable.", answerType: .correct),
        ]
    ),
    
    IDQQuestion(
        question: "What is the best way to get every non-nil elements of an array?",
        questionSerialNum: 0,
        explanation: "Returns an array containing the non-nil results of calling the given transformation with each element of this sequence.",
        reference: .appleDocumentation,
        referenceURLString: "https://developer.apple.com/documentation/swift/sequence/compactmap(_:)",
        difficulty: .medium,
        topic: .basics,
        answers: [
            IDQAnswer(text: "Use a loop to iterate through the array and remove the nil elements.", answerType: .wrong),
            IDQAnswer(text: "Use the filter() to filter out nil elements from the array.", answerType: .wrong),
            IDQAnswer(text: "Use the flatMap(_:) method to transform and filter out nil elements from the array.", answerType: .wrong ),
            IDQAnswer(text: "Use the compactMap(_:) method to transform and filter out nil elements from the array.", answerType: .correct),
        ]
    ),
    
    IDQQuestion(
        question: "What are labeled statements in Swift?",
        questionSerialNum: 0,
        explanation: "Labeled Statements are statements with a name identifier, allowing control transfer statements to refer to them. You can use a statement label with the break keyword to end the execution of the labeled statement. This is mostly used in nested loops.",
        reference: .swiftDocumentation,
        referenceURLString: "https://docs.swift.org/swift-book/documentation/the-swift-programming-language/controlflow#Labeled-Statements",
        difficulty: .medium,
        topic: .basics,
        answers: [
            IDQAnswer(text: "Statements with a return type, referring to functions or methods that return a value.", answerType: .wrong),
            IDQAnswer(text: "Statements using didSet and willSet, which are property observers in Swift.", answerType: .wrong),
            IDQAnswer(text: "Statements inside a closure, executed in response to an event or asynchronously.", answerType: .wrong),
            IDQAnswer(text: "Statements with a name identifier, allowing control transfer statements to refer to them.", answerType: .correct),
        ]
    ),
    
    IDQQuestion(
        question: "What is the prefix(_:) method used for?",
        questionSerialNum: 0,
        explanation: "Returns a subsequence, up to the specified maximum length, containing the initial elements of the collection.",
        reference: .appleDocumentation,
        referenceURLString: "https://developer.apple.com/documentation/swift/string/prefix(_:)",
        difficulty: .easy,
        topic: .basics,
        answers: [
            IDQAnswer(text: "It replaces the first element of an array with a specified element of the same type", answerType: .wrong),
            IDQAnswer(text: "It replaces the first element of a String with a specified Character", answerType: .wrong),
            IDQAnswer(text: "It returns the element on the specified index from a collection", answerType: .wrong ),
            IDQAnswer(text: "It returns a subsequence from the beginning of a collection to the specified maximum length", answerType: .correct),
        ]
    ),
    
    IDQQuestion(
        question: "What happens if you run this code?\nlet numbers = [0, 10, 10]\nprint(numbers.prefix(10))",
        questionSerialNum: 0,
        explanation: "The console will print out the entire array. If the maximum length exceeds the number of elements in the collection, the result contains all the elements in the collection.",
        reference: .appleDocumentation,
        referenceURLString: "https://developer.apple.com/documentation/swift/string/prefix(_:)",
        difficulty: .medium,
        topic: .basics,
        answers: [
            IDQAnswer(text: "Nothing will be printed out, because the array has less elements", answerType: .wrong),
            IDQAnswer(text: "The console will print \"[10, 0, 10, 10]\"", answerType: .wrong ),
            IDQAnswer(text: "The console will print \"2\"", answerType: .wrong),
            IDQAnswer(text: "The console will print \"[0, 10, 10]\"", answerType: .correct),
        ]
    ),
    
    IDQQuestion(
        question: "Which prints out the highest number?\nvar x: Double = 4.50",
        questionSerialNum: 0,
        explanation: "The rounded() will return the highest number, 5.",
        reference: .appleDocumentation,
        referenceURLString: "https://developer.apple.com/documentation/swift/double/rounded(_:)",
        difficulty: .easy,
        topic: .basics,
        answers: [
            IDQAnswer(text: "print(x.scale(by: 2))", answerType: .wrong),
            IDQAnswer(text: "print(x.rounded(.toNearestOrEven))", answerType: .wrong ),
            IDQAnswer(text: "print(x.ceil)", answerType: .wrong),
            IDQAnswer(text: "print(x.rounded())", answerType: .correct),
        ]
    ),
    
    IDQQuestion(
        question: "What does UserDefaults.standard.integer(forKey:) return if the value for the key is absent?",
        questionSerialNum: 0,
        explanation: "The integer value associated with the specified key. If the specified key doesn‘t exist, this method returns 0.",
        reference: .appleDocumentation,
        referenceURLString: "https://developer.apple.com/documentation/foundation/userdefaults/1407405-integer",
        difficulty: .medium,
        topic: .basics,
        answers: [
            IDQAnswer(text: "nil", answerType: .wrong),
            IDQAnswer(text: "Nothing, it throws an error", answerType: .wrong ),
            IDQAnswer(text: "Nothing, but does not throw error", answerType: .wrong),
            IDQAnswer(text: "0", answerType: .correct),
        ]
    ),
    
    IDQQuestion(
        question: "What will be printed out by using the below code?\nlet abc = [\"A\", \"B\", \"A\", \"C\"]\nprint(abc.sorted(by: >=))",
        questionSerialNum: 0,
        explanation: "[\"C\", \"B\", \"A\", \"A\"]",
        reference: .appleDocumentation,
        referenceURLString: "https://developer.apple.com/documentation/swift/array/sort()",
        difficulty: .easy,
        topic: .basics,
        answers: [
            IDQAnswer(text: "Nothing, the code contains an error", answerType: .wrong),
            IDQAnswer(text: "[\"A\", \"A\", \"B\", \"C\"]", answerType: .wrong ),
            IDQAnswer(text: "[\"A\", \"B\", \"A\", \"C\"]", answerType: .wrong),
            IDQAnswer(text: "[\"C\", \"B\", \"A\", \"A\"]", answerType: .correct),
        ]
    ),
    
    IDQQuestion(
        question: "The __________ type represents a character made up of one (or more) Unicode scalar values.",
        questionSerialNum: 0,
        explanation: "The Character represents a single extended grapheme cluster, which is a sequence of one or more Unicode scalars that produce a single human-readable letter or symbol.",
        reference: .appleDocumentation,
        referenceURLString: "https://developer.apple.com/documentation/swift/character",
        difficulty: .veryEasy,
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
        questionSerialNum: 0,
        explanation: "A selector expression lets you access the selector used to refer to a method or to a property’s getter or setter in Objective-C.",
        reference: .swiftDocumentation,
        referenceURLString: "https://docs.swift.org/swift-book/documentation/the-swift-programming-language/expressions/#Selector-Expression",
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
        question: "How can you STOP a switch statement from completing its execution as soon as the first matching case is completed?",
        questionSerialNum: 0,
        explanation: "By adding the fallthrough keyword to it's cases.",
        reference: .swiftDocumentation,
        referenceURLString: "https://docs.swift.org/swift-book/documentation/the-swift-programming-language/controlflow/#Fallthrough",
        difficulty: .medium,
        topic: .basics,
        answers: [
            IDQAnswer(text: "By default the switch statments iterate through each case regardless of matching them", answerType: .wrong),
            IDQAnswer(text: "By adding the pass keyword to it's case(s)", answerType: .wrong),
            IDQAnswer(text: "By adding fallthrough before the switch keyword and pass to it's relevant case(s)", answerType: .wrong ),
            IDQAnswer(text: "By adding fallthrough to it's case(s)", answerType: .correct),
        ]
    ),
    
    IDQQuestion(
        question: "What is the difference between a while and a repeat-while control flow statment in Swift?",
        questionSerialNum: 0,
        explanation: "The repeat-while loop performs a single pass through the loop block first, before considering the loop’s condition.",
        reference: .swiftDocumentation,
        referenceURLString: "https://docs.swift.org/swift-book/documentation/the-swift-programming-language/controlflow/#Repeat-While",
        difficulty: .hard,
        topic: .basics,
        answers: [
            IDQAnswer(text: "There is no repeat-while in Swift only do-while", answerType: .wrong),
            IDQAnswer(text: "A repeat-while requires it's condition to be true and a minimum number of iterations to exit", answerType: .wrong),
            IDQAnswer(text: "The repeat-while loop evaluates its condition at the end of each iterations", answerType: .wrong ),
            IDQAnswer(text: "A repeat-while loop will always execute at least once,", answerType: .correct),
        ]
    ),
    
    IDQQuestion(
        question: "What is the difference between Any and AnyObject?",
        questionSerialNum: 0,
        explanation: "Any is a protocol that represents any type at all, including class types, struct types, enum types, and protocol types.. AnyObject is a protocol that represents any instance of a class type.",
        reference: .appleDocumentation,
        referenceURLString: "https://developer.apple.com/documentation/swift/anyobject",
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
        questionSerialNum: 0,
        explanation: "A type annotation explicitly specifies the type of a variable or expression.\nExample: let size: CGFloat = 10.0",
        reference: .swiftDocumentation,
        referenceURLString: "https://docs.swift.org/swift-book/documentation/the-swift-programming-language/types/#Type-Annotation",
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
        questionSerialNum: 0,
        explanation: "The Character type represents a character made up of one or more Unicode scalar values, grouped by a Unicode boundary algorithm.",
        reference: .swiftDocumentation,
        referenceURLString: "https://docs.swift.org/swift-book/documentation/the-swift-programming-language/stringsandcharacters/#Multiline-String-Literals",
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
        questionSerialNum: 0,
        explanation: "A deinitializer is called immediately before a class instance is deallocated.",
        reference: .swiftDocumentation,
        referenceURLString: "https://docs.swift.org/swift-book/documentation/the-swift-programming-language/deinitialization/",
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
        questionSerialNum: 0,
        explanation: "A tuple type is a comma-separated list of types, that can be of different types and is enclosed in parentheses.",
        reference: .swiftDocumentation,
        referenceURLString: "https://docs.swift.org/swift-book/documentation/the-swift-programming-language/types/#Tuple-Type",
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
        questionSerialNum: 0,
        explanation: "It's a combination of Decodable and Encodable. With it you can convert objects to and from a serialized format, such as JSON, that can be easily transmitted or stored.",
        reference: .appleDocumentation,
        referenceURLString: "https://developer.apple.com/documentation/swift/codable",
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
        questionSerialNum: 0,
        explanation: "Enum stands for enumeration, and it defines a common type for a group of related values",
        reference: .swiftDocumentation,
        referenceURLString: "https://docs.swift.org/swift-book/documentation/the-swift-programming-language/enumerations/",
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
        questionSerialNum: 0,
        explanation: "An interface to the user’s defaults database, where you store key-value pairs persistently across launches of your app.",
        reference: .appleDocumentation,
        referenceURLString: "https://developer.apple.com/documentation/foundation/userdefaults",
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
        questionSerialNum: 0,
        explanation: "An associated type gives a placeholder name to a type that’s used as part of the protocol.",
        reference: .swiftDocumentation,
        referenceURLString: "https://docs.swift.org/swift-book/documentation/the-swift-programming-language/generics/#Associated-Types",
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
        questionSerialNum: 0,
        explanation: "An opaque type is a way to hide the underlying implementation details of a type",
        reference: .swiftDocumentation,
        referenceURLString: "https://docs.swift.org/swift-book/documentation/the-swift-programming-language/opaquetypes",
        difficulty: .veryHard,
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
        questionSerialNum: 0,
        explanation: "A Set is unordered collection of unique elements. An Array is an ordered random-access collection.",
        reference: .appleDocumentation,
        referenceURLString: "https://developer.apple.com/documentation/swift/set",
        difficulty: .easy,
        topic: .basics,
        answers: [
            IDQAnswer(text: "An Array is a collection of elements that can be of different data types. A Set can only contain elements of the same data type.", answerType: .wrong),
            IDQAnswer(text: "An Array is a dynamic collection of elements, while a Set is static and immutable.", answerType: .wrong),
            IDQAnswer(text: "A Set can only store two elements, while an Array can store an unlimited number of elements.", answerType: .wrong),
            IDQAnswer(text: "An Array is a collection of elements that can contain duplicates and are ordered, while a Set is an unordered collection of unique elements", answerType: .correct),
        ]
    ),
    
    IDQQuestion(
        question: "What is an unordered collection of unique values?",
        questionSerialNum: 0,
        explanation: "A Set is unordered collection of unique elements.",
        reference: .appleDocumentation,
        referenceURLString: "https://developer.apple.com/documentation/swift/set",
        difficulty: .veryEasy,
        topic: .basics,
        answers: [
            IDQAnswer(text: "A Tuple \t", answerType: .wrong),
            IDQAnswer(text: "A Dictionary \t", answerType: .wrong),
            IDQAnswer(text: "An Array \t", answerType: .wrong),
            IDQAnswer(text: "A Set \t", answerType: .correct),
        ]
    ),
    
    IDQQuestion(
        question: "How would you create a new Set that contains all the elements that are contained in both Set a and Set b?\nlet a: Set = [1, 2, 3, 4, 5]\nlet b: Set = [0, 2, 4, 6, 8]",
        questionSerialNum: 0,
        explanation: "The let c = a.intersection(b) is the correct answer. The intersection(_:) returns a new set with the elements that are common to both this set and the given sequence. A a.filter { b.contains($0) } would also work, but it's not among the answers.",
        reference: .swiftDocumentation,
        referenceURLString: "https://docs.swift.org/swift-book/documentation/the-swift-programming-language/collectiontypes#Fundamental-Set-Operations",
        difficulty: .hard,
        topic: .basics,
        answers: [
            IDQAnswer(text: "let c = a.compactMap { b.contains($0) }", answerType: .wrong),
            IDQAnswer(text: "let c = a.map { b.contains($0) }", answerType: .wrong),
            IDQAnswer(text: "let c = a.union(b)", answerType: .wrong),
            IDQAnswer(text: "let c = a.intersection(b)", answerType: .correct),
        ]
    ),
    
    IDQQuestion(
        question: "What is a Dictionary?",
        questionSerialNum: 0,
        explanation: "A collection whose elements are key-value pairs.",
        reference: .appleDocumentation,
        referenceURLString: "https://developer.apple.com/documentation/swift/dictionary",
        difficulty: .veryEasy,
        topic: .basics,
        answers: [
            IDQAnswer(text: "An unordered collection of unique elements.", answerType: .wrong),
            IDQAnswer(text: "A comma-separated list of types", answerType: .wrong),
            IDQAnswer(text: "A collection of ordered values.", answerType: .wrong),
            IDQAnswer(text: "A collection type that stores key-value pairs.", answerType: .correct),
        ]
    ),
    
    IDQQuestion(
        question: "What is the difference between a Float and a Double?",
        questionSerialNum: 0,
        explanation: "Double represents a 64-bit floating-point number while a Float represents a 32-bit floating-point number.",
        reference: .swiftDocumentation,
        referenceURLString: "https://docs.swift.org/swift-book/documentation/the-swift-programming-language/thebasics/#Floating-Point-Numbers",
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
        questionSerialNum: 0,
        explanation: "The application(_:willFinishLaunchingWithOptions:) tells the delegate that the launch process has begun but that state restoration hasn’t occured.",
        reference: .appleDocumentation,
        referenceURLString: "https://developer.apple.com/documentation/uikit/app_and_environment/responding_to_the_launch_of_your_app",
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
        question: "What is the difference between the open and public access control levels?",
        questionSerialNum: 0,
        explanation: "Open access applies only to classes and class members, and it differs from public access by allowing code outside the module to subclass and override",
        reference: .swiftDocumentation,
        referenceURLString: "https://docs.swift.org/swift-book/documentation/the-swift-programming-language/accesscontrol/#Access-Levels",
        difficulty: .hard,
        topic: .basics,
        answers: [
            IDQAnswer(text: "There is no difference", answerType: .wrong),
            IDQAnswer(text: "Open access applies only to struct and struct members", answerType: .wrong),
            IDQAnswer(text: "Open allows entities to be used only inside the module. Public allows entities to be used both inside and outside the module.", answerType: .wrong),
            IDQAnswer(text: "Open allows entities to be subclassed and overridden outside the module. Public only allows entities to be used outside the module.", answerType: .correct),
        ]
    ),
    
    IDQQuestion(
        question: "Which access control level is the most restrictive in Swift?",
        questionSerialNum: 0,
        explanation: "Private is the most restrictive and open is the least restrictive access control level",
        reference: .swiftDocumentation,
        referenceURLString: "https://docs.swift.org/swift-book/documentation/the-swift-programming-language/accesscontrol/#Access-Levels",
        difficulty: .medium,
        topic: .basics,
        answers: [
            IDQAnswer(text: "protected \t", answerType: .wrong),
            IDQAnswer(text: "internal \t", answerType: .wrong),
            IDQAnswer(text: "fileprivate \t", answerType: .wrong),
            IDQAnswer(text: "private \t", answerType: .correct),
        ]
    ),
    
    IDQQuestion(
        question: "Which access control level is NOT supported in Swift?",
        questionSerialNum: 0,
        explanation: "The access control levels supported in Swift are open, public, internal, fileprivate and private.",
        reference: .appleDocumentation,
        referenceURLString: "https://developer.apple.com/swift/blog/?id=11",
        difficulty: .easy,
        topic: .basics,
        answers: [
            IDQAnswer(text: "open \t", answerType: .wrong),
            IDQAnswer(text: "internal \t", answerType: .wrong),
            IDQAnswer(text: "fileprivate \t", answerType: .wrong),
            IDQAnswer(text: "protected \t", answerType: .correct),
        ]
    ),
    
    IDQQuestion(
        question: "What is the default access control level?",
        questionSerialNum: 0,
        explanation: "All entities in your code have a default access level of internal",
        reference: .swiftDocumentation,
        referenceURLString: "https://docs.swift.org/swift-book/documentation/the-swift-programming-language/accesscontrol/#Default-Access-Levels",
        difficulty: .easy,
        topic: .basics,
        answers: [
            IDQAnswer(text: "open \t", answerType: .wrong),
            IDQAnswer(text: "private \t", answerType: .wrong),
            IDQAnswer(text: "public \t", answerType: .wrong),
            IDQAnswer(text: "internal \t", answerType: .correct),
        ]
    ),
    
    IDQQuestion(
        question: "How is the default access control level calculated for functions in Swift?",
        questionSerialNum: 0,
        explanation: "By default it's calculated based on the most restrictive access level of the functions parameters and return types",
        reference: .swiftDocumentation,
        referenceURLString: "https://docs.swift.org/swift-book/documentation/the-swift-programming-language/accesscontrol/#Function-Types",
        difficulty: .hard,
        topic: .basics,
        answers: [
            IDQAnswer(text: "By default the access control level is internal", answerType: .wrong),
            IDQAnswer(text: "By default the access control level is public", answerType: .wrong),
            IDQAnswer(text: "The least restrictive access level of the function’s parameter types and return type.", answerType: .wrong),
            IDQAnswer(text: "The most restrictive access level of the function’s parameter types and return type.", answerType: .correct),
        ]
    ),
    
    IDQQuestion(
        question: "What does @frozen attribute stand for?",
        questionSerialNum: 0,
        explanation: "Apply this attribute to a structure or enumeration declaration to restrict the kinds of changes you can make to the type.",
        reference: .swiftDocumentation,
        referenceURLString: "https://docs.swift.org/swift-book/documentation/the-swift-programming-language/attributes/#frozen",
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
        questionSerialNum: 0,
        explanation: "StringProtocol conforms to: BidirectionalCollection, Comparable, ExpressibleByStringInterpolation, Hashable, LosslessStringConvertible, TextOutputStream, TextOutputStreamable",
        reference: .appleDocumentation,
        referenceURLString: "https://developer.apple.com/documentation/swift/stringprotocol",
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
        questionSerialNum: 0,
        explanation: "A universally unique value to identify types, interfaces, and other items.",
        reference: .appleDocumentation,
        referenceURLString: "https://developer.apple.com/documentation/foundation/uuid",
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
        questionSerialNum: 0,
        explanation: "A lazy stored property is a property whose initial value isn’t calculated until the first time it’s used.",
        reference: .swiftDocumentation,
        referenceURLString: "https://docs.swift.org/swift-book/documentation/the-swift-programming-language/properties/#Lazy-Stored-Properties",
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
        questionSerialNum: 0,
        explanation: "The append(_:) method adds a new element to the end of the Array and the insert(_: at: ) adds a new element to a specific index.",
        reference: .appleDocumentation,
        referenceURLString: "https://developer.apple.com/documentation/swift/array/insert(_:at:)-3erb3",
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
        questionSerialNum: 0,
        explanation: "The zip() method combines two arrays into a single array of tuples, where each tuple contains one element from each of the input arrays at the same index.",
        reference: .appleDocumentation,
        referenceURLString: "https://developer.apple.com/documentation/swift/zip(_:_:)",
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
        questionSerialNum: 0,
        explanation: "A value that represents either a success or a failure, including an associated value in each case.",
        reference: .appleDocumentation,
        referenceURLString: "https://developer.apple.com/documentation/swift/result",
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
        questionSerialNum: 0,
        explanation: "With the guard statement we can implement checks into our code that prevents the current scope from continuing if certain conditions are not met.",
        reference: .swiftDocumentation,
        referenceURLString: "https://docs.swift.org/swift-book/documentation/the-swift-programming-language/statements/#Guard-Statement",
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
        questionSerialNum: 0,
        explanation: "Delegation is a design pattern that enables a class or structure to hand off (or delegate) some of its responsibilities to an instance of another type. Think of a delegator as a boss and a delegate as an employee.",
        reference: .swiftDocumentation,
        referenceURLString: "https://docs.swift.org/swift-book/documentation/the-swift-programming-language/protocols/#Delegation",
        difficulty: .medium,
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
        questionSerialNum: 0,
        explanation: "Notifications can have multiple observers, they are flexible and notifications are delivered asynchronously.",
        reference: nil,
        referenceURLString: nil,
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
        questionSerialNum: 0,
        explanation: "Both the notification pattern and key-value observing pattern is capable of it.",
        reference: nil,
        referenceURLString: nil,
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
        questionSerialNum: 0,
        explanation: "KVO: Key-Value Observing which is a commonly used design pattern.",
        reference: .appleDocumentation,
        referenceURLString: "https://developer.apple.com/documentation/swift/using-key-value-observing-in-swift",
        difficulty: .medium,
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
        questionSerialNum: 0,
        explanation: "In the Model-View-Controller (MVC) design pattern the V stands for View",
        reference: .appleDocumentation,
        referenceURLString: "https://developer.apple.com/library/archive/documentation/General/Conceptual/DevPedia-CocoaCore/MVC.html",
        difficulty: .veryEasy,
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
        questionSerialNum: 0,
        explanation: "The Controller mediates between the view and the model via the delegation pattern.",
        reference: .appleDocumentation,
        referenceURLString: "https://developer.apple.com/library/archive/documentation/General/Conceptual/DevPedia-CocoaCore/MVC.html",
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
        questionSerialNum: 0,
        explanation: "The 'R' in VIPER stands for Router which alone handles navigation between screens.",
        reference: nil,
        referenceURLString: nil,
        difficulty: .hard,
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
        questionSerialNum: 0,
        explanation: "VIPER as View-Interactor-Presenter-Entity-Router",
        reference: nil,
        referenceURLString: nil,
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
        questionSerialNum: 0,
        explanation: "A software design pattern that restricts the instantiation of a class to a singular instance.",
        reference: .appleDocumentation,
        referenceURLString: "https://developer.apple.com/library/archive/documentation/General/Conceptual/DevPedia-CocoaCore/Singleton.html",
        difficulty: .easy,
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
        questionSerialNum: 0,
        explanation: "With the @objc optional keywords. Note that all conforming types must be Objective-C compatible.",
        reference: .swiftDocumentation,
        referenceURLString: "https://docs.swift.org/swift-book/documentation/the-swift-programming-language/protocols/#Optional-Protocol-Requirements",
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
        questionSerialNum: 0,
        explanation: "4 constraints are required to properly define the position of a UI element.",
        reference: nil,
        referenceURLString: nil,
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
        questionSerialNum: 0,
        explanation: "The print(\"first\") is executed firstly on the current thread. The rest is scheduled to be executed asynchronously on the main thread at some point in the future.",
        reference: nil,
        referenceURLString: nil,
        difficulty: .easy,
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
        questionSerialNum: 0,
        explanation: "The main thread generally focuses on UI changes, the background threads for lengthier tasks",
        reference: .appleDocumentation,
        referenceURLString: "https://developer.apple.com/documentation/dispatch/dispatchqueue",
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
        questionSerialNum: 0,
        explanation: "The Dispatch Quality of Service sets the execution priority of tasks. It categorizes work to perform on a DispatchQueue. By specifying the quality of a task, you indicate its importance to your app.",
        reference: .appleDocumentation,
        referenceURLString: "https://developer.apple.com/documentation/dispatch/dispatchqos",
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
        questionSerialNum: 0,
        explanation: "The background tasks have the lowest priority level of all tasks.",
        reference: .appleDocumentation,
        referenceURLString: "https://developer.apple.com/documentation/dispatch/dispatchqos/1780981-background",
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
        questionSerialNum: 0,
        explanation: "By setting the relativePriority of the service property.",
        reference: .appleDocumentation,
        referenceURLString: "https://developer.apple.com/documentation/dispatch/dispatchqos/1780953-relativepriority",
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
        questionSerialNum: 0,
        explanation: "A defer statement is used for executing code just before transferring program control outside of the scope that the defer statement appears in.",
        reference: .swiftDocumentation,
        referenceURLString: "https://docs.swift.org/swift-book/documentation/the-swift-programming-language/statements/#Defer-Statement",
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
        questionSerialNum: 0,
        explanation: "With property observers. The \"willSet\" and \"didSet\" observeres are called before/after a change in the observed property's value.",
        reference: .swiftDocumentation,
        referenceURLString: "https://docs.swift.org/swift-book/documentation/the-swift-programming-language/properties/#Property-Observers",
        difficulty: .medium,
        topic: .basics,
        answers: [
            IDQAnswer(text: "With the defer statement", answerType: .wrong),
            IDQAnswer(text: "With the @notify keyword and a unique notification identifier", answerType: .wrong),
            IDQAnswer(text: "With property wrappers", answerType: .wrong),
            IDQAnswer(text: "With property observers", answerType: .correct),
        ]
    ),
    
    IDQQuestion(
        question: "In which of the below cases can you avoid using a weak self?",
        questionSerialNum: 0,
        explanation: "Inside a UIView.animate closure [weak self] is not required because it is executed only once during the animation, and then it is deallocated from memory automatically.",
        reference: .swiftDocumentation,
        referenceURLString: "https://docs.swift.org/swift-book/documentation/the-swift-programming-language/automaticreferencecounting/#How-ARC-Works",
        difficulty: .medium,
        topic: .basics,
        answers: [
            IDQAnswer(text: "Inside a DispatchQueue.async block", answerType: .wrong),
            IDQAnswer(text: "Inside a URLSession completion handler ", answerType: .wrong),
            IDQAnswer(text: "You have to use in all of these options to avoid causing a retain cycle.", answerType: .wrong),
            IDQAnswer(text: "Inside a UIView.animate block", answerType: .correct),
        ]
    ),
    
    IDQQuestion(
        question: "What is initialzer injection?",
        questionSerialNum: 0,
        explanation: "Initialzer Injection is a software design pattern where we're passing dependencies through the init() method from the parent class. Typically this is done when initializing views with models, network managers, etc.",
        reference: .wikipedia,
        referenceURLString: "https://en.wikipedia.org/wiki/Dependency_injection",
        difficulty: .hard,
        topic: .basics,
        answers: [
            IDQAnswer(text: "When we're deferring object creation until needed to optimize performance.", answerType: .wrong),
            IDQAnswer(text: "When we're providing dependencies to an object by setting properties directly on the object.", answerType: .wrong),
            IDQAnswer(text: "When initializing properties directly in the class", answerType: .wrong),
            IDQAnswer(text: "When we're passing dependencies via the init() method from the parent class.", answerType: .correct),
        ]
    ),
    
    IDQQuestion(
        question: "What does a mutating function allow you to do when used inside a class?",
        questionSerialNum: 0,
        explanation: "Mutating functions cannot be used inside classes. Mutating functions are used with methods inside value types (struct or enum) to indicate that the method can modify the instance's properties. Using a mutating function in a class results in a compile-time error.",
        reference: .swiftDocumentation,
        referenceURLString: "https://docs.swift.org/swift-book/documentation/the-swift-programming-language/methods/#Modifying-Value-Types-from-Within-Instance-Methods",
        difficulty: .hard,
        topic: .basics,
        answers: [
            IDQAnswer(text: "Modify properties in a class without creating a new instance", answerType: .wrong),
            IDQAnswer(text: "It allows you to modify the methods properties inside the method body", answerType: .wrong),
            IDQAnswer(text: "Mutating functions cannot be used inside a class, as classes are value types.", answerType: .wrong),
            IDQAnswer(text: "Mutating functions cannot be used inside a class, as classes are reference types.", answerType: .correct),
        ]
    ),
    
    
    //MARK: - UIKit
    IDQQuestion(
        question: "In UIKit how many constraints are needed at minimum to correctly determine the position of a UI element?",
        questionSerialNum: 0,
        explanation: "4 constraints are required to properly define the position of a UI element.",
        reference: nil,
        referenceURLString: nil,
        difficulty: .veryEasy,
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
        questionSerialNum: 0,
        explanation: "The loadView() is called before the controller's view is loaded into memory.",
        reference: .appleDocumentation,
        referenceURLString: "https://developer.apple.com/documentation/uikit/uiviewcontroller/1621454-loadview",
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
        question: "In UIKit how can you programatically set a view controller (ExampleVC) to be the first presented when launching the app?",
        questionSerialNum: 0,
        explanation: "By setting the window property's rootViewController to ExampleVC in the app's SceneDelegate.",
        reference: nil,
        referenceURLString: nil,
        difficulty: .medium,
        topic: .uikit,
        answers: [
            IDQAnswer(text: "By setting the ExampleVC's level property to 0 inside the AppDelegate.", answerType: .wrong),
            IDQAnswer(text: "By setting the isRottViewController property of the ExampleVC to true in the SceneDelegate.", answerType: .wrong),
            IDQAnswer(text: "By calling the app's root view controller's present() method in the AppDelegate.", answerType: .wrong),
            IDQAnswer(text: "By setting the window property's rootViewController to ExampleVC in the app's SceneDelegate.", answerType: .correct),
        ]
    ),
    
    IDQQuestion(
        question: "When setting custom constraints to a UI element we should set the element's ______________.",
        questionSerialNum: 0,
        explanation: "If you want to use Auto Layout to dynamically calculate the size and position of your view, you must set this property to false",
        reference: .appleDocumentation,
        referenceURLString: "https://developer.apple.com/documentation/uikit/uiview/1622572-translatesautoresizingmaskintoco",
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
        questionSerialNum: 0,
        explanation: "Push segues require a navigation view controller. The presented view controller has a back button and it, by default covers the entire screen.",
        reference: .appleDocumentation,
        referenceURLString: "https://developer.apple.com/library/archive/featuredarticles/ViewControllerPGforiPhoneOS/UsingSegues.html",
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
        questionSerialNum: 0,
        explanation: "At a minimum, all data source objects must implement the collectionView(_:numberOfItemsInSection:) and collectionView(_:cellForItemAt:) methods.",
        reference: .appleDocumentation,
        referenceURLString: "https://developer.apple.com/documentation/uikit/uicollectionviewdatasource",
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
        questionSerialNum: 0,
        explanation: "The UITableView does not allow varying sized cells is the false statment. With the tableView(_:heightForRowAt:) method you can modify a given row's height.",
        reference: .appleDocumentation,
        referenceURLString: "https://developer.apple.com/documentation/uikit/uitableviewdelegate/1614998-tableview",
        difficulty: .easy,
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
        questionSerialNum: 0,
        explanation: "Use layoutIfNeeded() to force the view to update its layout immediately. When using Auto Layout, the layout engine updates the position of views as needed to satisfy changes in constraints.",
        reference: .appleDocumentation,
        referenceURLString: "https://developer.apple.com/documentation/uikit/uiview/1622507-layoutifneeded",
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
        questionSerialNum: 0,
        explanation: "automaticDimension is the default value that is used for the height or width of a UI element, such as a table view cell or a collection view cell.",
        reference: .appleDocumentation,
        referenceURLString: "https://developer.apple.com/documentation/uikit/uitableview/1614961-automaticdimension",
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
        question: "How can you implement a dynamic font size in UILabel?",
        questionSerialNum: 0,
        explanation: "By setting the adjustsFontSizeToFitWidth property true and specifying a minimumScaleFactor the label's fontsize will dynamically be set based on the label’s bounding rectangle.",
        reference: .appleDocumentation,
        referenceURLString: "https://developer.apple.com/documentation/uikit/uilabel/1620546-adjustsfontsizetofitwidth",
        difficulty: .medium,
        topic: .uikit,
        answers: [
            IDQAnswer(text: "Dynamic font size is only available in SwiftUI", answerType: .wrong),
            IDQAnswer(text: "By setting the label's adjustsFontSizeToFit property to true. Set its minimumScaleSize and maximumScaleSize to some CGFLoat values.", answerType: .wrong),
            IDQAnswer(text: "By setting the label's adjustsFontSizeToFit property to true and its minimumScaleFactor property to a value greater than or equal to 0.", answerType: .wrong),
            IDQAnswer(text: "By setting the label's adjustsFontSizeToFitWidth property to true and its minimumScaleFactor property to a value greater than or equal to 0.", answerType: .correct),
        ]
    ),
    
    IDQQuestion(
        question: "How can you horizontally center the text of a UILabel?",
        questionSerialNum: 0,
        explanation: "With the label's textAlignment property set to center",
        reference: .appleDocumentation,
        referenceURLString: "https://developer.apple.com/documentation/uikit/uilabel/1620541-textalignment",
        difficulty: .veryEasy,
        topic: .uikit,
        answers: [
            IDQAnswer(text: "By setting the label's centerXAnchor property to centered", answerType: .wrong),
            IDQAnswer(text: "By setting the label's layer.frame.horizontalAlignment property to center", answerType: .wrong),
            IDQAnswer(text: "By setting the label's contentMode property to center.", answerType: .wrong),
            IDQAnswer(text: "By setting the label's textAlignment property to center.", answerType: .correct),
        ]
    ),
    
    IDQQuestion(
        question: "When working with UIKit what would you use to make sure the user can enter a large amount of text into your app?",
        questionSerialNum: 0,
        explanation: "The UITextView is by default a multiline, scrollable text region which is perfect for entering or editing a larger body of text.",
        reference: .appleDocumentation,
        referenceURLString: "https://developer.apple.com/documentation/uikit/uitextview",
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
        questionSerialNum: 0,
        explanation: "The only slider Apple offers is the UISlider() which only allows the selection of a single value from a range of values. You need to use third party libraries or place two sliders on top of each other.",
        reference: .appleDocumentation,
        referenceURLString: "https://developer.apple.com/documentation/uikit/uicontrol",
        difficulty: .hard,
        topic: .uikit,
        answers: [
            IDQAnswer(text: "By using a UISlider() with it's numberOfThumbs property set to 2", answerType: .wrong),
            IDQAnswer(text: "By using a UIRangeSlider() that by default has two thumbs which allows range selection.", answerType: .wrong),
            IDQAnswer(text: "By using a UISlider() with it's numberOfThumbs property set to 2 and it's selectionStyle set to range", answerType: .wrong),
            IDQAnswer(text: "UIKit does not have a UIControl that allows this. You may have to use third party libraries", answerType: .correct),
        ]
    ),
    
    IDQQuestion(
        question: "How can you make the keyboard appear in UIKit?",
        questionSerialNum: 0,
        explanation: "By calling the becomeFirstResponder() method on a a UITextField or UITextView object.",
        reference: .appleDocumentation,
        referenceURLString: "https://developer.apple.com/documentation/uikit/uiresponder/1621113-becomefirstresponder",
        difficulty: .easy,
        topic: .uikit,
        answers: [
            IDQAnswer(text: "By setting isFirstResponder to true on a UIResponder object.", answerType: .wrong),
            IDQAnswer(text: "By setting isUserInteractionEnabled to true on a UIResponder object.", answerType: .wrong),
            IDQAnswer(text: "Call showKeyboard() on the view controller.", answerType: .wrong),
            IDQAnswer(text: "Call becomeFirstResponder() on a UITextField or UITextView.", answerType: .correct),
        ]
    ),
    
    IDQQuestion(
        question: "How is it possible to get the image data in a PNG format of a UIImage?",
        questionSerialNum: 0,
        explanation: "Use the image.pngData() function to get the image Data in a PNG format.",
        reference: .appleDocumentation,
        referenceURLString: "https://developer.apple.com/documentation/uikit/uiimage/1624096-pngdata",
        difficulty: .medium,
        topic: .uikit,
        answers: [
            IDQAnswer(text: "You have to convert it to a cgImage then use imagerawData(compressionQuality: .png).", answerType: .wrong),
            IDQAnswer(text: "You have to convert it to a cgImage then use image.pngData().", answerType: .wrong),
            IDQAnswer(text: "image.rawData(compressionQuality: .png)", answerType: .wrong),
            IDQAnswer(text: "image.pngData()", answerType: .correct),
        ]
    ),
    
    IDQQuestion(
        question: "When working with a UIAlertController which has a \"saveAction\" and a \"cancelAction\" action, how would you highlight the save action?",
        questionSerialNum: 0,
        explanation: "By setting the UIAlertController prefferedAction property to saveAction. TThe preferred action receives the highlighting instead of the cancel button in this case regardless of the UIAction styles decalered when creating the action.",
        reference: .appleDocumentation,
        referenceURLString: "https://developer.apple.com/documentation/uikit/uialertcontroller/1620102-preferredaction",
        difficulty: .medium,
        topic: .uikit,
        answers: [
            IDQAnswer(text: "The easiest way to achieve this is to add attributedStrings to the UIActions and format them accordingly.", answerType: .wrong),
            IDQAnswer(text: "By setting the saveAction style to preffered", answerType: .wrong),
            IDQAnswer(text: "By setting the saveAction style to .default", answerType: .wrong),
            IDQAnswer(text: "By setting the UIAlertController preferredAction property to saveAction", answerType: .correct),
        ]
    ),
    
    
    //MARK: - SwiftUI
    
    IDQQuestion(
        question: "Which statment is true?",
        questionSerialNum: 0,
        explanation: "SwiftUI follows the declarative while UIKit the imperative programming approach.",
        reference: .appleDocumentation,
        referenceURLString: "https://developer.apple.com/documentation/swiftui/declaring-a-custom-view",
        difficulty: .veryEasy,
        topic: .swiftui,
        answers: [
            IDQAnswer(text: "Both SwiftUI and UIKit follow the imperative programming approach.", answerType: .wrong),
            IDQAnswer(text: "SwiftUI and UIKit both utilize the declarative, while Objective-C relies on the imperative approach.", answerType: .wrong),
            IDQAnswer(text: "SwiftUI follows the imperative while UIKit the declarative programming approach.", answerType: .wrong),
            IDQAnswer(text: "SwiftUI follows the declarative while UIKit the imperative programming approach.", answerType: .correct),
        ]
    ),
    
    IDQQuestion(
        question: "Which statement is true regarding the List container in SwiftUI?",
        questionSerialNum: 0,
        explanation: "The List automatically manages its subviews in a single, vertically scrolling column.",
        reference: .appleDocumentation,
        referenceURLString: "https://developer.apple.com/documentation/swiftui/list",
        difficulty: .easy,
        topic: .swiftui,
        answers: [
            IDQAnswer(text: "A List automatically manages it's subviews in a single, vertically or horizontally scrolling column", answerType: .wrong),
            IDQAnswer(text: "A List is a generic container that provides a scrolling interface for its content, which can be laid out in any configuration", answerType: .wrong),
            IDQAnswer(text: "The List automatically manages its subviews in one or more vertically scrolling column.", answerType: .wrong),
            IDQAnswer(text: "The List automatically manages its subviews in one vertically scrolling column.", answerType: .correct),
        ]
    ),
    
    IDQQuestion(
        question: "How would you set the color of a text to blue in SwiftUI?",
        questionSerialNum: 0,
        explanation: "By applying the foregroundColor(_:) modifier to the Text with the Color.blue value",
        reference: .appleDocumentation,
        referenceURLString: "https://developer.apple.com/documentation/swiftui/view/foregroundcolor(_:)",
        difficulty: .veryEasy,
        topic: .swiftui,
        answers: [
            IDQAnswer(text: "By declaring the Text and calling the SetTintColor() method .onAppear with the Color.blue value.", answerType: .wrong),
            IDQAnswer(text: "By applying the backgroundColor(_:) modifier to the Text with the Color.blue value.", answerType: .wrong),
            IDQAnswer(text: "By applying the textColor(_:) modifier to the Text with the Color.blue value.", answerType: .wrong),
            IDQAnswer(text: "By applying the foregroundColor(_:) modifier to the Text with the Color.blue value.", answerType: .correct),
        ]
    ),
    
    IDQQuestion(
        question: "In SwiftUI the @State is __________ ",
        questionSerialNum: 0,
        explanation: "The @State property wrapper creates persistent storage for the value outside the view structure and preserves its value when the view redraws itself.",
        reference: nil,
        referenceURLString: nil,
        difficulty: .easy,
        topic: .swiftui,
        answers: [
            IDQAnswer(text: "an attribute that restricts changes you can make to the type, making it immutable", answerType: .wrong),
            IDQAnswer(text: "an acceess control syntax limiting the availability of an entity to its own defining source file", answerType: .wrong),
            IDQAnswer(text: "a property wrapper used to create a mutable reference to a value stored in a different view or data source", answerType: .wrong),
            IDQAnswer(text: "a property wrapper that creates persistent storage for a mutable value within a single view and preserves its value when the view redraws itself", answerType: .correct),
        ]
    ),
    
    IDQQuestion(
        question: "The ColorScheme environment value which let's you determine if the system apperance is set to light or dark mode",
        questionSerialNum: 0,
        explanation: "The possible color schemes, corresponding to the light and dark appearances.",
        reference: .appleDocumentation,
        referenceURLString: "https://developer.apple.com/documentation/swiftui/colorscheme",
        difficulty: .easy,
        topic: .swiftui,
        answers: [
            IDQAnswer(text: "The UserInterfaceStyle environment value", answerType: .wrong),
            IDQAnswer(text: "The traitCollectionDidChange method inside the onAppear(perform:) method", answerType: .wrong),
            IDQAnswer(text: "The UserInterfaceStyle property value", answerType: .wrong),
            IDQAnswer(text: "The ColorScheme environment value", answerType: .correct),
        ]
    ),
    
]








//MARK: TRUE OR FALSE QUESTIONS




let trueOrFalseQuestionList: [IDQQuestion] = [
    
    //MARK: - Basics
    
    IDQQuestion(
        question: "The below print statement would return 4\n\nlet x = -8.0 % 2\nprint(x)",
        questionSerialNum: 0,
        explanation: "The reminder operator does not work with floating point numbers. The code would return an error.",
        reference: .swiftDocumentation,
        referenceURLString: "https://docs.swift.org/swift-book/documentation/the-swift-programming-language/basicoperators#Remainder-Operator",
        difficulty: .veryEasy,
        topic: .basics,
        answers: [
            IDQAnswer(text: "true", answerType: .wrong),
            IDQAnswer(text: "false", answerType: .correct)
        ]
    ),
    
    IDQQuestion(
        question: "The below code contains an ERROR.\n\n4 <> 5",
        questionSerialNum: 0,
        explanation: "It'd return an error. The unequal comparison operator in Swift is !=",
        reference: .swiftDocumentation,
        referenceURLString: "https://docs.swift.org/swift-book/documentation/the-swift-programming-language/basicoperators#Comparison-Operators",
        difficulty: .veryEasy,
        topic: .basics,
        answers: [
            IDQAnswer(text: "false", answerType: .wrong),
            IDQAnswer(text: "true", answerType: .correct)
        ]
    ),
    
    IDQQuestion(
        question: "In Swift it's possible to use emojis in variable names.",
        questionSerialNum: 0,
        explanation: "Initialization is the creation of a data object.",
        reference: .swiftDocumentation,
        referenceURLString: "https://docs.swift.org/swift-book/documentation/the-swift-programming-language/thebasics#Naming-Constants-and-Variables",
        difficulty: .easy,
        topic: .basics,
        answers: [
            IDQAnswer(text: "false", answerType: .wrong),
            IDQAnswer(text: "true", answerType: .correct)
        ]
    ),
    
    IDQQuestion(
        question: "The console would print out \"a\"\n\nlet apple = \"apple\"\nif apple.contains(\"a\") {\n    print(\"a\")\n}",
        questionSerialNum: 0,
        explanation: "True, the String type conforms to Collection protocol, meaning that a String can be treated as a collection of Characters. The contains method works on sequences so it works on Strings.",
        reference: .appleDocumentation,
        referenceURLString: "https://developer.apple.com/documentation/swift/string",
        difficulty: .veryEasy,
        topic: .basics,
        answers: [
            IDQAnswer(text: "false", answerType: .wrong),
            IDQAnswer(text: "true", answerType: .correct)
        ]
    ),
    
    IDQQuestion(
        question: "The below code contains an ERROR\n\nvar a: Int = nil",
        questionSerialNum: 0,
        explanation: "True, It'd return an error because you can only assign nil to optional variable or constant. \nThe correct code would be var a: Int? = nil",
        reference: .swiftDocumentation,
        referenceURLString: "https://docs.swift.org/swift-book/documentation/the-swift-programming-language/thebasics#Optionals",
        difficulty: .easy,
        topic: .basics,
        answers: [
            IDQAnswer(text: "false", answerType: .wrong),
            IDQAnswer(text: "true", answerType: .correct)
        ]
    ),
    
    IDQQuestion(
        question: "In Swift optionals of any type can be set to nil",
        questionSerialNum: 0,
        explanation: "True, you can assign the nil value to any optional type in Swift",
        reference: .swiftDocumentation,
        referenceURLString: "https://docs.swift.org/swift-book/documentation/the-swift-programming-language/thebasics#Optionals",
        difficulty: .easy,
        topic: .basics,
        answers: [
            IDQAnswer(text: "false", answerType: .wrong),
            IDQAnswer(text: "true", answerType: .correct)
        ]
    ),
    
    IDQQuestion(
        question: "You cannot declare a constant with a nil",
        questionSerialNum: 0,
        explanation: "False, you can assign the nil value to any optional type in Swift. You can assign it to variables or constants too.",
        reference: .swiftDocumentation,
        referenceURLString: "https://docs.swift.org/swift-book/documentation/the-swift-programming-language/thebasics#Optionals",
        difficulty: .easy,
        topic: .basics,
        answers: [
            IDQAnswer(text: "true", answerType: .wrong),
            IDQAnswer(text: "false", answerType: .correct)
        ]
    ),
    
    IDQQuestion(
        question: "In Swift the nil is a pointer to a non-existent object",
        questionSerialNum: 0,
        explanation: "False, In Swift nil is just the absence of an optionals value. In Objective-C, however, nil is indeed a pointer.",
        reference: .swiftDocumentation,
        referenceURLString: "https://docs.swift.org/swift-book/documentation/the-swift-programming-language/thebasics#Optionals",
        difficulty: .medium,
        topic: .basics,
        answers: [
            IDQAnswer(text: "true", answerType: .wrong),
            IDQAnswer(text: "false", answerType: .correct)
        ]
    ),
    
    IDQQuestion(
        question: "A ternary conditional operator ensures that certain conditions are met before executing the rest of the code in a function or method. ",
        questionSerialNum: 0,
        explanation: "False, the ternary conditional operator uses three parts, a conditional and two possible values based on the conditional.",
        reference: .swiftDocumentation,
        referenceURLString: "https://docs.swift.org/swift-book/documentation/the-swift-programming-language/basicoperators#Ternary-Conditional-Operator",
        difficulty: .easy,
        topic: .basics,
        answers: [
            IDQAnswer(text: "true", answerType: .wrong),
            IDQAnswer(text: "false", answerType: .correct)
        ]
    ),
    
    IDQQuestion(
        question: "A ternary conditional operator cannot use optinals in it's conditional.",
        questionSerialNum: 0,
        explanation: "True, the ternary conditional operator must return a value based on a conditional that cannot be nil.",
        reference: .swiftDocumentation,
        referenceURLString: "https://docs.swift.org/swift-book/documentation/the-swift-programming-language/basicoperators#Ternary-Conditional-Operator",
        difficulty: .easy,
        topic: .basics,
        answers: [
            IDQAnswer(text: "false", answerType: .wrong),
            IDQAnswer(text: "true", answerType: .correct)
        ]
    ),
    
    IDQQuestion(
        question: "The below code contains an ERROR\n\nfor fruit in [..<5] {\n\tprint(fruit)\n}",
        questionSerialNum: 0,
        explanation: "False, the code is correct. You can use one-sided ranges in for statments. In the example above it iterates through the array as long as the index is smaller than 2",
        reference: .swiftDocumentation,
        referenceURLString: "https://docs.swift.org/swift-book/documentation/the-swift-programming-language/basicoperators#One-Sided-Ranges",
        difficulty: .easy,
        topic: .basics,
        answers: [
            IDQAnswer(text: "true", answerType: .wrong),
            IDQAnswer(text: "false", answerType: .correct)
        ]
    ),
    
    IDQQuestion(
        question: "The below code contains an ERROR\n\nvar scores = Array(repeating: 5, count: 8)",
        questionSerialNum: 0,
        explanation: "In Swift it's possible to initialize a default array. In the code example an Array of Intigers is generated with 8 elements. Each element has the value 5",
        reference: .swiftDocumentation,
        referenceURLString: "https://docs.swift.org/swift-book/documentation/the-swift-programming-language/collectiontypes#Creating-an-Array-with-a-Default-Value",
        difficulty: .medium,
        topic: .basics,
        answers: [
            IDQAnswer(text: "true", answerType: .wrong),
            IDQAnswer(text: "false", answerType: .correct)
        ]
    ),
    
    IDQQuestion(
        question: "The first item of an Array in Swift has the index 0",
        questionSerialNum: 0,
        explanation: "The first item in the array has an index of 0, not 1. Arrays in Swift are always zero-indexed.",
        reference: .swiftDocumentation,
        referenceURLString: "https://docs.swift.org/swift-book/documentation/the-swift-programming-language/collectiontypes#Accessing-and-Modifying-an-Array",
        difficulty: .veryEasy,
        topic: .basics,
        answers: [
            IDQAnswer(text: "false", answerType: .wrong),
            IDQAnswer(text: "true", answerType: .correct)
        ]
    ),
    
    IDQQuestion(
        question: "The number 2 will be printed on the console:\nlet numbers = [1, 2, 3, 4, 5]\nprint(numbers.first)",
        questionSerialNum: 0,
        explanation: "The first instance property returns the first element of a collection\nIn this case the number 1 is the first which'd have the index 0",
        reference: .appleDocumentation,
        referenceURLString: "https://developer.apple.com/documentation/swift/array/first",
        difficulty: .veryEasy,
        topic: .basics,
        answers: [
            IDQAnswer(text: "true", answerType: .wrong),
            IDQAnswer(text: "false", answerType: .correct)
        ]
    ),
    
    IDQQuestion(
        question: "Sets conform to the Hashable protocol by default",
        questionSerialNum: 0,
        explanation: "Sets conform to the Hasable protocol by default.",
        reference: .swiftDocumentation,
        referenceURLString: "https://docs.swift.org/swift-book/documentation/the-swift-programming-language/collectiontypes#Hash-Values-for-Set-Types",
        difficulty: .easy,
        topic: .basics,
        answers: [
            IDQAnswer(text: "false", answerType: .wrong),
            IDQAnswer(text: "true", answerType: .correct)
        ]
    ),
    
    IDQQuestion(
        question: "Arrays conform to the Hashable protocol by default",
        questionSerialNum: 0,
        explanation: "No, by default Sets conform to the Hasable protocol.",
        reference: .swiftDocumentation,
        referenceURLString: "https://docs.swift.org/swift-book/documentation/the-swift-programming-language/collectiontypes#Hash-Values-for-Set-Types",
        difficulty: .easy,
        topic: .basics,
        answers: [
            IDQAnswer(text: "true", answerType: .wrong),
            IDQAnswer(text: "false", answerType: .correct)
        ]
    ),
    
    IDQQuestion(
        question: "A common attribute of Arrays and Sets is that they both contain an order collection of items.",
        questionSerialNum: 0,
        explanation: "No, Arrays have an orderd list of items but Sets don't.",
        reference: .swiftDocumentation,
        referenceURLString: "https://docs.swift.org/swift-book/documentation/the-swift-programming-language/collectiontypes#Sets",
        difficulty: .easy,
        topic: .basics,
        answers: [
            IDQAnswer(text: "true", answerType: .wrong),
            IDQAnswer(text: "false", answerType: .correct)
        ]
    ),
    
    IDQQuestion(
        question: "Sets can only store unique values of the same type",
        questionSerialNum: 0,
        explanation: "Yes, Sets can only store unique values of the same type.",
        reference: .swiftDocumentation,
        referenceURLString: "https://docs.swift.org/swift-book/documentation/the-swift-programming-language/collectiontypes#Sets",
        difficulty: .easy,
        topic: .basics,
        answers: [
            IDQAnswer(text: "false", answerType: .wrong),
            IDQAnswer(text: "true", answerType: .correct)
        ]
    ),
    
    IDQQuestion(
        question: "The below code does NOT contain ERRORs\n\nvar a: Set = [1, 2, 3]\nvar b: Set = [1, 4, 8]\nvar c = a + b",
        questionSerialNum: 0,
        explanation: "False, because you cannot use binary operators on Sets. Instead you can use the union function. This prevents the Sets from forming duplicated values.",
        reference: .appleDocumentation,
        referenceURLString: "https://developer.apple.com/documentation/swift/set#2845530",
        difficulty: .easy,
        topic: .basics,
        answers: [
            IDQAnswer(text: "true", answerType: .wrong),
            IDQAnswer(text: "false", answerType: .correct)
        ]
    ),
    
    IDQQuestion(
        question: "The sorted() method converts a Set into an Array by descending order.",
        questionSerialNum: 0,
        explanation: "It's false. Although the sorted() method does convert Sets into Array but it's order is ascending by default.",
        reference: .swiftDocumentation,
        referenceURLString: "https://docs.swift.org/swift-book/documentation/the-swift-programming-language/collectiontypes#Iterating-Over-a-Set",
        difficulty: .medium,
        topic: .basics,
        answers: [
            IDQAnswer(text: "true", answerType: .wrong),
            IDQAnswer(text: "false", answerType: .correct)
        ]
    ),
    
    IDQQuestion(
        question: "The sorted() method converts a Set into an Array by descending order.",
        questionSerialNum: 0,
        explanation: "It's false. Although the sorted() method does convert Sets into Array but it's order is ascending by default.",
        reference: .swiftDocumentation,
        referenceURLString: "https://docs.swift.org/swift-book/documentation/the-swift-programming-language/collectiontypes#Iterating-Over-a-Set",
        difficulty: .medium,
        topic: .basics,
        answers: [
            IDQAnswer(text: "true", answerType: .wrong),
            IDQAnswer(text: "false", answerType: .correct)
        ]
    ),
    
    IDQQuestion(
        question: "Generally, Sets can be searched faster because of the uniqueness of their elements.",
        questionSerialNum: 0,
        explanation: "Since Sets guarantee unique elements, there is no need to perform additional checks when inserting an element. In contrast, ensuring uniqueness in Arrays requires extra work.",
        reference: .appleDocumentation,
        referenceURLString: "https://developer.apple.com/documentation/swift/set#2845530",
        difficulty: .medium,
        topic: .basics,
        answers: [
            IDQAnswer(text: "false", answerType: .wrong),
            IDQAnswer(text: "true", answerType: .correct)
        ]
    ),
    
    IDQQuestion(
        question: "In the below code, the modifiedPrimes has a type of Array<String>\n\nvar primes: Set = [2, 3, 5, 7, 11]\nlet modifiedPrimes = primes.map(String.init)",
        questionSerialNum: 0,
        explanation: "This is true. By default sequence operations return an Array or a type-erasing collection wrapper when used on Sets",
        reference: .appleDocumentation,
        referenceURLString: "https://developer.apple.com/documentation/swift/set#2845530",
        difficulty: .medium,
        topic: .basics,
        answers: [
            IDQAnswer(text: "false", answerType: .wrong),
            IDQAnswer(text: "true", answerType: .correct)
        ]
    ),
    
    IDQQuestion(
        question: "A common attribute of Dictionaries and Sets is that they both contain an unordered collection of items.",
        questionSerialNum: 0,
        explanation: "This is true.",
        reference: .swiftDocumentation,
        referenceURLString: "https://docs.swift.org/swift-book/documentation/the-swift-programming-language/collectiontypes#Dictionaries",
        difficulty: .easy,
        topic: .basics,
        answers: [
            IDQAnswer(text: "false", answerType: .wrong),
            IDQAnswer(text: "true", answerType: .correct)
        ]
    ),
    
    IDQQuestion(
        question: "In a dictionary each value must be associated with a unique key which acts as an identifier for that value.",
        questionSerialNum: 0,
        explanation: "This is true.",
        reference: .swiftDocumentation,
        referenceURLString: "https://docs.swift.org/swift-book/documentation/the-swift-programming-language/collectiontypes#Dictionaries",
        difficulty: .easy,
        topic: .basics,
        answers: [
            IDQAnswer(text: "false", answerType: .wrong),
            IDQAnswer(text: "true", answerType: .correct)
        ]
    ),
    
    IDQQuestion(
        question: "Dictionaries have a fixed size.",
        questionSerialNum: 0,
        explanation: "This is false. Tuples have a fixed size, dictionaries are dynamic just like Arrays and Sets.",
        reference: .swiftDocumentation,
        referenceURLString: "https://docs.swift.org/swift-book/documentation/the-swift-programming-language/collectiontypes#Creating-an-Empty-Dictionary",
        difficulty: .easy,
        topic: .basics,
        answers: [
            IDQAnswer(text: "true", answerType: .wrong),
            IDQAnswer(text: "false", answerType: .correct)
        ]
    ),
    
    IDQQuestion(
        question: "Dictionaries have a fixed size.",
        questionSerialNum: 0,
        explanation: "This is false. Tuples have a fixed size, dictionaries are dynamic just like Arrays and Sets.",
        reference: .swiftDocumentation,
        referenceURLString: "https://docs.swift.org/swift-book/documentation/the-swift-programming-language/collectiontypes#Creating-an-Empty-Dictionary",
        difficulty: .easy,
        topic: .basics,
        answers: [
            IDQAnswer(text: "true", answerType: .wrong),
            IDQAnswer(text: "false", answerType: .correct)
        ]
    ),
    
    IDQQuestion(
        question: "Dictionaries can have different types in them",
        questionSerialNum: 0,
        explanation: "This is false. Tuples have different types, dictionaries can't.",
        reference: .swiftDocumentation,
        referenceURLString: "https://docs.swift.org/swift-book/documentation/the-swift-programming-language/collectiontypes#Dictionaries",
        difficulty: .easy,
        topic: .basics,
        answers: [
            IDQAnswer(text: "true", answerType: .wrong),
            IDQAnswer(text: "false", answerType: .correct)
        ]
    ),
    
]
