//
//  IDQGameView.swift
//  iOSDevQuiz
//
//  Created by Daniel Karath on 3/8/23.
//

import UIKit

protocol IDQGameViewDelegate: AnyObject {
    func idqGameView(_ gameView: IDQGameView, didSelect game: IDQAnswer)
}

final class IDQGameView: UIView {
        
    public weak var delegate: IDQGameViewDelegate?
    
    private var question: IDQQuestion? {
        didSet {
            print("Question didSet()")
            spinner.stopAnimating()
            UIView.animate(withDuration: 0.25, delay: 0) {
                self.difficultyLabel.text = self.question?.difficulty.rawValue
                self.questionLabel.text = self.question?.question
            }
        }
    }
    
    private let spinner: UIActivityIndicatorView = {
        let spinner = UIActivityIndicatorView(style: .large)
        spinner.hidesWhenStopped = true
        spinner.translatesAutoresizingMaskIntoConstraints = false
        return spinner
    }()
    
    private let questionImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = IDQConstants.appIconMiniature
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private let questionLabel: UILabel = {
        let label = UILabel()
        label.text = " "
        label.numberOfLines = 0
        label.textAlignment = .left
        label.textColor = IDQConstants.highlightFontColor
        label.font = IDQConstants.setFont(fontSize: 20, isBold: false)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let difficultyLabel: UILabel = {
        let label = UILabel()
        label.text = " "
        label.numberOfLines = 1
        label.textAlignment = .left
        label.textColor = IDQConstants.brandingColor
        label.font = IDQConstants.setFont(fontSize: 14, isBold: true)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let timerOuterView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = IDQConstants.contentBackgroundColor
        view.layer.cornerRadius = 4
        view.frame.size.width = UIScreen.main.bounds.width-32
        return view
    }()
    
    private let timerInnerView: UIView = {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: 140, height: 24))
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = IDQConstants.brandingColor
        view.layer.cornerRadius = 4
        view.frame.size.width = 4
        return view
    }()
    
    private var questionCountdownTimer = Timer()
    private var countDownCount = 0
    
    //MARK: - Init
        
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
        setupConstraints()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("Unsupported")
    }
    
    private func setupView() {
        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = IDQConstants.backgroundColor
    }
    
    private func setupConstraints() {
        addSubviews(questionLabel, difficultyLabel, timerOuterView) //timerInnerView
        timerOuterView.addSubview(timerInnerView)
        NSLayoutConstraint.activate([
            questionLabel.topAnchor.constraint(equalTo: topAnchor, constant: 64),
            questionLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 32),
            questionLabel.widthAnchor.constraint(equalToConstant: (UIScreen.main.bounds.width-64)*0.95),
            
            difficultyLabel.bottomAnchor.constraint(equalTo: questionLabel.topAnchor, constant: -2),
            difficultyLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 32),
            difficultyLabel.widthAnchor.constraint(equalToConstant: 96),
            difficultyLabel.heightAnchor.constraint(equalToConstant: 24),
            
            timerOuterView.heightAnchor.constraint(equalToConstant: 24),
            timerOuterView.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width-64),
            timerOuterView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 32),
            timerOuterView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -32),
            
//            timerInnerView.heightAnchor.constraint(equalToConstant: 24),
//            timerInnerView.widthAnchor.constraint(equalToConstant: 140),
//            timerInnerView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 32),
//            timerInnerView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -32),
            
        ])
    }
    
    public func configure(with question: IDQQuestion, game: IDQGame) {
        self.question = question
        let questionDeadline: Int = game.questionTimer.rawValue
        
        
        UIView.animate(withDuration: TimeInterval(questionDeadline)) {
            self.timerInnerView.frame.size.width = UIScreen.main.bounds.width-64
        }
        
        
        /*
        self.questionCountdownTimer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { timer in
            if self.countDownCount < questionDeadline {
                DispatchQueue.main.async {
                    self.timerInnerView.frame.size.width = CGFloat((CGFloat(self.countDownCount) / CGFloat(questionDeadline))*(UIScreen.main.bounds.width-64))
                   
                }
                self.countDownCount += 1
            } else {
                timer.invalidate()
                self.countDownCount = 0
                DispatchQueue.main.async {
                    self.timerInnerView.frame.size.width = 1
                }
            }
        }
        */
        
        
    }

}
