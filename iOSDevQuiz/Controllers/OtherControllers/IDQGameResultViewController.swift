//
//  IDQGameResultViewController.swift
//  iOSDevQuiz
//
//  Created by Daniel Karath on 3/21/23.
//

import UIKit

final class IDQGameResultViewController: UIViewController {

    //private let viewModel: IDQResultViewViewModel
    
    private let quiz: IDQQuiz
    private let resultView = IDQResultView()
    
    init(quiz: IDQQuiz) {
        self.quiz = quiz
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("Unsupported")
    }
    
    //MARK: - Life cycle
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationItem.hidesBackButton = true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = IDQConstants.backgroundColor
        setupConstraints()
        resultView.configure(quiz: quiz)
        resultView.delegate = self
        setupNavItems()
    }
    
    private func setupNavItems() {
        navigationController?.navigationBar.prefersLargeTitles = false
        let chevronImage = UIImage(systemName: "chevron.left")!
        //let menuButton = UIBarButtonItem(title: "Menu", image: chevronImage, target: self, action: #selector(menuButtonTapped))
        let menuButton = UIBarButtonItem(image: chevronImage, title: "Menu", color: IDQConstants.darkOrange, target: self, action: #selector(menuButtonTapped))
        menuButton.titlePositionAdjustment(for: .default)
        menuButton.title = "Menu"
        navigationItem.leftBarButtonItem = menuButton
    }
    
    private func setupConstraints() {
        view.addSubview(resultView)
        NSLayoutConstraint.activate([
            resultView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: -16),
            resultView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor, constant: 0),
            resultView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor, constant: 0),
            resultView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0),
        ])
    }
    
    @objc
    private func menuButtonTapped() {
        navigationController?.popToRootViewController(animated: true)
    }
}

extension IDQGameResultViewController: IDQResultViewDelegate {
    func idqResultView(_: IDQResultView, didTap button: UIButton) {
        
    }
    
}
