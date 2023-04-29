//
//  IDQResultView.swift
//  iOSDevQuiz
//
//  Created by Daniel Karath on 3/21/23.
//

import UIKit

protocol IDQResultViewDelegate: AnyObject {
    func idqResultView(_: IDQResultView, didTap button: UIButton)
    func idqResultView(_ view: IDQResultView, didShare quiz: IDQQuiz, image: UIImage?)
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
    
    private let topBackgroundSize: CGFloat = UIScreen.screenWidth*3
    
    private var menuButtonWidth: CGFloat = {
        var value: CGFloat = (UIScreen.screenWidth - (50+64+16))
        if UIScreen.screenWidth > 1100 {
            var value: CGFloat = (UIScreen.screenHeight - (50+64+16))
        }
        return value
    }()
    
    private let topBackgroundView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let questionsSubTitleLabel: UILabel = {
        let label = UILabel()
        let fontSize: CGFloat = UIScreen.screenHeight * 0.01524033
        label.text = "Questions"
        label.numberOfLines = 1
        label.textAlignment = .left
        label.textColor = IDQConstants.basicFontColor
        label.font = IDQConstants.setFont(fontSize: fontSize, isBold: true)
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
//        topBackgroundView.backgroundColor = IDQConstants.contentBackgroundColor
//        topBackgroundView.frame.size = CGSize(width: topBackgroundSize, height: topBackgroundSize)
//        topBackgroundView.layer.cornerRadius = topBackgroundSize/2
        menuButton.frame.size = CGSize(width: menuButtonWidth, height: 50)
        menuButton.gradient(color1.cgColor, color2.cgColor, direction: .bottomLeftToTopRight)
        menuButton.clipsToBounds = true
        menuButton.layer.cornerRadius = 8
        
        menuButton.addTarget(self, action: #selector(menuButtonTapped(_:)), for: .touchUpInside)
        shareButton.addTarget(self, action: #selector(share(_:)), for: .touchUpInside)
    }
    
    private func setupCollectionView() {
        questionsCollectionView.delegate = self
        questionsCollectionView.dataSource = self
    }
    
    //MARK: - Private
    
    private func setupConstraints() {
                
        let collectionViewLeadingAnchor: CGFloat = UIScreen.screenHeight * 0.00937866
        
        var statsViewHeight: CGFloat = UIScreen.screenHeight * 0.05627198
        var statsViewWidth: CGFloat = UIScreen.screenHeight * 0.10550996
        var midoffset: CGFloat = UIScreen.screenHeight < 1080 ? 32 : 72
        
        if UIScreen.screenWidth > 1000 {
            statsViewHeight = UIScreen.screenWidth * 0.1425655
            statsViewWidth = UIScreen.screenWidth * 0.285131
        } else if UIScreen.screenHeight  > 1000 {
            statsViewHeight = UIScreen.screenHeight * 0.07033998
            statsViewWidth = UIScreen.screenHeight * 0.14067995
        }
        
        addSubviews(scoreView, timeView, percentageView, questionsSubTitleLabel, questionsCollectionView, menuButton, shareButton)
        NSLayoutConstraint.activate([
            
            scoreView.topAnchor.constraint(equalTo: topAnchor, constant: 32),
            scoreView.trailingAnchor.constraint(equalTo: timeView.leadingAnchor, constant: -48),
            scoreView.widthAnchor.constraint(equalToConstant: statsViewWidth),
            scoreView.heightAnchor.constraint(equalToConstant: statsViewHeight),
            
            timeView.topAnchor.constraint(equalTo: topAnchor, constant: 32),
            timeView.centerXAnchor.constraint(equalTo: centerXAnchor),
            timeView.widthAnchor.constraint(equalToConstant: statsViewWidth),
            timeView.heightAnchor.constraint(equalToConstant: statsViewHeight),
            
            percentageView.topAnchor.constraint(equalTo: topAnchor, constant: 32),
            percentageView.leadingAnchor.constraint(equalTo: timeView.trailingAnchor, constant: 48),
            percentageView.widthAnchor.constraint(equalToConstant: statsViewWidth),
            percentageView.heightAnchor.constraint(equalToConstant: statsViewHeight),
            
            questionsSubTitleLabel.topAnchor.constraint(equalTo: scoreView.bottomAnchor, constant: midoffset),
            questionsSubTitleLabel.heightAnchor.constraint(equalToConstant: 30),
            questionsSubTitleLabel.widthAnchor.constraint(equalToConstant: 160),
            questionsSubTitleLabel.leadingAnchor.constraint(equalTo: scoreView.leadingAnchor, constant: 8),

            questionsCollectionView.topAnchor.constraint(equalTo: questionsSubTitleLabel.bottomAnchor, constant: 2),
            questionsCollectionView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: collectionViewLeadingAnchor),
            questionsCollectionView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -collectionViewLeadingAnchor),
            questionsCollectionView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -128),

            shareButton.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -32),
            shareButton.leadingAnchor.constraint(equalTo: scoreView.leadingAnchor, constant: 0),
            shareButton.widthAnchor.constraint(equalToConstant: 50),
            shareButton.heightAnchor.constraint(equalToConstant: 50),
            
            menuButton.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -32),
            menuButton.leadingAnchor.constraint(equalTo: scoreView.leadingAnchor, constant: 24+50),
            menuButton.widthAnchor.constraint(equalToConstant: menuButtonWidth),
            menuButton.heightAnchor.constraint(equalToConstant: 50),
        ])
    }
    
    @objc
    private func menuButtonTapped(_ sender: UIButton) {
        delegate?.idqResultView(self, didTap: menuButton)
    }
    
    @objc func share(_ sender: UIButton){
        guard let quiz = self.quiz else {return}
        delegate?.idqResultView(self, didShare: quiz, image: nil)
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
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.60) {
            self.questionsCollectionView.isUserInteractionEnabled = true
            UIView.animate(withDuration: 0.85) {
                self.questionsCollectionView.alpha = 1.0
                self.questionsSubTitleLabel.alpha = 1.0
            }
        }
        
        let serialQueue = DispatchQueue(label: "saveMetrics.serial.queue")

        serialQueue.async {
            print("EvaulateStreak")
            self.viewModel.evaulateStreak()
            print("Save quiz")
            self.viewModel.save(quiz: quiz)
        }
        serialQueue.async {
            print("Save To DaytimeActivity")
            self.viewModel.saveToDaytimeActivity(quiz)
            print("Save To User Records")
            self.viewModel.saveToUserRecords(quiz)
            print("Quiz Date: \(quiz.date)")
        }
        
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
        
        let width = UIScreen.screenWidth - ((UIScreen.screenHeight * 0.00937866) * 6)
        
        var height: CGFloat?
        if UIScreen.screenWidth > 1000 {
            height = width * 0.18
        } else if UIScreen.physicalScreenHeight  > 1080 {
            height = width * 0.26
        } else {
            height = width * 0.40
        }

        return CGSize(width: width, height: height ?? width * 0.40)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
    }


}
