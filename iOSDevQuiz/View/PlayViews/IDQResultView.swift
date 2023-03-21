//
//  IDQResultView.swift
//  iOSDevQuiz
//
//  Created by Daniel Karath on 3/21/23.
//

import UIKit

class IDQResultView: UIView {
    
    private var quiz: IDQQuiz?
    
    private let topBackgroundSize: CGFloat = UIScreen.main.bounds.width*3
    
    private let topBackgroundView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Results"
        label.numberOfLines = 1
        label.textAlignment = .center
        label.textColor = IDQConstants.highlightedDarkOrange
        label.font = IDQConstants.setFont(fontSize: 21, isBold: true)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let congratulationsLabel: UILabel = {
        let label = UILabel()
        label.text = "Congratulations! You've scored "
        label.numberOfLines = 1
        label.textAlignment = .center
        label.textColor = IDQConstants.secondaryFontColor
        label.font = IDQConstants.setFont(fontSize: 11, isBold: false)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let QuestionsSubTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "Questions"
        label.numberOfLines = 1
        label.textAlignment = .center
        label.textColor = IDQConstants.basicFontColor
        label.font = IDQConstants.setFont(fontSize: 13, isBold: true)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let questionsCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.register(
            IDQResultCollectionViewCell.self,
            forCellWithReuseIdentifier: IDQResultCollectionViewCell.cellIdentifier
        )
        layout.sectionInset = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
        collectionView.alpha = 1.0
        collectionView.isHidden = false
        return collectionView
    }()
    
    //MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
        setupConstraints()
        setupCollectionView()
//        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(startViewTapped(_:)))
//        addGestureRecognizer(tapGesture)
    }
    
    required init?(coder: NSCoder) {
        fatalError("IDQPlayView is unsupported!")
    }
    
    private func setupView() {
        let color1: UIColor = IDQConstants.highlightedLightOrange
        let color2: UIColor = IDQConstants.highlightedDarkOrange
        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = IDQConstants.backgroundColor
        topBackgroundView.frame.size = CGSize(width: topBackgroundSize, height: topBackgroundSize)
        topBackgroundView.layer.cornerRadius = topBackgroundSize/2
        topBackgroundView.gradient(IDQConstants.highlightedContentBackgroundColor.cgColor, IDQConstants.contentBackgroundColor.cgColor, direction: .bottomLeftToTopRight)
    }
    
    private func setupCollectionView() {
        questionsCollectionView.delegate = self
        questionsCollectionView.dataSource = self
    }
    
    //MARK: - Private
    
    private func setupConstraints() {
        addSubviews(topBackgroundView, titleLabel, congratulationsLabel, QuestionsSubTitleLabel, questionsCollectionView)
        NSLayoutConstraint.activate([
            topBackgroundView.topAnchor.constraint(equalTo: topAnchor, constant: -topBackgroundSize/1.15),
            topBackgroundView.centerXAnchor.constraint(equalTo: centerXAnchor, constant: 0),
            topBackgroundView.widthAnchor.constraint(equalToConstant: topBackgroundSize),
            topBackgroundView.heightAnchor.constraint(equalToConstant: topBackgroundSize),
            
            congratulationsLabel.heightAnchor.constraint(equalToConstant: 18),
            congratulationsLabel.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width*0.60),
            congratulationsLabel.centerXAnchor.constraint(equalTo: centerXAnchor, constant: 0),
            congratulationsLabel.topAnchor.constraint(equalTo: topAnchor, constant: 80),
            
            titleLabel.heightAnchor.constraint(equalToConstant: 26),
            titleLabel.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width*0.80),
            titleLabel.centerXAnchor.constraint(equalTo: centerXAnchor, constant: 0),
            titleLabel.topAnchor.constraint(equalTo: congratulationsLabel.bottomAnchor, constant: 0),
            
            QuestionsSubTitleLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 48),
            QuestionsSubTitleLabel.heightAnchor.constraint(equalToConstant: 30),
            QuestionsSubTitleLabel.widthAnchor.constraint(equalToConstant: 160),
            QuestionsSubTitleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 32),
            
            questionsCollectionView.topAnchor.constraint(equalTo: QuestionsSubTitleLabel.bottomAnchor, constant: 8),
            questionsCollectionView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 32),
            questionsCollectionView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -32),
            questionsCollectionView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -64)
            
        ])
    }
    
    //MARK: - Public
    
    public func configure(quiz: IDQQuiz) {
        titleLabel.text = "Total Score: \(quiz.totalScore)"
    }
}

extension IDQResultView: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: IDQResultCollectionViewCell.cellIdentifier, for: indexPath) as? IDQResultCollectionViewCell else {
            fatalError("Unsupported cell")
        }

//        let viewModel = cellViewModels[indexPath.row]
//        cell.configure(with: viewModel)
        return cell
    }
}
