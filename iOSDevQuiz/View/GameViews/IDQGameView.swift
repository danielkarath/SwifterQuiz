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
            guard let question = question else { return }
            spinner.stopAnimating()
            self.answerCollectionView?.reloadData()
            self.answerCollectionView?.isHidden = false
            
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
            }
        }
    }
    
    private var answers: [IDQAnswer] = []
    
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
        label.textColor = IDQConstants.highlightedDarkOrange
        label.font = IDQConstants.setFont(fontSize: 14, isBold: true)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
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
        addSubviews(questionLabel, difficultyLabel, countDownView)
        guard let collectionView = answerCollectionView else {
            return
        }
        NSLayoutConstraint.activate([
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
        ])
    }
    
    public func configure(with question: IDQQuestion, game: IDQGame) {
        self.question = question
        questionLabel.configureFor(IDQConstants.keywords)
        countDownView.setupTimer(game: game)
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
    
//    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        collectionView.deselectItem(at: indexPath, animated: true)
//        let selectedCharacter = characters[indexPath.row]
//        delegate?.didSelectCharacter(selectedCharacter)
//    }
    
}
