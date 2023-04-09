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
    
    private let scoreView = IDQScoreView()
    
    private let timeView = IDQTimeView()
    
    private let percentageView = IDQPercentageView()
    
    private let topBackgroundSize: CGFloat = UIScreen.main.bounds.width*3
    
    private var cellsAnimated: [Bool] = []

    
    private let topBackgroundView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let questionsSubTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "Questions"
        label.numberOfLines = 1
        label.textAlignment = .left
        label.textColor = IDQConstants.basicFontColor
        label.font = IDQConstants.setFont(fontSize: 13, isBold: true)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let shareButton: UIButton = {
        let button = UIButton()
        button.frame.size = CGSize(width: 50, height: 50)
        button.layer.cornerRadius = 8
        button.setTitleColor(IDQConstants.basicFontColor, for: .normal)
        button.titleLabel?.font = IDQConstants.setFont(fontSize: 20, isBold: true)
        button.backgroundColor = IDQConstants.contentBackgroundColor
        button.setImage(UIImage(systemName: "square.and.arrow.up"), for: .normal)
        button.setImage(UIImage(systemName: "square.and.arrow.up"), for: .highlighted)
        button.tintColor = IDQConstants.basicFontColor
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    private let menuButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.frame.size = CGSize(width: UIScreen.main.bounds.width-32-66, height: 50)
        let color1: UIColor = IDQConstants.highlightedLightOrange
        let color2: UIColor = IDQConstants.highlightedDarkOrange
        button.gradient(color1.cgColor, color2.cgColor, direction: .bottomLeftToTopRight)
        button.clipsToBounds = true
        button.layer.cornerRadius = 8
        button.setTitleColor(IDQConstants.contentBackgroundColor, for: .normal)
        button.titleLabel?.font = IDQConstants.setFont(fontSize: 20, isBold: true)
        button.setTitle("Menu", for: .normal)
        button.setTitle("Menu", for: .highlighted)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
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
        menuButton.addTarget(self, action: #selector(menuButtonTapped(_:)), for: .touchUpInside)
    }
    
    private func setupCollectionView() {
        questionsCollectionView.delegate = self
        questionsCollectionView.dataSource = self
    }
    
    private func setupCellAnimation() {
        guard quiz != nil, quiz?.questions.count ?? 0 > 0 else {
            return
        }
        for question in quiz!.questions {
            cellsAnimated.append(false)
        }
    }
    
    private func animate(cell: UICollectionViewCell, collectionView: UICollectionView, indexPath: IndexPath) {
        cell.alpha = 0.0
        cell.transform = CGAffineTransform(translationX: -collectionView.bounds.width, y: 0)
        
        // Calculate delay for this cell based on its index path
        let delay = 0.07 * Double(indexPath.item)
        
        // Apply animation to slide cell into view with delay
        UIView.animate(withDuration: 0.60, delay: delay, usingSpringWithDamping: 0.70, initialSpringVelocity: 0.40, options: [], animations: {
            cell.alpha = 1.0
            cell.transform = CGAffineTransform.identity
        }, completion: nil)
    }
    
    //MARK: - Private
    
    private func setupConstraints() {
        
        let collectionViewLeadingAnchor: CGFloat = 8
        let statsViewHeight: CGFloat = 48
        let statsViewWidth: CGFloat = 90
        
        addSubviews(topBackgroundView, scoreView, timeView, percentageView, questionsSubTitleLabel, questionsCollectionView, menuButton, shareButton)
        NSLayoutConstraint.activate([
            topBackgroundView.topAnchor.constraint(equalTo: topAnchor, constant: -topBackgroundSize/1.15),
            topBackgroundView.centerXAnchor.constraint(equalTo: centerXAnchor, constant: 0),
            topBackgroundView.widthAnchor.constraint(equalToConstant: topBackgroundSize),
            topBackgroundView.heightAnchor.constraint(equalToConstant: topBackgroundSize),
            
            scoreView.topAnchor.constraint(equalTo: topBackgroundView.bottomAnchor, constant: 32),
            scoreView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: collectionViewLeadingAnchor * 3.0),
            scoreView.widthAnchor.constraint(equalToConstant: statsViewWidth),
            scoreView.heightAnchor.constraint(equalToConstant: statsViewHeight),
            
            timeView.topAnchor.constraint(equalTo: topBackgroundView.bottomAnchor, constant: 32),
            timeView.centerXAnchor.constraint(equalTo: centerXAnchor),
            timeView.widthAnchor.constraint(equalToConstant: statsViewWidth),
            timeView.heightAnchor.constraint(equalToConstant: statsViewHeight),
            
            percentageView.topAnchor.constraint(equalTo: topBackgroundView.bottomAnchor, constant: 32),
            percentageView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -collectionViewLeadingAnchor * 3.0),
            percentageView.widthAnchor.constraint(equalToConstant: statsViewWidth),
            percentageView.heightAnchor.constraint(equalToConstant: statsViewHeight),
            
            questionsSubTitleLabel.topAnchor.constraint(equalTo: scoreView.bottomAnchor, constant: 32),
            questionsSubTitleLabel.heightAnchor.constraint(equalToConstant: 30),
            questionsSubTitleLabel.widthAnchor.constraint(equalToConstant: 160),
            questionsSubTitleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: collectionViewLeadingAnchor+8),
            
            questionsCollectionView.topAnchor.constraint(equalTo: questionsSubTitleLabel.bottomAnchor, constant: 2),
            questionsCollectionView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: collectionViewLeadingAnchor),
            questionsCollectionView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -collectionViewLeadingAnchor),
            questionsCollectionView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -128),
            
            shareButton.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -32),
            shareButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            shareButton.widthAnchor.constraint(equalToConstant: 50),
            shareButton.heightAnchor.constraint(equalToConstant: 50),
            
            menuButton.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -32),
            menuButton.leadingAnchor.constraint(equalTo: shareButton.trailingAnchor, constant: 16),
            menuButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            menuButton.heightAnchor.constraint(equalToConstant: 50),
        ])
    }
    
    @objc
    private func menuButtonTapped(_ sender: UIButton) {
        delegate?.idqResultView(self, didTap: menuButton)
    }
    
    //MARK: - Public
    
    public func configure(quiz: IDQQuiz) {
        self.quiz = quiz
        questionsCollectionView.isUserInteractionEnabled = false
        questionsCollectionView.alpha = 0.0
        questionsSubTitleLabel.alpha = 0.0
        DispatchQueue.main.async {
            self.viewModel.countAnimation(self.scoreView.quizScoreLabel, duration: 3.0, quiz: quiz)
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.30) {
            self.viewModel.countTimeAnimation(self.timeView.timeLabel, quiz: quiz)
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.50) {
            self.viewModel.performanceAnimation(self.percentageView.quizPercentageLabel, quiz: quiz)
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 3.10) {
            self.questionsCollectionView.isUserInteractionEnabled = true
            UIView.animate(withDuration: 0.85) {
                self.questionsCollectionView.alpha = 1.0
                self.questionsSubTitleLabel.alpha = 1.0
            }
        }
    }
    
}

extension IDQResultView: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        setupCellAnimation()
        return quiz?.questions.count ?? 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: IDQResultCollectionViewCell.cellIdentifier, for: indexPath) as? IDQResultCollectionViewCell else {
            fatalError("Unsupported cell")
        }
        if quiz != nil {
            cell.configure(with: quiz!, index: indexPath.row)
            if !cellsAnimated[indexPath.row] {
                cell.alpha = 0.0
            }
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
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        guard let cell = cell as? IDQResultCollectionViewCell else { return }
        
        if !cellsAnimated[indexPath.row] {
            cellsAnimated[indexPath.row] = true
            
            animate(cell: cell, collectionView: collectionView, indexPath: indexPath)
        } else {
            cell.alpha = 1.0
            cell.transform = CGAffineTransform.identity
        }
        
    }

}
