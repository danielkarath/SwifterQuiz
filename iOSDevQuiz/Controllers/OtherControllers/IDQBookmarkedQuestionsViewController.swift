//
//  IDQBookmarkedQuestionsViewController.swift
//  iOSDevQuiz
//
//  Created by Daniel Karath on 4/21/23.
//

import UIKit

class IDQBookmarkedQuestionsViewController: UIViewController {

    private let questions: [IDQQuestion]
    
    
    private let bookmarkView = IDQBookmarkedQuestionsView()
    
    private var quizRoundCounter: Int = 0
        
    init(bookmarkedQuestions: [IDQQuestion]) {
        self.questions = bookmarkedQuestions
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("Unsupported")
    }
    
    //MARK: - Life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = IDQConstants.backgroundColor
        setupConstraints()
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            self.bookmarkView.configure(with: self.questions)
        }
        //bookmarkView.delegate = self
    }
    
    private func setupConstraints() {
        view.addSubview(bookmarkView)
        NSLayoutConstraint.activate([
            bookmarkView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: -16),
            bookmarkView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor, constant: 0),
            bookmarkView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor, constant: 0),
            bookmarkView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0),
        ])
    }

}
