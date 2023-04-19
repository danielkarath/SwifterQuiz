//
//  IDQGameViewController.swift
//  iOSDevQuiz
//
//  Created by Daniel Karath on 3/2/23.
//

import UIKit
import MessageUI

final class IDQGameViewController: UIViewController {
    
    private let questions: [IDQQuestion]
    private let game: IDQGame
        
    //private let viewModel = IDQResultViewViewModel()
    
    private let qameView = IDQGameView()
    
    private var quizRoundCounter: Int = 0
        
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
        qameView.delegate = self
        let chevronImage = UIImage(systemName: "chevron.left")!
        //let menuButton = UIBarButtonItem(title: "Menu", image: chevronImage, target: self, action: #selector(menuButtonTapped))
        let menuButton = UIBarButtonItem(image: chevronImage, title: "End Quiz", color: IDQConstants.errorColor, target: self, action: #selector(menuButtonTapped))
        menuButton.titlePositionAdjustment(for: .default)
        menuButton.title = "End Quiz"
        navigationItem.leftBarButtonItem = menuButton
    }
    
    private func setupConstraints() {
        view.addSubview(qameView)
        NSLayoutConstraint.activate([
            qameView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: -16),
            qameView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor, constant: 0),
            qameView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor, constant: 0),
            qameView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0),
        ])
    }

    private func startQuiz() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            self.qameView.configure(with: self.questions, game: self.game)
        }
    }
    
    @objc
    private func menuButtonTapped() {
        if quizRoundCounter > 0 {
            NotificationCenter.default.post(name: .exitQuizPressed, object: nil)
        } else {
            navigationController?.popToRootViewController(animated: true)
        }
    }

}

extension IDQGameViewController: IDQGameViewDelegate {
    func shouldOpenMailComposer(for question: IDQQuestion?) {
        guard let question = question else {
            return
        }
        guard MFMailComposeViewController.canSendMail()  else {
            print("Can't send mail")
            return
        }
        var mailMessageSubject: String = "Report on question number: \(question.questionSerialNum)"
        
        let systemVersion = UIDevice.current.systemVersion
        
        
        
        let composer = MFMailComposeViewController()
        composer.mailComposeDelegate = self
        composer.setToRecipients(["hello@danielkarath.com"])
        composer.setSubject(mailMessageSubject)
        composer.setMessageBody("", isHTML: false)
        present(composer, animated: true)
    }
    
    
    func idqGameView(_ gameView: IDQGameView, questionCounter: Int) {
        quizRoundCounter = questionCounter
    }
    
    func idqGameView(_ gameView: IDQGameView, didTapExit: Bool) {
        navigationController?.popToRootViewController(animated: true)
    }
    
    func idqGameView(_ gameView: IDQGameView, didFinish quiz: IDQQuiz) {
        let detailVC = IDQGameResultViewController(quiz: quiz)
        detailVC.navigationItem.largeTitleDisplayMode = .never
        detailVC.hidesBottomBarWhenPushed = true
        navigationController?.pushViewController(detailVC, animated: true)
    }
}
