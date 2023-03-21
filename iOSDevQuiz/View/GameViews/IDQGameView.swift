//
//  IDQGameView.swift
//  iOSDevQuiz
//
//  Created by Daniel Karath on 3/8/23.
//

import UIKit

protocol IDQGameViewDelegate: AnyObject {
    func idqGameView(_ gameView: IDQGameView, didFinish quiz: IDQQuiz)
}

final class IDQGameView: UIView {
        
    public weak var delegate: IDQGameViewDelegate?
    
    private let countDownView = CountDownView()
    
    private let answerView = IDQAnswerView()
    
    private var quizRound: Int = 0
    
    private var questions: [IDQQuestion] = []
    
    private var game: IDQGame?
        
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
        view.backgroundColor = UIColor.black.withAlphaComponent(0.20)
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
        label.textAlignment = .center
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
        button.isHidden = true
        button.alpha = 0.0
        let width: CGFloat = 60
        let height: CGFloat = width * 1.33
        button.frame.size = CGSize(width: width * 2, height: height * 2) //.size = CGSize(width: width, height: height)
        button.setTitleColor(IDQConstants.darkOrange, for: .normal)
        button.titleLabel?.font = IDQConstants.setFont(fontSize: 15, isBold: false)
        button.setTitle("Pass", for: .normal)
        button.setTitle("Pass", for: .highlighted)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.isEnabled = false
        button.isUserInteractionEnabled = false
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
        answerView.delegate = self
        answerView.layer.zPosition = 8
    }
    
    required init?(coder: NSCoder) {
        fatalError("Unsupported")
    }
    
    private func setupView() {
        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = IDQConstants.backgroundColor
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
        addSubviews(spinner, overlayView, questionLabel, difficultyLabel, countDownView, passButton, questionNumberLabel, answerView)
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
            countDownView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -64),
            countDownView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -32),

            collectionView.topAnchor.constraint(equalTo: questionLabel.bottomAnchor, constant: 24),
            collectionView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 24),
            collectionView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -24),
            collectionView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -128),
            
            passButton.topAnchor.constraint(equalTo: collectionView.bottomAnchor, constant: 8),
            passButton.centerXAnchor.constraint(equalTo: centerXAnchor, constant: 0),
            passButton.widthAnchor.constraint(equalToConstant: 60),
            passButton.heightAnchor.constraint(equalToConstant: 25),
            
            questionNumberLabel.topAnchor.constraint(equalTo: topAnchor, constant: -12),
            questionNumberLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 12),
            questionNumberLabel.widthAnchor.constraint(equalToConstant: 150),
            questionNumberLabel.heightAnchor.constraint(equalToConstant: 150),
            
            spinner.centerXAnchor.constraint(equalTo: centerXAnchor, constant: 0),
            spinner.centerYAnchor.constraint(equalTo: centerYAnchor, constant: 0),
            spinner.widthAnchor.constraint(equalToConstant: 32),
            spinner.heightAnchor.constraint(equalToConstant: 32),
            
            answerView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 300),
            answerView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 0),
            answerView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 0),
            answerView.heightAnchor.constraint(equalToConstant: 300)
        ])
    }
    
    private func setupQuizResults() {
        guard let game = self.game else { return }
        let quiz = IDQQuiz(
            gamestyle: game,
            questions: questions,
            totalScore: self.totalScore,
            time: self.quizDuration,
            date: quizDate
        )
        delegate?.idqGameView(self, didFinish: quiz)
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
    
    //MARK: - Public
    
    public func configure(with questions: [IDQQuestion], game: IDQGame) {
        guard !questions.isEmpty, game != nil else {
            fatalError("Wrong configuration at IDQGameView configure")
        }
        self.questions = questions
        self.game = game
        self.question = questions[quizRound]
        questionLabel.configureFor(IDQConstants.keywords)
        countDownView.setupTimer(game: game)
        if quizRound != game.numberOfQuestions-1 {
            questionNumberLabel.text = String(quizRound+1)
            quizRound += 1
        } else {
            setupQuizResults()
            //Logic to move to a Result VC
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
        self.quizDuration = countDownView.timeSpent
        let isCorrect = cell.didSelect(answer: selectedAnswer)
        if isCorrect {
            self.totalScore += 1
        }
        countDownView.stopTimer()
        answerView.idqAnswerView(answerView, question: question!, answer: selectedAnswer)
        configure(overlay: overlayView)
        UIView.animate(withDuration: 1.0, delay: 0.0, usingSpringWithDamping: 0.66, initialSpringVelocity: 0.2, options: [], animations: {
            self.answerView.transform = CGAffineTransform(translationX: 0, y: -240)
        }, completion: nil)
    }
    
}

extension IDQGameView: IDQIDQAnswerViewDelegate {
    
    func didTapContinue(_ answerView: IDQAnswerView) {
        UIView.animate(withDuration: 0.30) {
            self.answerView.transform = CGAffineTransform(translationX: 0, y: 0)
        }
        spinner.startAnimating()
        configure(overlay: overlayView)
        configure(with: questions, game: game!)
    }
    
    
}
