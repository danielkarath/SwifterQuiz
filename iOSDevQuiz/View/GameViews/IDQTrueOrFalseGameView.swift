//
//  IDQTrueOrFalseGameView.swift
//  iOSDevQuiz
//
//  Created by Daniel Karath on 5/3/23.
//

import UIKit

protocol IDQTrueOrFalseGameViewDelegate: AnyObject {
    func idqTrueOrFalseGameView(_ idqTrueOrFalseGameView: IDQTrueOrFalseGameView, didFinish quiz: IDQQuiz)
    func idqTrueOrFalseGameView(_ idqTrueOrFalseGameView: IDQTrueOrFalseGameView, didTapExit: Bool)
    func idqTrueOrFalseGameView(_ idqTrueOrFalseGameView: IDQTrueOrFalseGameView, questionCounter: Int)
}

class IDQTrueOrFalseGameView: UIView {
    
    public weak var delegate: IDQTrueOrFalseGameViewDelegate?
    
    private let viewModel = IDQGameViewViewModel()
    
    private let countDownView = CountDownView()
    
    private let answerResultView = IDQAnswerResultView()
    
    private let exitView = IDQExitQuizView()
    private var isExitViewVisible: Bool = false
    
    
    private let disableQuestionView = IDQDisableQuestionView()
    private var isDisableViewVisible: Bool = false
    
    private let questionManager = IDQQuestionManager()
    
    private var questions: [IDQQuestion] = []
    
    private var game: IDQGame?
    
    private var isCorrectArray: [IDQAnswerType] = []
    
    private var totalScore: Int = 0
    
    private var quizDuration: TimeInterval = 0
    
    private var cellsAnimated: [Bool] = []
    
    private let quizStartDate: Date = Date.currentTime
    private var questionStartDate: Date = Date.currentTime
    private var questionEndDate: Date?
    private var quizTimeSpent: TimeInterval = 0
    
    private var didAnswer: Bool = false
    
    private var question: IDQQuestion? {
        didSet {
            startViewAnimations()
        }
    }
    
    private var answers: [IDQAnswer] = []
    
    private var cardViewOriginalCenter: CGPoint?
    private var cardViewOriginalTransform: CGAffineTransform?
    
    private var cardHeight: CGFloat = UIScreen.screenHeight < 1000 ? (UIScreen.screenHeight*0.70) : (UIScreen.screenHeight*0.50)
    private var cardWidth: CGFloat = UIScreen.screenHeight < 1000 ? (UIScreen.screenHeight * 0.40) : (UIScreen.screenHeight * 0.30)
    private var cardViewWidthAnchor: NSLayoutConstraint!
    private var cardViewHeightAnchor: NSLayoutConstraint!
    
    private let spinner: UIActivityIndicatorView = {
        let spinner = UIActivityIndicatorView(style: .large)
        spinner.hidesWhenStopped = true
        spinner.translatesAutoresizingMaskIntoConstraints = false
        spinner.tintColor = IDQConstants.basicFontColor
        spinner.layer.zPosition = 11
        return spinner
    }()
    
    private let overlayView: UIView = {
        let view = UIView()
        view.frame.size = CGSize(width: UIScreen.screenWidth, height: UIScreen.screenHeight)
        view.backgroundColor = UIColor.black.withAlphaComponent(0.30)
        view.isUserInteractionEnabled = true
        view.translatesAutoresizingMaskIntoConstraints = false
        view.isHidden = true
        view.layer.zPosition = 12
        return view
    }()
    
    private let trueGradient: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.frame.size = CGSize(width: 250, height: UIScreen.screenHeight)
        view.backgroundColor = UIColor.clear.withAlphaComponent(0.00)
        view.alpha = 0.0
        view.layer.zPosition = 1
        return view
    }()
    
    private let falseGradient: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.frame.size = CGSize(width: 250, height: UIScreen.screenHeight)
        view.backgroundColor = UIColor.clear.withAlphaComponent(0.00)
        view.alpha = 0.0
        view.layer.zPosition = 2
        return view
    }()
    
    private let trueDecisionIndicatorLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "True"
        label.alpha = 1.0
        label.numberOfLines = 1
        label.textAlignment = .right
        label.textColor = IDQConstants.secondaryFontColor.withAlphaComponent(0.15)
        label.font = IDQConstants.setFont(fontSize: 40, isBold: true)
        label.layer.zPosition = 2
        return label
    }()
    
    private let falseDecisionIndicatorLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "False"
        label.alpha = 1.0
        label.numberOfLines = 1
        label.textAlignment = .left
        label.textColor = IDQConstants.secondaryFontColor.withAlphaComponent(0.15)
        label.font = IDQConstants.setFont(fontSize: 40, isBold: true)
        label.layer.zPosition = 2
        return label
    }()
    
    private var decisionLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = ""
        label.alpha = 0.0
        label.numberOfLines = 1
        label.textAlignment = .center
        label.textColor = IDQConstants.basicFontColor //.clear.withAlphaComponent(0)
        label.font = IDQConstants.setFont(fontSize: 28, isBold: true)
        label.layer.zPosition = 10
        return label
    }()
    
    private let cardView: UIView = {
        let view = UIView()
        let cardHeight: CGFloat = UIScreen.screenHeight < 1000 ? (UIScreen.screenHeight*0.70) : (UIScreen.screenHeight*0.50)
        let cardWidth: CGFloat = UIScreen.screenHeight < 1000 ? (UIScreen.screenHeight * 0.40) : (UIScreen.screenHeight * 0.30)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.frame.size = CGSize(width: cardWidth, height: cardHeight)
        view.backgroundColor = IDQConstants.contentBackgroundColor.withAlphaComponent(0.40)
        view.layer.cornerRadius = 16
        view.isUserInteractionEnabled = true
        view.layer.zPosition = 3
        return view
    }()
     
    private let innerCardView: UIView = {
        let view = UIView()
        let cardHeight: CGFloat = UIScreen.screenHeight < 1000 ? (UIScreen.screenHeight*0.70) : (UIScreen.screenHeight*0.50)
        let cardWidth: CGFloat = UIScreen.screenHeight < 1000 ? (UIScreen.screenHeight * 0.40) : (UIScreen.screenHeight * 0.30)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.frame.size = CGSize(width: cardWidth-5, height: cardHeight-5)
        view.backgroundColor = IDQConstants.contentBackgroundColor
        view.layer.cornerRadius = 16
        view.isUserInteractionEnabled = true
        view.alpha = 0
        view.layer.zPosition = 4
        return view
    }()
    
    private let questionNumberLabel: UILabel = {
        let label = UILabel()
        label.text = " "
        label.numberOfLines = 1
        label.textAlignment = .right
        label.textColor = IDQConstants.secondaryFontColor
        label.font = IDQConstants.setFont(fontSize: 13, isBold: true)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.layer.zPosition = 5
        return label
    }()
    
    private let questionLabel: UILabel = {
        let label = UILabel()
        label.text = " "
        label.numberOfLines = 0
        label.textAlignment = .left
        label.textColor = IDQConstants.highlightFontColor
        label.font = IDQConstants.setFont(fontSize: 13, isBold: false)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.layer.zPosition = 6
        return label
    }()
    
    private let difficultyLabel: UILabel = {
        let label = UILabel()
        label.text = " "
        label.numberOfLines = 1
        label.textAlignment = .left
        label.textColor = IDQConstants.secondaryFontColor
        label.font = IDQConstants.setFont(fontSize: 13, isBold: true)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.layer.zPosition = 7
        return label
    }()
    
    private var cardBackgroundImageView: UIImageView = {
        let imageView = UIImageView()
        let cardHeight: CGFloat = UIScreen.screenHeight < 1000 ? (UIScreen.screenHeight*0.70) : (UIScreen.screenHeight*0.50)
        let cardWidth: CGFloat = UIScreen.screenHeight < 1000 ? (UIScreen.screenHeight * 0.40) : (UIScreen.screenHeight * 0.30)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.frame.size = CGSize(width: cardWidth - 5, height: cardHeight-5)
        imageView.layer.cornerRadius = 16
        let backgroundImage = UIImage(named: "cardViewBackground")!
        imageView.image = backgroundImage
        imageView.tag = 10
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        return imageView
    }()
    
    //MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
        setupConstraints()
        countDownView.alpha = 0
        answerResultView.delegate = self
        exitView.delegate = self
        countDownView.delegate = self
        countDownView.layer.zPosition = 11
        answerResultView.layer.zPosition = 13
        exitView.layer.zPosition = 14
    }
    
    required init?(coder: NSCoder) {
        fatalError("Unsupported")
    }
    
    //MARK: - deinit
    deinit {
        NotificationCenter.default.removeObserver(self)
        NotificationCenter.default.removeObserver(self, name: UIDevice.orientationDidChangeNotification, object: nil)
    }
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        print("Traitcollection did change")
        updateShadow()
    }
    
    @objc
    private func orientationDidChange() {
        var fontSize: CGFloat = 13
        if UIScreen.screenHeight < 980 {
            fontSize = 13.0
        } else if UIScreen.screenHeight < 1100 {
            fontSize = 18.0
        } else {
            if !UIDevice.isLandscape {
                fontSize = 18.0
            } else {
                fontSize = 24.0
            }
        }
        if UIDevice.current.orientation.isPortrait {
            cardHeight = UIScreen.screenHeight < 1000 ? (UIScreen.screenHeight*0.70) : (UIScreen.screenHeight*0.75)
            cardWidth = UIScreen.screenHeight < 1000 ? (UIScreen.screenHeight * 0.40) : (UIScreen.screenHeight * 0.50)
            if UIScreen.screenHeight > 1000 {
                cardViewWidthAnchor.constant = cardWidth
                cardViewHeightAnchor.constant = cardHeight
            }
        } else {
            cardHeight = UIScreen.screenHeight < 1000 ? (UIScreen.screenHeight*0.70) : (UIScreen.screenHeight*0.50)
            cardWidth = UIScreen.screenHeight < 1000 ? (UIScreen.screenHeight * 0.40) : (UIScreen.screenHeight * 0.30)
            if UIScreen.screenHeight > 1000 {
                cardViewWidthAnchor.constant = cardWidth
                cardViewHeightAnchor.constant = cardHeight
            }
        }
        difficultyLabel.font = IDQConstants.setFont(fontSize: fontSize, isBold: true)
        questionNumberLabel.font = IDQConstants.setFont(fontSize: fontSize, isBold: true)
        questionLabel.font = IDQConstants.setFont(fontSize: fontSize, isBold: false)
    }
    
    private func setupView() {
        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = IDQConstants.backgroundColor
        NotificationCenter.default.addObserver(self, selector: #selector(didTapExit), name: .exitQuizPressed, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(orientationDidChange), name: UIDevice.orientationDidChangeNotification, object: nil)

        let notificationCenter = NotificationCenter.default
        notificationCenter.addObserver(self, selector: #selector(appMovedToBackground), name: UIApplication.didEnterBackgroundNotification, object: nil)
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(didTapOutside(_:)))
        overlayView.addGestureRecognizer(tapGesture)
        
        let swipeGestureExitView = UISwipeGestureRecognizer(target: self, action: #selector(didSwipeExitView(_:)))
        swipeGestureExitView.direction = .down
        exitView.addGestureRecognizer(swipeGestureExitView)
        
        let panGestureRecognizer = UIPanGestureRecognizer(target: self, action: #selector(handlePanGesture(_:)))
        cardView.addGestureRecognizer(panGestureRecognizer)
        
        trueGradient.gradient((IDQConstants.backgroundColor).withAlphaComponent(0.0).cgColor, IDQConstants.correctColor.withAlphaComponent(0.50).cgColor, direction: .horizontal)
        falseGradient.gradient(IDQConstants.errorColor.withAlphaComponent(0.50).cgColor, (IDQConstants.backgroundColor).withAlphaComponent(0.0).cgColor, direction: .horizontal)
        updateShadow()
        
        var fontSize: CGFloat = 13.0
        if UIScreen.screenHeight < 980 {
            fontSize = 13.0
        } else if UIScreen.screenHeight < 1100 {
            fontSize = 18.0
        } else {
            if UIDevice.isLandscape {
                fontSize = 18.0
            } else {
                fontSize = 24.0
            }
        }
        questionLabel.font = IDQConstants.setFont(fontSize: fontSize, isBold: false)
        questionNumberLabel.font = IDQConstants.setFont(fontSize: fontSize, isBold: true)
        difficultyLabel.font = IDQConstants.setFont(fontSize: fontSize, isBold: true)
    }
    
    private func updateShadow() {
        if traitCollection.userInterfaceStyle == .light {
            cardView.layer.shadowColor = UIColor.black.cgColor
            cardView.layer.shadowOffset = CGSize(width: 0, height: 30)
            cardView.layer.shadowRadius = 32
            cardView.layer.shadowOpacity = 0.18
        } else {
            cardView.layer.shadowOpacity = 0
        }
    }
    
    private func cardFlipAnimation() {
        UIView.transition(with: cardView, duration: 0.50, options: .transitionFlipFromLeft, animations: {
            let foregroundImage = UIImage(named: "cardViewForeground")!
            self.cardBackgroundImageView.image = foregroundImage
            self.cardView.sendSubviewToBack(self.cardBackgroundImageView)
        }, completion: {_ in
            if self.viewModel.quizRound == 1 {
                self.wiggleAnimation(view: self.cardView)
            }
        })
    }
    
    private func setupConstraints() {
        var answerViewHeight: CGFloat = 300
        var exitViewHeight: CGFloat = 350
        var countDownViewSize: CGFloat = 40.0
        if UIScreen.screenHeight < 980 {
            countDownViewSize = 40.0
            answerViewHeight = 300
            exitViewHeight = 350
        } else if UIScreen.screenHeight < 1100 {
            countDownViewSize = 60.0
            answerViewHeight = 350
            exitViewHeight = 400
        } else {
            countDownViewSize = 80.0
            answerViewHeight = 420
            exitViewHeight = 480
        }
        
        if !UIDevice.isLandscape {
            cardHeight = UIScreen.screenHeight < 1000 ? (UIScreen.screenHeight*0.70) : (UIScreen.screenHeight*0.75)
            cardWidth = UIScreen.screenHeight < 1000 ? (UIScreen.screenHeight * 0.40) : (UIScreen.screenHeight * 0.50)
        }
        
        addSubviews(spinner, overlayView, decisionLabel, cardView, countDownView, answerResultView, exitView, trueGradient, falseGradient, trueDecisionIndicatorLabel, falseDecisionIndicatorLabel)
        cardView.addSubview(innerCardView)
        cardView.addSubview(cardBackgroundImageView)
        cardView.sendSubviewToBack(cardBackgroundImageView)
        innerCardView.addSubviews(questionLabel, questionNumberLabel, difficultyLabel)
        NSLayoutConstraint.activate([
            overlayView.leadingAnchor.constraint(equalTo: leadingAnchor),
            overlayView.trailingAnchor.constraint(equalTo: trailingAnchor),
            overlayView.topAnchor.constraint(equalTo: topAnchor, constant: -100),
            overlayView.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            trueGradient.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 0),
            trueGradient.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 0),
            trueGradient.widthAnchor.constraint(equalToConstant: 250),
            trueGradient.heightAnchor.constraint(equalToConstant: UIScreen.screenHeight),
            
            falseGradient.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 0),
            falseGradient.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 0),
            falseGradient.widthAnchor.constraint(equalToConstant: 250),
            falseGradient.heightAnchor.constraint(equalToConstant: UIScreen.screenHeight),
            
            falseDecisionIndicatorLabel.topAnchor.constraint(equalTo: cardView.bottomAnchor, constant: -12),
            falseDecisionIndicatorLabel.leadingAnchor.constraint(equalTo: cardView.leadingAnchor, constant: -16),
            falseDecisionIndicatorLabel.widthAnchor.constraint(equalToConstant: 160),
            falseDecisionIndicatorLabel.heightAnchor.constraint(equalToConstant: 64),
            
            trueDecisionIndicatorLabel.topAnchor.constraint(equalTo: cardView.bottomAnchor, constant: -12),
            trueDecisionIndicatorLabel.trailingAnchor.constraint(equalTo: cardView.trailingAnchor, constant: 16),
            trueDecisionIndicatorLabel.heightAnchor.constraint(equalToConstant: 64),
            trueDecisionIndicatorLabel.widthAnchor.constraint(equalToConstant: 160),
            
            countDownView.heightAnchor.constraint(equalToConstant: countDownViewSize),
            countDownView.widthAnchor.constraint(equalToConstant: countDownViewSize),
            countDownView.topAnchor.constraint(equalTo: topAnchor, constant: 16),
            countDownView.centerXAnchor.constraint(equalTo: centerXAnchor, constant: 0),
            
            cardView.topAnchor.constraint(equalTo: countDownView.bottomAnchor, constant: 24),
            cardView.centerXAnchor.constraint(equalTo: centerXAnchor, constant: 0),
            //cardView.heightAnchor.constraint(equalToConstant: cardHeight),
            //cardView.widthAnchor.constraint(equalToConstant: cardWidth),
            
            cardBackgroundImageView.topAnchor.constraint(equalTo: cardView.topAnchor, constant: 2.5),
            cardBackgroundImageView.leadingAnchor.constraint(equalTo: cardView.leadingAnchor, constant: 2.5),
            cardBackgroundImageView.trailingAnchor.constraint(equalTo: cardView.trailingAnchor, constant: -2.5),
            cardBackgroundImageView.bottomAnchor.constraint(equalTo: cardView.bottomAnchor, constant: -2.5),
            
            innerCardView.topAnchor.constraint(equalTo: cardView.topAnchor, constant: 2.5),
            innerCardView.leadingAnchor.constraint(equalTo: cardView.leadingAnchor, constant: 2.5),
            innerCardView.trailingAnchor.constraint(equalTo: cardView.trailingAnchor, constant: -2.5),
            innerCardView.bottomAnchor.constraint(equalTo: cardView.bottomAnchor, constant: -2.5),
            
            questionLabel.centerYAnchor.constraint(equalTo: innerCardView.centerYAnchor, constant: -48),
            questionLabel.leadingAnchor.constraint(equalTo: innerCardView.leadingAnchor, constant: 32),
            questionLabel.trailingAnchor.constraint(equalTo: innerCardView.trailingAnchor, constant: -32),
            questionLabel.bottomAnchor.constraint(equalTo: innerCardView.bottomAnchor, constant: -64),
            
            questionNumberLabel.topAnchor.constraint(equalTo: innerCardView.topAnchor, constant: 8),
            questionNumberLabel.trailingAnchor.constraint(equalTo: innerCardView.trailingAnchor, constant: -16),
            questionNumberLabel.widthAnchor.constraint(equalToConstant: 50),
            questionNumberLabel.heightAnchor.constraint(equalToConstant: 24),
            
            difficultyLabel.topAnchor.constraint(equalTo: innerCardView.topAnchor, constant: 8),
            difficultyLabel.leadingAnchor.constraint(equalTo: innerCardView.leadingAnchor, constant: 16),
            difficultyLabel.widthAnchor.constraint(equalToConstant: 130),
            difficultyLabel.heightAnchor.constraint(equalToConstant: 24),
            
            decisionLabel.topAnchor.constraint(equalTo: cardView.bottomAnchor, constant: 20),
            decisionLabel.widthAnchor.constraint(equalToConstant: 130),
            decisionLabel.heightAnchor.constraint(equalToConstant: 40),
            decisionLabel.centerXAnchor.constraint(equalTo: centerXAnchor, constant: 0),
            
            spinner.centerXAnchor.constraint(equalTo: centerXAnchor, constant: 0),
            spinner.centerYAnchor.constraint(equalTo: centerYAnchor, constant: 0),
            spinner.widthAnchor.constraint(equalToConstant: 32),
            spinner.heightAnchor.constraint(equalToConstant: 32),
            
            answerResultView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: answerViewHeight),
            answerResultView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 0),
            answerResultView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 0),
            answerResultView.heightAnchor.constraint(equalToConstant: answerViewHeight),
            
            exitView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: exitViewHeight),
            exitView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 0),
            exitView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 0),
            exitView.heightAnchor.constraint(equalToConstant: exitViewHeight),
            
        ])
        
        cardViewWidthAnchor = cardView.widthAnchor.constraint(equalToConstant: cardWidth)
        cardViewHeightAnchor = cardView.heightAnchor.constraint(equalToConstant: cardHeight)
        
        cardViewWidthAnchor.isActive = true
        cardViewHeightAnchor.isActive = true
        
        cardViewOriginalCenter = cardView.center
        cardViewOriginalTransform = cardView.transform
    }
    
    func wiggleAnimation(view: UIView) {
        let wiggleDistance: CGFloat = 40.0
        let wiggleDuration: TimeInterval = 0.60
        let rotationAngle: CGFloat = 0.06
        
        // Create the left wiggle transform
        let leftTransform = CGAffineTransform(translationX: -wiggleDistance, y: 0).rotated(by: -rotationAngle)
        
        // Create the right wiggle transform
        let rightTransform = CGAffineTransform(translationX: wiggleDistance, y: 0).rotated(by: rotationAngle)
        
        // Apply the left wiggle transform with a short duration
        UIView.animate(withDuration: wiggleDuration, animations: {
            view.transform = leftTransform
        }) { (finished) in
            // Apply the right wiggle transform with a short duration
            UIView.animate(withDuration: wiggleDuration, animations: {
                view.transform = rightTransform
            }) { (finished) in
                // Return to the original transform with a short duration
                UIView.animate(withDuration: wiggleDuration, animations: {
                    view.transform = .identity
                })
            }
        }
    }
    
    private func startViewAnimations() {
        guard let question = question else { return }
        self.spinner.stopAnimating()
        self.didAnswer = false
        self.difficultyLabel.text = question.difficulty.rawValue
        self.questionLabel.text = question.question
        var shuffledAnswers = question.answers
        for i in 0..<shuffledAnswers.count {
            let j = Int(arc4random_uniform(UInt32(shuffledAnswers.count - i))) + i
            if i != j {
                shuffledAnswers.swapAt(i, j)
            }
        }
        self.answers = shuffledAnswers
        
        DispatchQueue.main.asyncAfter(deadline: .now()) {
            UIView.animate(withDuration: 0.50, delay: 0.0) {
                self.answerResultView.isHidden = false
                self.cardFlipAnimation()
            }
            
            UIView.animate(withDuration: 0.25, delay: 0.20) {
                self.innerCardView.alpha = 1.0
            }
            
            UIView.animate(withDuration: 0.60, delay: 0.50) {
                self.countDownView.alpha = 1.0
            }
        }
        
    }
    
    private func setupQuizResults() {
        guard let game = self.game else { return }
        countDownView.stopTimer()
        questionEndDate = Date.currentTime
        
        let quiz = viewModel.getQuizResults(
            game: game,
            questions: questions,
            isCorrect: isCorrectArray,
            totalScore: totalScore,
            quizDuration: quizTimeSpent
        )
        delegate?.idqTrueOrFalseGameView(self, didFinish: quiz)
    }
    
    private func displayQuestionResults(isCorrectlyAnswered: Bool, answeredInTime: Bool) {
        didAnswer = true
        delegate?.idqTrueOrFalseGameView(self, questionCounter: viewModel.quizRound)
        countDownView.stopTimer()
        configure(overlay: overlayView)
        if !answeredInTime {
            self.answerResultView.idqAnswerResultView(answerResultView, question: question!, didNotAnswer: .runOutOfTime)
            self.vibrate(for: .error)
            self.isCorrectArray.append(.runOutOfTime)
        } else {
            answerResultView.idqAnswerResultView(answerResultView, question: question!, answeredCorrectly: isCorrectlyAnswered)
        }
        var answerViewHeight: CGFloat = 240
        if UIScreen.screenHeight < 980 {
            answerViewHeight = 240
        } else if UIScreen.screenHeight < 1100 {
            answerViewHeight = 300
        } else {
            answerViewHeight = 350
        }
        UIView.animate(withDuration: 1.0, delay: 0.0, usingSpringWithDamping: 0.66, initialSpringVelocity: 0.2, options: [], animations: {
            self.answerResultView.transform = CGAffineTransform(translationX: 0, y: -answerViewHeight)
        }, completion: nil)
    }
    
    private func displayResults() {
        answerResultView.idqAnswerResultView(answerResultView, question: question!, answeredCorrectly: false)
        var answerViewHeight: CGFloat = 240
        if UIScreen.screenHeight < 980 {
            answerViewHeight = 240
        } else if UIScreen.screenHeight < 1100 {
            answerViewHeight = 300
        } else {
            answerViewHeight = 350
        }
        UIView.animate(withDuration: 1.0, delay: 0.0, usingSpringWithDamping: 0.66, initialSpringVelocity: 0.2, options: [], animations: {
            self.answerResultView.transform = CGAffineTransform(translationX: 0, y: -answerViewHeight)
        }, completion: nil)
    }
    
    @objc private func handlePanGesture(_ gestureRecognizer: UIPanGestureRecognizer) {
        guard let question = self.question, cardView != nil, cardViewOriginalCenter != nil, let originalTransform = cardViewOriginalTransform else {return}
        
        if gestureRecognizer.state == .began {
            cardViewOriginalCenter = cardView.center
        } else if gestureRecognizer.state == .changed {
            let translation = gestureRecognizer.translation(in: self)
            cardView.center = CGPoint(x: cardViewOriginalCenter!.x + translation.x, y: cardViewOriginalCenter!.y + translation.y)
            let rotationAngle = (cardView.center.x - self.center.x) / (self.center.x / 0.25)
            let rotationTransform = CGAffineTransform(rotationAngle: rotationAngle)
            cardView.transform = rotationTransform.concatenating(originalTransform)
            
            let threshold: CGFloat = 100.0
            let xPosition = cardView.center.x
            if xPosition < (self.center.x - threshold) {
                falseGradient.alpha = 1.0
                trueGradient.alpha = 0.0
                decisionLabel.alpha = 1.0
                decisionLabel.text = "False"
            } else if xPosition > (self.center.x + threshold) {
                decisionLabel.text = "True"
                decisionLabel.alpha = 1.0
                trueGradient.alpha = 1.0
                falseGradient.alpha = 0.0
            } else {
                decisionLabel.text = ""
                decisionLabel.alpha = 0.0
                falseGradient.alpha = 0.0
                trueGradient.alpha = 0.0
            }
            
        } else if gestureRecognizer.state == .ended {
            let threshold: CGFloat = 100.0
            let xPosition = cardView.center.x
            if xPosition < (self.center.x - threshold) {
                print("False")
                for answer in question.answers {
                    if answer.text == "false" {
                        didAnswer(answer: answer)
                    }
                }
            } else if xPosition > (self.center.x + threshold) {
                print("True")
                for answer in question.answers {
                    if answer.text == "true" {
                        didAnswer(answer: answer)
                    }
                }
            }
            trueGradient.alpha = 0.0
            falseGradient.alpha = 0.0
            UIView.animate(withDuration: 0.25) {
                self.cardView.center = self.cardViewOriginalCenter!
                self.cardView.transform = originalTransform
            }
        }
    }
    
    private func didAnswer(answer: IDQAnswer) {
        guard let question = self.question else {return}
        
        questionEndDate = Date.currentTime
        let timeDifference = (questionEndDate?.timeIntervalSince(questionStartDate))!
        quizTimeSpent += timeDifference
        
        if answer.answerType == .correct {
            self.totalScore += 1
            self.isCorrectArray.append(.correct)
            spinner.startAnimating()
            configure(with: questions, game: game!)
        } else {
            self.vibrate(for: .error)
            self.isCorrectArray.append(.wrong)
            displayResults()
            countDownView.stopTimer()
            configure(overlay: overlayView)
        }
    }
    
    @objc
    private func didSwipeExitView(_ sender: UIView) {
        if !overlayView.isHidden && isExitViewVisible {
            didTapRejoinButton(exitView)
        }
    }
    
    @objc
    private func didTapOutside(_ sender: UIView) {
        if !overlayView.isHidden && isExitViewVisible {
            didTapRejoinButton(exitView)
        }
    }
    
    @objc
    private func answerButtonTapped(_ sender: UIButton) {
        guard let selection = sender.currentTitle, let question = self.question else {return}
        let answers = question.answers
        var correctAnswer: String?
        
        for answer in answers {
            if answer.answerType == .correct {
                correctAnswer = answer.text
            }
        }
        
        guard correctAnswer != nil else {return}
        questionEndDate = Date.currentTime
        let timeDifference = (questionEndDate?.timeIntervalSince(questionStartDate))!
        quizTimeSpent += timeDifference
        
        if selection.lowercased() == correctAnswer {
            self.totalScore += 1
            self.isCorrectArray.append(.correct)
            spinner.startAnimating()
            configure(with: questions, game: game!)
        } else {
            self.vibrate(for: .error)
            self.isCorrectArray.append(.wrong)
            displayResults()
            countDownView.stopTimer()
            configure(overlay: overlayView)
        }
    }
    
    
    @objc
    private func appMovedToBackground() {
        if countDownView.isTimerRunning() {
            delegate?.idqTrueOrFalseGameView(self, questionCounter: viewModel.quizRound)
            countDownView.stopTimer()
            configure(overlay: overlayView)
            self.answerResultView.idqAnswerResultView(answerResultView, question: question!, didNotAnswer: .leftQuestion)
            self.vibrate(for: .error)
            self.isCorrectArray.append(.leftQuestion)
            var answerViewHeight: CGFloat = 240
            if UIScreen.screenHeight < 980 {
                answerViewHeight = 240
            } else if UIScreen.screenHeight < 1100 {
                answerViewHeight = 300
            } else {
                answerViewHeight = 350
            }
            UIView.animate(withDuration: 1.0, delay: 0.0, usingSpringWithDamping: 0.66, initialSpringVelocity: 0.2, options: [], animations: {
                self.answerResultView.transform = CGAffineTransform(translationX: 0, y: -answerViewHeight)
            }, completion: nil)
        }
    }
    
    @objc
    private func didTapExit() {
        if viewModel.quizRound == 1 {
            countDownView.stopTimer()
        } else {
            isExitViewVisible.toggle()
            countDownView.pauseTimer()
            
            questionEndDate = Date.currentTime
            let timeDifference = (questionEndDate?.timeIntervalSince(questionStartDate))!
            quizTimeSpent += timeDifference
            
            if overlayView.isHidden {
                configure(overlay: overlayView)
            }
            var answerViewHeight: CGFloat = 290
            if UIScreen.screenHeight < 980 {
                answerViewHeight = 290
            } else if UIScreen.screenHeight < 1100 {
                answerViewHeight = 350
            } else {
                answerViewHeight = 400
            }
            UIView.animate(withDuration: 0.80, delay: 0.0, usingSpringWithDamping: 0.86, initialSpringVelocity: 0.2, options: [], animations: {
                self.exitView.transform = CGAffineTransform(translationX: 0, y: -answerViewHeight)
            }, completion: nil)
        }
    }
    
    private func didTapRejoinQuiz() {
        guard let game = self.game else {return}
        UIView.animate(withDuration: 0.30) {
            self.exitView.transform = CGAffineTransform(translationX: 0, y: 0)
        }
        
        if countDownView.timeSpent >= game.questionTimer.rawValue || didAnswer {
        } else {
            countDownView.unpauseTimer(game: game)
            configure(overlay: overlayView)
        }
    }
    
    private func configure(overlay view: UIView) {
        let elements: [UIView] = [decisionLabel]
        let shouldOverlay: Bool = view.isHidden ? true : false
        for element in elements {
            element.isUserInteractionEnabled = !shouldOverlay
            view.isHidden = !shouldOverlay
        }
    }
    
    /// Play haptic for a given type
    /// - Parameter type: Type to vibrate for
    private func vibrate(for type: UINotificationFeedbackGenerator.FeedbackType) {
        let generator = UINotificationFeedbackGenerator()
        generator.prepare()
        generator.notificationOccurred(type)
    }
    
    //MARK: - Public
    public func configure(with questions: [IDQQuestion], game: IDQGame) {
        guard !questions.isEmpty, game != nil else {
            fatalError("Wrong configuration at IDQGameView configure")
        }
        decisionLabel.alpha = 0.0
        innerCardView.alpha = 0.0
        cardView.bringSubviewToFront(cardBackgroundImageView)
        let backgroundImage = UIImage(named: "cardViewBackground")!
        self.cardBackgroundImageView = UIImageView(image: backgroundImage)
        self.cardBackgroundImageView.contentMode = .scaleAspectFill
        self.cardBackgroundImageView.clipsToBounds = true
        self.countDownView.alpha = 0.0
        questionStartDate = Date.currentTime
        self.questions = questions
        self.game = game
        questionLabel.configureFor(IDQConstants.keywords)
        if viewModel.isLastQuestion(game: game) {
            if viewModel.quizRound == 1 {
                countDownView.setupTimer(game: game, delay: 1.80)
            }
            self.question = questions[viewModel.quizRound-1]
            questionNumberLabel.text = String(viewModel.quizRound)
        } else {
            setupQuizResults()
        }
        self.spinner.stopAnimating()
    }
}

extension IDQTrueOrFalseGameView: IDQAnswerResultViewDelegate {
    
    func didTapDisableQuestion(_ answerResultView: IDQAnswerResultView, for question: IDQQuestion) {
        isDisableViewVisible.toggle()
    }
    
    func didTapContinue(_ answerResultView: IDQAnswerResultView) {
        UIView.animate(withDuration: 0.30) {
            self.answerResultView.transform = CGAffineTransform(translationX: 0, y: 0)
        }
        spinner.startAnimating()
        configure(overlay: overlayView)
        setupQuizResults()
        //configure(with: questions, game: game!)
    }
}

extension IDQTrueOrFalseGameView: CountDownViewDelegate {
    func countDownView(_: CountDownView, didReachDeadline: Bool) {
        if didReachDeadline {
            questionEndDate = Date.currentTime
            let timeDifference = (questionEndDate?.timeIntervalSince(questionStartDate))!
            quizTimeSpent += timeDifference
            displayQuestionResults(isCorrectlyAnswered: false, answeredInTime: false)
        }
    }
}

extension IDQTrueOrFalseGameView: IDQExitQuizViewDelegate {
    func didTapRejoinButton(_ idqExitQuizView: IDQExitQuizView) {
        isExitViewVisible.toggle()
        didTapRejoinQuiz()
        questionStartDate = Date.currentTime
    }
    
    func didConfirmExit(_ idqExitQuizView: IDQExitQuizView) {
        isExitViewVisible.toggle()
        countDownView.stopTimer()
        delegate?.idqTrueOrFalseGameView(self, didTapExit: true)
    }
    
    
}
