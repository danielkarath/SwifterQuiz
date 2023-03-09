//
//  IDQPlayView.swift
//  iOSDevQuiz
//
//  Created by Daniel Karath on 3/2/23.
//

import UIKit

protocol IDQPlayViewDelegate: AnyObject {
    func idqPlayView(_ playView: IDQPlayView, didSelect game: IDQGame?)
}

/// The view that handles showing the main game related buttons like start quiz, game options, resources and related UI.
class IDQPlayView: UIView {
    
    public weak var delegate: IDQPlayViewDelegate?
        
    private let startButtonView = StartButtonView()
    
    private let menuButtonWidth: CGFloat = UIScreen.main.bounds.width * 0.80
    private let menuButtonHight: CGFloat = 48.0
    private let menuButtonCornerRadius: CGFloat = 8.0
    private let menuButtonFontSize: CGFloat = 24.0
    
    private let topBackgroundSize: CGFloat = UIScreen.main.bounds.width*3
    
    private let topBackgroundView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let appIconMiniImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = IDQConstants.appIconMiniature
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "iOS Developer Quiz"
        label.numberOfLines = 1
        label.textAlignment = .center
        label.textColor = IDQConstants.brandingColor
        label.font = IDQConstants.setFont(fontSize: 21, isBold: true)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let subTitle: UILabel = {
        let label = UILabel()
        label.text = "practice with 300+ questions"
        label.numberOfLines = 1
        label.textAlignment = .center
        label.textColor = IDQConstants.secondaryFontColor
        label.font = IDQConstants.setFont(fontSize: 11, isBold: false)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let quizOptionsButton: UIButton = {
        let button = UIButton()
        return button
    }()
    
    private let questionBankButton: UIButton = {
        let button = UIButton()
        return button
    }()
    
    //MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
        setupConstraints()
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(startViewTapped(_:)))
        addGestureRecognizer(tapGesture)
    }
    
    required init?(coder: NSCoder) {
        fatalError("IDQPlayView is unsupported!")
    }
    
    private func setupView() {
        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = IDQConstants.backgroundColor
        topBackgroundView.frame.size = CGSize(width: topBackgroundSize, height: topBackgroundSize)
        topBackgroundView.layer.cornerRadius = topBackgroundSize/2
        topBackgroundView.gradient(IDQConstants.highlightedContentBackgroundColor.cgColor, IDQConstants.contentBackgroundColor.cgColor, direction: .bottomLeftToTopRight)
    }
    
    //MARK: - Private
    
    private func setupConstraints() {
        addSubviews(topBackgroundView, appIconMiniImageView, titleLabel, subTitle, quizOptionsButton, questionBankButton, startButtonView)
        NSLayoutConstraint.activate([
            topBackgroundView.topAnchor.constraint(equalTo: topAnchor, constant: -topBackgroundSize/1.15),
            topBackgroundView.centerXAnchor.constraint(equalTo: centerXAnchor, constant: 0),
            topBackgroundView.widthAnchor.constraint(equalToConstant: topBackgroundSize),
            topBackgroundView.heightAnchor.constraint(equalToConstant: topBackgroundSize),
            
            appIconMiniImageView.heightAnchor.constraint(equalToConstant: 64),
            appIconMiniImageView.widthAnchor.constraint(equalToConstant: 64),
            appIconMiniImageView.centerXAnchor.constraint(equalTo: centerXAnchor, constant: 0),
            appIconMiniImageView.topAnchor.constraint(equalTo: topAnchor, constant: 16),
            
            subTitle.heightAnchor.constraint(equalToConstant: 18),
            subTitle.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width*0.60),
            subTitle.centerXAnchor.constraint(equalTo: centerXAnchor, constant: 0),
            subTitle.topAnchor.constraint(equalTo: appIconMiniImageView.bottomAnchor, constant: 16),
            
            titleLabel.heightAnchor.constraint(equalToConstant: 26),
            titleLabel.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width*0.80),
            titleLabel.centerXAnchor.constraint(equalTo: centerXAnchor, constant: 0),
            titleLabel.topAnchor.constraint(equalTo: subTitle.bottomAnchor, constant: 0),
            
            startButtonView.heightAnchor.constraint(equalToConstant: 1.80*menuButtonHight),
            startButtonView.widthAnchor.constraint(equalToConstant: menuButtonWidth),
            startButtonView.centerXAnchor.constraint(equalTo: centerXAnchor, constant: 0),
            startButtonView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 48),
            
            quizOptionsButton.heightAnchor.constraint(equalToConstant: menuButtonHight),
            quizOptionsButton.widthAnchor.constraint(equalToConstant: menuButtonWidth),
            quizOptionsButton.centerXAnchor.constraint(equalTo: centerXAnchor, constant: 0),
            quizOptionsButton.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: CGFloat(56+menuButtonHight)),
            
            questionBankButton.heightAnchor.constraint(equalToConstant: menuButtonHight),
            questionBankButton.widthAnchor.constraint(equalToConstant: menuButtonWidth),
            questionBankButton.centerXAnchor.constraint(equalTo: centerXAnchor, constant: 0),
            questionBankButton.topAnchor.constraint(equalTo: quizOptionsButton.bottomAnchor, constant: 14),
        ])
        //playView.delegate = self
    }
    
    private func setupButtons(_ buttons: [UIButton], titles: [String]) {
        var i: Int = 0
        for button in buttons {
            if i == 0 {
                setupButton(button, title: titles[i], isHeroButton: true)
            } else {
                setupButton(button, title: titles[i])
            }
            i = i + 1
        }
    }
    
    private func setupButton(_ button: UIButton, title: String, isHeroButton: Bool = false) {
        button.frame.size = CGSize(width: menuButtonWidth, height: menuButtonHight)
        button.layer.cornerRadius = menuButtonCornerRadius
        button.clipsToBounds = true
        button.translatesAutoresizingMaskIntoConstraints = false
        button.isAccessibilityElement = true
        button.accessibilityLabel = title
        if isHeroButton {
            let color1: UIColor = IDQConstants.lightOrange
            let color2: UIColor = IDQConstants.darkOrange
            button.addAttributedTitle(title: title, fontSize: menuButtonFontSize, fontColor: IDQConstants.backgroundColor, highlightColor: IDQConstants.contentBackgroundColor)
            button.gradient(color1.cgColor, color2.cgColor, direction: .bottomLeftToTopRight)
        } else {
            let backgroundColor: UIColor = IDQConstants.contentBackgroundColor
            button.backgroundColor = backgroundColor
            button.addAttributedTitle(title: title, fontSize: menuButtonFontSize, fontColor: IDQConstants.basicFontColor, highlightColor: IDQConstants.highlightFontColor)
        }
        switch button {
        case quizOptionsButton:
            button.addTarget(self, action: #selector(optionsButtonTapped(_:)), for: .touchUpInside)
        case questionBankButton:
            button.addTarget(self, action: #selector(questionBankButtonTapped(_:)), for: .touchUpInside)
        default:
            print("ERROR - UNKNOWN value: Unknown button found while trying to setup setupButtons in IDQPlayView")
        }
    }
    
    @objc
    private func optionsButtonTapped(_ sender: UIButton) {
        
    }
    
    @objc
    private func questionBankButtonTapped(_ sender: UIButton) {
        
    }
    
    @objc
    private func startViewTapped(_ gestureRecognizer: UITapGestureRecognizer) {
        let idqGameList: [IDQGame] = [
            IDQGame(gameName: "Default", type: .basic, questionTimer: .gazelle, topics: [.basics], numberOfQuestions: 10),
            IDQGame(gameName: "Count Down", type: .trueOrFalse, questionTimer: .cheetah, topics: [.basics], numberOfQuestions: 15),
            IDQGame(gameName: "True Or False", type: .trueOrFalse, questionTimer: .cheetah, topics: [.basics, .architecturalPatterns, .coreData, .combine, .cloudKit], numberOfQuestions: 15),
        ]
        delegate?.idqPlayView(self, didSelect: idqGameList[0])
    }
    
    
}
