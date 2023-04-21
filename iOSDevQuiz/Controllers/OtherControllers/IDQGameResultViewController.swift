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
}

extension IDQGameResultViewController: IDQResultViewDelegate {
    
    
    func idqResultView(_ view: IDQResultView, didShare quiz: IDQQuiz, image: UIImage?) {
        let appID = "Add your actual App ID" // Add your actual App ID
        let appURLString = "https://apps.apple.com/app/id\(appID)"
        
        let textToShare = "I scored \(quiz.totalScore) out of \(quiz.questions.count) in the iOS Developer Quiz!"
        //let image = UIImage(imageLiteralResourceName: "appIconMiniature")
        
        UIGraphicsBeginImageContext(view.frame.size)
        view.layer.render(in: UIGraphicsGetCurrentContext()!)
        UIGraphicsEndImageContext()
        
        if let appURL = URL(string: appURLString) {
            let objectsToShare = [textToShare, appURL, image] as [Any]
            let activityVC = UIActivityViewController(activityItems: objectsToShare, applicationActivities: nil)
            
            //Excluded Activities
            activityVC.excludedActivityTypes = [UIActivity.ActivityType.airDrop, UIActivity.ActivityType.addToReadingList]
            //
            
            activityVC.popoverPresentationController?.sourceView = view
            activityVC.popoverPresentationController?.sourceRect = view.frame
            self.present(activityVC, animated: true, completion: nil)
        } else {
            print("Invalid app URL")
        }
    }
    
    func idqResultView(_: IDQResultView, didTap button: UIButton) {
        navigationController?.popToRootViewController(animated: true)
    }
    
}
