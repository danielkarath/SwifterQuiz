//
//  IDQGameViewController.swift
//  iOSDevQuiz
//
//  Created by Daniel Karath on 3/2/23.
//

import UIKit

final class IDQGameViewController: UIViewController {
    
    private let questions: [IDQQuestion]
    
    //MARK: - Init
    
    init(questions: [IDQQuestion]) {
        self.questions = questions
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("Unsupported")
    }
    
    //MARK: - Life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = IDQConstants.backgroundColor
        startQuiz()
        // Do any additional setup after loading the view.
    }

    private func startQuiz() {
        DispatchQueue.main.asyncAfter(deadline: .now()+1.0) {
            print("Question: \(self.questions[0].question)")
        }
    }

}
