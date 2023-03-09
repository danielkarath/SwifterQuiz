//
//  IDQGameViewController.swift
//  iOSDevQuiz
//
//  Created by Daniel Karath on 3/2/23.
//

import UIKit

final class IDQGameViewController: UIViewController {
    
    private let questions: [IDQQuestion]
    private let game: IDQGame
    
    private let quizView = IDQGameView()
        
    init(questions: [IDQQuestion], game: IDQGame) {
        self.questions = questions
        self.game = game
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("Unsupported")
    }
    
    //MARK: - Life cycle
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = IDQConstants.backgroundColor
        setupConstraints()
        startQuiz()
        //playView.delegate = self
    }
    
    private func setupConstraints() {
        view.addSubview(quizView)
        NSLayoutConstraint.activate([
            quizView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: -16),
            quizView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor, constant: 0),
            quizView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor, constant: 0),
            quizView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0),
        ])
    }

    private func startQuiz() {
        print("startQuiz executed")
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            let question = self.questions[0]
            self.quizView.configure(with: question, game: self.game)
        }
    }

}
