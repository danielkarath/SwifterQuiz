//
//  IDQGameView.swift
//  iOSDevQuiz
//
//  Created by Daniel Karath on 3/8/23.
//

import UIKit

protocol IDQGameViewDelegate: AnyObject {
    func idqGameView(_ gameView: IDQGameView, didFinish quiz: IDQQuiz)
    func idqGameView(_ gameView: IDQGameView, didTapExit: Bool)
    func idqGameView(_ gameView: IDQGameView, questionCounter: Int)
}

final class IDQGameView: UIView {
        
    public weak var delegate: IDQGameViewDelegate?
        
    private let viewModel = IDQGameViewViewModel()
    
    private let countDownView = CountDownView()
    
    private let answerResultView = IDQAnswerResultView()
    
    private let exitView = IDQExitQuizView()
    
    private var questions: [IDQQuestion] = []
    
    private var game: IDQGame?
    
    private var isCorrectArray: [Bool] = []
        
    private var totalScore: Int = 0
    
    private var quizDuration: Int = 0
    
    private let quizDate: Date = Date()
    
    private var question: IDQQuestion? {
        didSet {
            guard let question = question else { return }
            spinner.stopAnimating()
            self.answerCollectionView?.reloadData()
            self.answerCollectionView?.isHidden = false
            self.passButton.isHidden = false
            var shuffledAnswers = question.answers
            for i in 0..<shuffledAnswers.count {
                let j = Int(arc4random_uniform(UInt32(shuffledAnswers.count - i))) + i
                if i != j {
                    shuffledAnswers.swapAt(i, j)
                }
            }
            self.answers = shuffledAnswers
            
            UIView.animate(withDuration: 0.25, delay: 0.10) {
                self.difficultyLabel.text = self.question?.difficulty.rawValue
                self.questionLabel.text = self.question?.question
                self.answerCollectionView?.alpha = 1.0
                self.passButton.alpha = 1.0
            }
        }
    }
    
    private var answers: [IDQAnswer] = []
    
    private let spinner: UIActivityIndicatorView = {
        let spinner = UIActivityIndicatorView(style: .large)
        spinner.hidesWhenStopped = true
        spinner.translatesAutoresizingMaskIntoConstraints = false
        spinner.tintColor = IDQConstants.basicFontColor
        spinner.layer.zPosition = 9
        return spinner
    }()
    
    private let overlayView: UIView = {
        let view = UIView()
        view.frame.size = CGSize(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
        view.backgroundColor = UIColor.black.withAlphaComponent(0.30)
        view.isUserInteractionEnabled = true
        view.translatesAutoresizingMaskIntoConstraints = false
        view.isHidden = true
        view.layer.zPosition = 7
        return view
    }()
    
    private let questionNumberLabel: UILabel = {
        let label = UILabel()
        label.text = " "
        label.numberOfLines = 1
        label.textAlignment = .right
        label.textColor = IDQConstants.secondaryFontColor.withAlphaComponent(0.15)
        label.font = IDQConstants.setFont(fontSize: 140, isBold: true)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.layer.zPosition = 2
        return label
    }()
    
    private let questionLabel: UILabel = {
        let label = UILabel()
        label.text = " "
        label.numberOfLines = 0
        label.textAlignment = .left
        label.textColor = IDQConstants.highlightFontColor
        label.font = IDQConstants.setFont(fontSize: 20, isBold: false)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.layer.zPosition = 3
        return label
    }()
    
    private let difficultyLabel: UILabel = {
        let label = UILabel()
        label.text = " "
        label.numberOfLines = 1
        label.textAlignment = .left
        label.textColor = IDQConstants.secondaryFontColor
        label.font = IDQConstants.setFont(fontSize: 14, isBold: true)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.layer.zPosition = 4
        return label
    }()
    
    private let passButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.alpha = 0.0
        let width: CGFloat = UIScreen.main.bounds.width - 50
        let height: CGFloat = 40
        button.frame.size = CGSize(width: width, height: height)
        button.layer.cornerRadius = 8
        button.setTitleColor(IDQConstants.secondaryFontColor, for: .normal)
        button.titleLabel?.font = IDQConstants.setFont(fontSize: 20, isBold: true)
        button.setTitle("Pass", for: .normal)
        button.setTitle("Pass", for: .highlighted)
        button.layer.zPosition = 6
        return button
    }()
    
    private var answerCollectionView: UICollectionView?
    
    //MARK: - Init
        
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
        let collectionView = createCollectionView()
        self.answerCollectionView = collectionView
        addSubview(collectionView)
        setupConstraints()
        setupCollectionView(collectionView)
        answerResultView.delegate = self
        exitView.delegate = self
        countDownView.delegate = self
        countDownView.layer.zPosition = 11
        answerResultView.layer.zPosition = 12
        exitView.layer.zPosition = 13
        passButton.addTarget(self, action: #selector(passButtonTapped(_:)), for: .touchUpInside)
    }
    
    required init?(coder: NSCoder) {
        fatalError("Unsupported")
    }
    
    //MARK: - deinit
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    private func setupView() {
        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = IDQConstants.backgroundColor
        NotificationCenter.default.addObserver(self, selector: #selector(didTapExit), name: .exitQuizPressed, object: nil)
    }
    
    private func createCollectionView() -> UICollectionView {
        let layout = UICollectionViewCompositionalLayout { section, _ in
            return self.layout(for: section)
        }
        let collectionView = UICollectionView(
            frame: .zero,
            collectionViewLayout: layout
        )
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = .clear.withAlphaComponent(0.0)
        collectionView.isHidden = true
        collectionView.alpha = 0.0
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(IDQGameAnswerCollectionViewCell.self, forCellWithReuseIdentifier: IDQGameAnswerCollectionViewCell.cellidentifier)
        return collectionView
    }
    
    private func setupCollectionView(_ collectionView: UICollectionView) {
        collectionView.delegate = self
        collectionView.dataSource = self
    }
    
    private func setupConstraints() {
        addSubviews(spinner, overlayView, questionLabel, difficultyLabel, countDownView, passButton, questionNumberLabel, answerResultView, exitView)
        guard let collectionView = answerCollectionView else {
            return
        }
        NSLayoutConstraint.activate([
            overlayView.leadingAnchor.constraint(equalTo: leadingAnchor),
            overlayView.trailingAnchor.constraint(equalTo: trailingAnchor),
            overlayView.topAnchor.constraint(equalTo: topAnchor, constant: -100),
            overlayView.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            questionLabel.topAnchor.constraint(equalTo: topAnchor, constant: 64),
            questionLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 32),
            questionLabel.widthAnchor.constraint(equalToConstant: (UIScreen.main.bounds.width-64)*0.95),
            
            difficultyLabel.bottomAnchor.constraint(equalTo: questionLabel.topAnchor, constant: -2),
            difficultyLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 32),
            difficultyLabel.widthAnchor.constraint(equalToConstant: 96),
            difficultyLabel.heightAnchor.constraint(equalToConstant: 24),
            
            countDownView.heightAnchor.constraint(equalToConstant: 40),
            countDownView.widthAnchor.constraint(equalToConstant: 40),
            countDownView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -50),
            countDownView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -32),

            collectionView.topAnchor.constraint(equalTo: questionLabel.bottomAnchor, constant: 24),
            collectionView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 24),
            collectionView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -24),
            collectionView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -160),
            
            passButton.topAnchor.constraint(equalTo: collectionView.bottomAnchor, constant: 16),
            passButton.centerXAnchor.constraint(equalTo: centerXAnchor, constant: 0),
            passButton.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width - 50),
            passButton.heightAnchor.constraint(equalToConstant: 40),
            
            questionNumberLabel.topAnchor.constraint(equalTo: topAnchor, constant: -12),
            questionNumberLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -2),
            questionNumberLabel.widthAnchor.constraint(equalToConstant: 200),
            questionNumberLabel.heightAnchor.constraint(equalToConstant: 150),
            
            spinner.centerXAnchor.constraint(equalTo: centerXAnchor, constant: 0),
            spinner.centerYAnchor.constraint(equalTo: centerYAnchor, constant: 0),
            spinner.widthAnchor.constraint(equalToConstant: 32),
            spinner.heightAnchor.constraint(equalToConstant: 32),
            
            answerResultView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 300),
            answerResultView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 0),
            answerResultView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 0),
            answerResultView.heightAnchor.constraint(equalToConstant: 300),
            
            exitView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 350),
            exitView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 0),
            exitView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 0),
            exitView.heightAnchor.constraint(equalToConstant: 350)
        ])
    }
    
    private func setupQuizResults() {
        guard let game = self.game else { return }
        let quiz = viewModel.getQuizResults(
            game: game,
            questions: questions,
            isCorrect: isCorrectArray,
            totalScore: totalScore,
            quizDuration: quizDuration
        )
        delegate?.idqGameView(self, didFinish: quiz)
    }
    
    private func didTapAnswer(cell: IDQGameAnswerCollectionViewCell, selectedAnswer: IDQAnswer) {
        self.quizDuration = countDownView.timeSpent
        let isCorrect = cell.didSelect(answer: selectedAnswer)
        if isCorrect {
            self.totalScore += 1
            self.isCorrectArray.append(true)
        } else {
            self.vibrate(for: .error)
            self.isCorrectArray.append(false)
        }
        displayQuestionResults(isCorrectlyAnswered: selectedAnswer.isCorrect, answeredInTime: true)
    }
    
    private func displayQuestionResults(isCorrectlyAnswered: Bool, answeredInTime: Bool) {
        delegate?.idqGameView(self, questionCounter: viewModel.quizRound)
        countDownView.stopTimer()
        configure(overlay: overlayView)
        if !answeredInTime {
            self.answerResultView.idqAnswerResultView(answerResultView, question: question!, didNotAnswer: .runOutOfTime)
            self.vibrate(for: .error)
            self.isCorrectArray.append(false)
        } else {
            answerResultView.idqAnswerResultView(answerResultView, question: question!, answeredCorrectly: isCorrectlyAnswered)
        }
       
        UIView.animate(withDuration: 1.0, delay: 0.0, usingSpringWithDamping: 0.66, initialSpringVelocity: 0.2, options: [], animations: {
            self.answerResultView.transform = CGAffineTransform(translationX: 0, y: -240)
        }, completion: nil)
    }
    
    @objc
    private func passButtonTapped(_ sender: UIButton) {
        delegate?.idqGameView(self, questionCounter: viewModel.quizRound)
        countDownView.stopTimer()
        configure(overlay: overlayView)
        self.answerResultView.idqAnswerResultView(answerResultView, question: question!, didNotAnswer: .passed)
        self.isCorrectArray.append(false)
       
        UIView.animate(withDuration: 1.0, delay: 0.0, usingSpringWithDamping: 0.66, initialSpringVelocity: 0.2, options: [], animations: {
            self.answerResultView.transform = CGAffineTransform(translationX: 0, y: -240)
        }, completion: nil)
    }
    
    @objc
    private func didTapExit() {
        countDownView.pauseTimer()
        configure(overlay: overlayView)
        UIView.animate(withDuration: 0.80, delay: 0.0, usingSpringWithDamping: 0.86, initialSpringVelocity: 0.2, options: [], animations: {
            self.exitView.transform = CGAffineTransform(translationX: 0, y: -290)
        }, completion: nil)
    }
    
    private func didTapRejoinQuiz() {
        countDownView.unpauseTimer(game: game!)
        UIView.animate(withDuration: 0.30) {
            self.exitView.transform = CGAffineTransform(translationX: 0, y: 0)
        }
        configure(overlay: overlayView)
    }
    
    private func configure(overlay view: UIView) {
        guard let collectionView = answerCollectionView else { return }
        let elements: [UIView] = [passButton, collectionView]
        let shouldOverlay: Bool = view.isHidden ? true : false
        for element in elements {
            element.isUserInteractionEnabled = !shouldOverlay
            view.isHidden = !shouldOverlay
        }
        for cell in collectionView.visibleCells {
            cell.isUserInteractionEnabled = !shouldOverlay
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
        self.questions = questions
        self.game = game
        questionLabel.configureFor(IDQConstants.keywords)
        countDownView.setupTimer(game: game)
        if viewModel.isLastQuestion(game: game) {
            self.question = questions[viewModel.quizRound-1]
            questionNumberLabel.text = String(viewModel.quizRound)
        } else {
            setupQuizResults()
        }
        self.spinner.stopAnimating()
    }
}

extension IDQGameView {
    func layout(for section: Int) -> NSCollectionLayoutSection {
        let item = NSCollectionLayoutItem(layoutSize: .init(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .fractionalHeight(1))
        )
        
        item.contentInsets = NSDirectionalEdgeInsets(
            top: 4,
            leading: 2,
            bottom: 4,
            trailing: 2
        )
        
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: .init(
            widthDimension: .fractionalWidth(1),
            heightDimension: .absolute(120)),
            subitems: [item]
        )
        
        let section = NSCollectionLayoutSection(group: group)
        
        return section
    }
    
}

extension IDQGameView: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return question?.answers.count ?? 4
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: IDQGameAnswerCollectionViewCell.cellidentifier, for: indexPath) as? IDQGameAnswerCollectionViewCell else {
            fatalError("Unsupported cell")
        }
        guard let answer: IDQAnswer = question?.answers[indexPath.row] else {
            return cell //This should be debugged
        }
        cell.configure(with: answers[indexPath.row], serial: indexPath.row)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let screenBounds = UIScreen.main.bounds
        let width = (screenBounds.width-64)
        return CGSize(width: width, height: width * 1.5)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: IDQGameAnswerCollectionViewCell.cellidentifier, for: indexPath) as? IDQGameAnswerCollectionViewCell else {
            fatalError("Unsupported cell")
        }
        guard !answers.isEmpty, answers.count > 3, self.game != nil, self.question != nil else { return }
        let selectedAnswer = answers[indexPath.row]
        didTapAnswer(cell: cell, selectedAnswer: selectedAnswer)
    }
    
}

extension IDQGameView: IDQAnswerResultViewDelegate {
    
    func didTapContinue(_ answerResultView: IDQAnswerResultView) {
        UIView.animate(withDuration: 0.30) {
            self.answerResultView.transform = CGAffineTransform(translationX: 0, y: 0)
        }
        spinner.startAnimating()
        configure(overlay: overlayView)
        configure(with: questions, game: game!)
    }
}

extension IDQGameView: CountDownViewDelegate {
    func countDownView(_: CountDownView, didReachDeadline: Bool) {
        if didReachDeadline {
            print("Did reach deadline!!!!")
            displayQuestionResults(isCorrectlyAnswered: false, answeredInTime: false)
        }
    }
}

extension IDQGameView: IDQExitQuizViewDelegate {
    func didTapRejoinButton(_ idqExitQuizView: IDQExitQuizView) {
        didTapRejoinQuiz()
    }
    
    func didConfirmExit(_ idqExitQuizView: IDQExitQuizView) {
        countDownView.stopTimer()
        delegate?.idqGameView(self, didTapExit: true)
    }
    
    
}
