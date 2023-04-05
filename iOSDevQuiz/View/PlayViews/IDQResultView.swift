//
//  IDQResultView.swift
//  iOSDevQuiz
//
//  Created by Daniel Karath on 3/21/23.
//

import UIKit

protocol IDQResultViewDelegate: AnyObject {
    func idqResultView(_: IDQResultView, didTap button: UIButton)
}

class IDQResultView: UIView {
    
    private let viewModel = IDQResultViewViewModel()
    
    public weak var delegate: IDQResultViewDelegate?
    
    private var quiz: IDQQuiz? {
        didSet {
            questionsCollectionView.reloadData()
        }
    }
    
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
        label.font = IDQConstants.setFont(fontSize: 48, isBold: true)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let congratulationsLabel: UILabel = {
        let label = UILabel()
        label.text = "You've scored "
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
        label.textAlignment = .left
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
        collectionView.backgroundColor = .clear.withAlphaComponent(0.0)
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
        topBackgroundView.backgroundColor = IDQConstants.contentBackgroundColor
        topBackgroundView.frame.size = CGSize(width: topBackgroundSize, height: topBackgroundSize)
        topBackgroundView.layer.cornerRadius = topBackgroundSize/2
    }
    
    private func setupCollectionView() {
        questionsCollectionView.delegate = self
        questionsCollectionView.dataSource = self
    }
    
    //MARK: - Private
    
    private func setupConstraints() {
        
        let collectionViewLeadingAnchor: CGFloat = 8
        
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
            
            titleLabel.heightAnchor.constraint(equalToConstant: 80),
            titleLabel.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width*0.80),
            titleLabel.centerXAnchor.constraint(equalTo: centerXAnchor, constant: 0),
            titleLabel.topAnchor.constraint(equalTo: congratulationsLabel.bottomAnchor, constant: -8),
            
            QuestionsSubTitleLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 48),
            QuestionsSubTitleLabel.heightAnchor.constraint(equalToConstant: 30),
            QuestionsSubTitleLabel.widthAnchor.constraint(equalToConstant: 160),
            QuestionsSubTitleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: collectionViewLeadingAnchor+8),
            
            questionsCollectionView.topAnchor.constraint(equalTo: QuestionsSubTitleLabel.bottomAnchor, constant: 2),
            questionsCollectionView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: collectionViewLeadingAnchor),
            questionsCollectionView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -collectionViewLeadingAnchor),
            questionsCollectionView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -128)
            
        ])
    }
    
    //MARK: - Public
    
    public func configure(quiz: IDQQuiz) {
        self.quiz = quiz
        viewModel.countAnimation(titleLabel, duration: 3.0, quiz: quiz)
    }
    
}

extension IDQResultView: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return quiz?.questions.count ?? 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: IDQResultCollectionViewCell.cellIdentifier, for: indexPath) as? IDQResultCollectionViewCell else {
            fatalError("Unsupported cell")
        }
        if quiz != nil {
            cell.configure(with: quiz!, index: indexPath.row)
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let screenBounds = UIScreen.main.bounds
        let width = (screenBounds.width-32)
        return CGSize(width: width, height: width * 0.40)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        //let selectedQuestion = questions[indexPath.row]
        //delegate?.didSelectEpisode(selectedQuestion)
    }
}
