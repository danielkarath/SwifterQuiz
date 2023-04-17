//
//  IDQQuestionManager.swift
//  iOSDevQuiz
//
//  Created by Daniel Karath on 4/17/23.
//

import UIKit
import CoreData

final class IDQQuestionManager {
    
    enum QuestionArrayType {
        case bookmarked
        case disabled
    }
    
    private let userManager = IDQUserManager()
    //MARK: - Init
    init(
        
    ) {
        
    }
    
    //MARK: - Private
    private let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    private func saveToCoreData() {
        do {
            try context.save()
        } catch let error as NSError {
            print("Failed to save disabled question to core data. Error: \(error), \(error.userInfo)")
            // Handle the error appropriately, such as showing an error message to the user
        }
    }
    
    private func fetchQuestionArray(for type: QuestionArrayType) -> [IDQQuestion]? {
        var myUser: IDQUser?
        do {
            let user: [IDQUser] = try context.fetch(IDQUser.fetchRequest())
            if !user.isEmpty {
                myUser = user.first
            } else {
                return nil
            }
        } catch {
            print(error.localizedDescription)
            return nil
        }
        if type == .bookmarked {
            guard let returnArray = myUser?.bookmarkedQuestions else {return nil}
            return returnArray as! [IDQQuestion]
        } else if type == .disabled {
            guard let returnArray = myUser?.disabledQuestions else {return nil}
            return returnArray as! [IDQQuestion]
        } else {
            return nil
        }
    }
    
    //MARK: - Pubic
    public func disable(_ question: IDQQuestion) {
        guard let user = userManager.fetchUser() else {
            return
        }
        guard var disabledQuestions = fetchQuestionArray(for: .disabled) else {
            return
        }
        
        if !disabledQuestions.contains(where: { $0.question == question.question }) {
            disabledQuestions.append(question)
            user.disabledQuestions = disabledQuestions as NSArray
            saveToCoreData()
            print("Question sucessfully disabled and saved to core data")
        } else {
            print("The question is already disabled. Cannot duplicate it & no changes are made in Core Data")
        }
        removeBookmark(question)
    }
    
    public func bookmark(_ question: IDQQuestion) {
        guard let user = userManager.fetchUser() else {
            return
        }
        guard var bookmarkedQuestions = fetchQuestionArray(for: .bookmarked) else {
            return
        }
        
        if !bookmarkedQuestions.contains(where: { $0.question == question.question }) {
            bookmarkedQuestions.append(question)
            user.bookmarkedQuestions = bookmarkedQuestions as NSArray
            saveToCoreData()
            print("Question sucessfully bookmarked and saved to core data")
        } else {
            print("The question is already bookmarked. Cannot duplicate it & no changes are made in Core Data")
        }
    }
    
    public func removeDisable(_ question: IDQQuestion) {
        guard let user = userManager.fetchUser() else {
            return
        }
        guard var disabledQuestions = fetchQuestionArray(for: .disabled) else {
            return
        }
        if let index = disabledQuestions.firstIndex(where: { $0.question == question.question }) {
            disabledQuestions.remove(at: index)
            user.disabledQuestions = disabledQuestions as NSArray
            print("Question is removed from disabled list in Core Data successfully.")
        } else {
            print("The disabled questions array did not contain this question. No changes were made")
        }
    }
    
    public func removeBookmark(_ question: IDQQuestion) {
        guard let user = userManager.fetchUser() else {
            return
        }
        guard var bookmarkedQuestions = fetchQuestionArray(for: .bookmarked) else {
            return
        }
        if let index = bookmarkedQuestions.firstIndex(where: { $0.question == question.question }) {
            bookmarkedQuestions.remove(at: index)
            user.bookmarkedQuestions = bookmarkedQuestions as NSArray
            print("Question is removed from bookmarked list in Core Data successfully.")
        } else {
            print("The bookmarked questions array did not contain this question. No changes were made")
        }
    }
    
}
