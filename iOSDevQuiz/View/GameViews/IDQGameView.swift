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
    
    private let countDownView = CountDownView()
    
    private var question: IDQQuestion? {
        didSet {
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
    
    private let circularTimerView: UIView = {
        let circleSize: CGFloat = 140
        let view = UIView(frame: CGRect(x: 0, y: 0, width: circleSize, height: circleSize))
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = IDQConstants.backgroundColor
        view.layer.cornerRadius = circleSize/2
        view.frame.size.width = UIScreen.main.bounds.width-32
        return view
    }()
    
    private let countDownLabel: UILabel = {
        let label = UILabel()
        label.text = " "
        label.numberOfLines = 1
        label.textAlignment = .center
        label.textColor = IDQConstants.basicFontColor
        label.font = IDQConstants.setFont(fontSize: 24, isBold: true)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private var questionCountdownTimer = Timer()
    
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
        addSubviews(questionLabel, difficultyLabel, countDownView)
        NSLayoutConstraint.activate([
            questionLabel.topAnchor.constraint(equalTo: topAnchor, constant: 64),
            questionLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 32),
            questionLabel.widthAnchor.constraint(equalToConstant: (UIScreen.main.bounds.width-64)*0.95),
            
            difficultyLabel.bottomAnchor.constraint(equalTo: questionLabel.topAnchor, constant: -2),
            difficultyLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 32),
            difficultyLabel.widthAnchor.constraint(equalToConstant: 96),
            difficultyLabel.heightAnchor.constraint(equalToConstant: 24),
            
            countDownView.heightAnchor.constraint(equalToConstant: 140),
            countDownView.widthAnchor.constraint(equalToConstant: 140),
            countDownView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -64),
            countDownView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -32),

            
        ])
    }
    
    public func configure(with question: IDQQuestion, game: IDQGame) {
        self.question = question
        countDownView.setupTimer(game: game)
    }
   
}
