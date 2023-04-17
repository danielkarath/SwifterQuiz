//
//  IDQPlayViewController.swift
//  iOSDevQuiz
//
//  Created by Daniel Karath on 3/2/23.
//

import UIKit

final class IDQPlayViewController: UIViewController {

    private let playView = IDQPlayView()
    
    private let viewModel = IDQPlayViewViewModel()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = IDQConstants.backgroundColor
        setupConstraints()
        playView.delegate = self
    }
    
    private func setupConstraints() {
        view.addSubview(playView)
        NSLayoutConstraint.activate([
            playView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: -16),
            playView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor, constant: 0),
            playView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor, constant: 0),
            playView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0),
        ])
    }

}

extension IDQPlayViewController: IDQPlayViewDelegate {
    
    func idqPlayView(_ playView: IDQPlayView, didSelect game: IDQGame?) {
        guard let game = game else {
            return
        }
        let generatedQuestions = viewModel.generateQuestions(game: game)
        guard let questions = generatedQuestions else {return}
        let detailVC = IDQGameViewController(questions: questions, game: game)
        detailVC.navigationItem.largeTitleDisplayMode = .never
        detailVC.hidesBottomBarWhenPushed = true
        navigationController?.pushViewController(detailVC, animated: true)
    }
    
    
}
