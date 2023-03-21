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
    
    //private let viewModel = IDQResultViewViewModel()
    
    private let qameView = IDQGameView()
        
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
        //playView.delegate = self
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

}

extension IDQGameViewController: IDQGameViewDelegate {
    func idqGameView(_ gameView: IDQGameView, didFinish quiz: IDQQuiz) {
        let detailVC = IDQGameResultViewController(quiz: quiz)
        detailVC.navigationItem.largeTitleDisplayMode = .never
        detailVC.hidesBottomBarWhenPushed = true
        navigationController?.pushViewController(detailVC, animated: true)
    }
}
