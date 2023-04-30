//
//  IDQPlayView.swift
//  iOSDevQuiz
//
//  Created by Daniel Karath on 3/2/23.
//

import UIKit
import StoreKit

protocol IDQPlayViewDelegate: AnyObject {
    func idqPlayView(_ playView: IDQPlayView, didSelect game: IDQGame?)
    func idqPlayView(_ playView: IDQPlayView, bookmarkedQuestions: [IDQQuestion]?)
}

/// The view that handles showing the main game related buttons like start quiz, game options, resources and related UI.
class IDQPlayView: UIView { //852 393
    
    public weak var delegate: IDQPlayViewDelegate?
    
    private let viewModel = IDQPlayViewViewModel()
        
    private let startButtonView = StartButtonView()
    
    private let rateTheAppView = IDQRateTheAppView()
    
    private var bookmarkedQuestions: [IDQQuestion]?
    
    private let appIconTopAnchor: CGFloat = UIScreen.screenHeight * 0.018779
    private let appIconSize: CGFloat = UIScreen.screenHeight * 0.075117
    
    private let subTitleHeight: CGFloat = UIScreen.screenHeight * 0.019101
    private let titleHeight: CGFloat = UIScreen.screenHeight * 0.030480
    
    private let menuTopDistance: CGFloat = UIScreen.screenHeight * 0.0375586
    
    private let menuButtonWidth: CGFloat = UIScreen.screenWidth < 1000 ? UIScreen.screenWidth * 0.80 : 720
    private let menuButtonHight: CGFloat = UIScreen.screenHeight * 0.05633803 //0.0375586       48
    private let menuButtonCornerRadius: CGFloat = 8.0
    private let menuButtonFontSize: CGFloat = 24.0
    
    private let topBackgroundSize: CGFloat = UIScreen.screenWidth*3
    
    private var isShimmerAnimationsOn: Bool = false
    
    private let gradientView = UIView()
    
    private let spinner: UIActivityIndicatorView = {
        let spinner = UIActivityIndicatorView(style: .large)
        spinner.hidesWhenStopped = true
        spinner.translatesAutoresizingMaskIntoConstraints = false
        spinner.tintColor = IDQConstants.basicFontColor
        spinner.layer.zPosition = 9
        return spinner
    }()
    
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
    
    private let titleLabel: GradientLabel = {
        let label = GradientLabel()
        label.text = "Swifter Quiz"
        label.numberOfLines = 1
        label.textAlignment = .center
        label.textColor = .clear.withAlphaComponent(0)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let subTitle: UILabel = {
        let label = UILabel()
        label.text = "Elevate your Swift game!"
        label.numberOfLines = 1
        label.textAlignment = .center
        label.textColor = IDQConstants.secondaryFontColor
        label.font = IDQConstants.setFont(fontSize: 11, isBold: false)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let quickQuizDescriptionLabel: UILabel = {
        let label = UILabel()
        label.text = "10 multiple choice questions related to the Swift programming language"
        label.numberOfLines = 0
        label.textAlignment = .left
        label.textColor = IDQConstants.secondaryFontColor
        label.font = IDQConstants.setFont(fontSize: 11, isBold: false)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let bookmarkedQuestionsButton: UIButton = {
        let button = UIButton()
        let size: CGFloat = 40
        let image = UIImage(systemName: "bookmark.fill")!
        let color = IDQConstants.highlightedDarkOrange
        
        button.translatesAutoresizingMaskIntoConstraints = false
        button.isHidden = true
        
        button.frame.size = CGSize(width: size, height: size)
        button.layer.cornerRadius = 8
        button.setTitleColor(IDQConstants.highlightedDarkOrange, for: .normal)
        button.tintColor = color
        
        let gradientImageView = GradientImageView(image: image)
        gradientImageView.frame = CGRect(x: 0, y: 0, width: size * 0.60, height: size * 0.60)
        gradientImageView.contentMode = .scaleAspectFit
        gradientImageView.center = button.center
        gradientImageView.isUserInteractionEnabled = false
        
        button.addSubview(gradientImageView)

        return button
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
        addSubviews(gradientView, topBackgroundView, appIconMiniImageView, titleLabel, subTitle, quizOptionsButton, questionBankButton, startButtonView, rateTheAppView, bookmarkedQuestionsButton, quickQuizDescriptionLabel)
        setupConstraints()
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(startViewTapped(_:)))
        startButtonView.addGestureRecognizer(tapGesture)
        bookmarkedQuestions = viewModel.fetchBookmarkedQuestions()
        setupBookmarkedButton()
        titleLabel.font = IDQConstants.setFont(fontSize: titleHeight * 0.80, isBold: true)
        subTitle.font = IDQConstants.setFont(fontSize: subTitleHeight * 0.80, isBold: false)
        quickQuizDescriptionLabel.font = IDQConstants.setFont(fontSize: subTitleHeight * 0.80, isBold: false)
        let notificationCenter = NotificationCenter.default
        notificationCenter.addObserver(self, selector: #selector(appMovedToBackground), name: UIApplication.didEnterBackgroundNotification, object: nil)
        notificationCenter.addObserver(self, selector: #selector(appWillMoveToForeground), name: UIApplication.willEnterForegroundNotification, object: nil)

    }
    
    required init?(coder: NSCoder) {
        fatalError("IDQPlayView is unsupported!")
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }

    override func didMoveToWindow() {
        super.didMoveToWindow()
        if window != nil {
            if !isShimmerAnimationsOn {
                startButtonView.startShimmerAnimation(duration: 0.5, delay: 6.00, direction: .topLeftToBottomRight)
                isShimmerAnimationsOn.toggle()
            }
        } else {
            isShimmerAnimationsOn = false
            startButtonView.stopShimmerAnimation()
        }
    }
    
    @objc
    private func appMovedToBackground() {
        isShimmerAnimationsOn = false
        startButtonView.stopShimmerAnimation()
    }
    
    @objc
    private func appWillMoveToForeground() {
        if !isShimmerAnimationsOn && window != nil {
            startButtonView.startShimmerAnimation(duration: 0.5, delay: 6.00, direction: .topLeftToBottomRight)
            isShimmerAnimationsOn.toggle()
        }
    }
    
    private func setupView() {
        let color1: UIColor = IDQConstants.highlightedLightOrange
        let color2: UIColor = IDQConstants.highlightedDarkOrange
        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = IDQConstants.backgroundColor
        topBackgroundView.backgroundColor = IDQConstants.contentBackgroundColor
        topBackgroundView.frame.size = CGSize(width: topBackgroundSize, height: topBackgroundSize)
        topBackgroundView.layer.cornerRadius = topBackgroundSize/2
        bookmarkedQuestionsButton.addTarget(self, action: #selector(bookmarkedQuestionsButtonTapped(_:)), for: .touchUpInside)
        rateTheAppView.delegate = self
//        titleLabel.formatGradientLabel(gradientView: gradientView)
    }
    
    //MARK: - Private
    
    public func setupConstraints() {
        NSLayoutConstraint.deactivate(gradientView.constraints)
        NSLayoutConstraint.deactivate(topBackgroundView.constraints)
        
        var topOffset: CGFloat = topBackgroundSize/1.15
        if UIScreen.physicalScreenHeight  > 1000 {
            topOffset = topBackgroundSize/1.09
        }
        
        NSLayoutConstraint.activate([
            topBackgroundView.topAnchor.constraint(equalTo: topAnchor, constant: -topOffset),
            topBackgroundView.centerXAnchor.constraint(equalTo: centerXAnchor, constant: 0),
            topBackgroundView.widthAnchor.constraint(equalToConstant: topBackgroundSize),
            topBackgroundView.heightAnchor.constraint(equalToConstant: topBackgroundSize),
            
            bookmarkedQuestionsButton.topAnchor.constraint(equalTo: topAnchor, constant: 0),
            bookmarkedQuestionsButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8),
            bookmarkedQuestionsButton.widthAnchor.constraint(equalToConstant: 60),
            bookmarkedQuestionsButton.heightAnchor.constraint(equalToConstant: 60),
            
            appIconMiniImageView.heightAnchor.constraint(equalToConstant: appIconSize),
            appIconMiniImageView.widthAnchor.constraint(equalToConstant: appIconSize),
            appIconMiniImageView.centerXAnchor.constraint(equalTo: centerXAnchor, constant: 0),
            appIconMiniImageView.topAnchor.constraint(equalTo: topAnchor, constant: appIconTopAnchor),
            
            subTitle.heightAnchor.constraint(equalToConstant: subTitleHeight),
            subTitle.widthAnchor.constraint(equalToConstant: UIScreen.screenWidth*0.60),
            subTitle.centerXAnchor.constraint(equalTo: centerXAnchor, constant: 0),
            subTitle.topAnchor.constraint(equalTo: appIconMiniImageView.bottomAnchor, constant: 16),
            
            titleLabel.heightAnchor.constraint(equalToConstant: titleHeight),
            titleLabel.widthAnchor.constraint(equalToConstant: UIScreen.screenWidth*0.80),
            titleLabel.centerXAnchor.constraint(equalTo: centerXAnchor, constant: 0),
            titleLabel.topAnchor.constraint(equalTo: subTitle.bottomAnchor, constant: 0),
            
            startButtonView.heightAnchor.constraint(equalToConstant: 1.80*menuButtonHight),
            startButtonView.widthAnchor.constraint(equalToConstant: menuButtonWidth),
            startButtonView.centerXAnchor.constraint(equalTo: centerXAnchor, constant: 0),
            startButtonView.topAnchor.constraint(equalTo: topBackgroundView.bottomAnchor, constant: menuTopDistance),
            
            quickQuizDescriptionLabel.heightAnchor.constraint(equalToConstant: 40),
            quickQuizDescriptionLabel.topAnchor.constraint(equalTo: startButtonView.bottomAnchor, constant: 4),
            quickQuizDescriptionLabel.widthAnchor.constraint(equalToConstant: menuButtonWidth-12),
            quickQuizDescriptionLabel.centerXAnchor.constraint(equalTo: centerXAnchor, constant: 0),
            
            rateTheAppView.heightAnchor.constraint(equalToConstant: 1.80*menuButtonHight),
            rateTheAppView.widthAnchor.constraint(equalToConstant: menuButtonWidth),
            rateTheAppView.centerXAnchor.constraint(equalTo: centerXAnchor, constant: 0),
            rateTheAppView.topAnchor.constraint(equalTo: topBackgroundView.bottomAnchor, constant: menuTopDistance),
            
            quizOptionsButton.heightAnchor.constraint(equalToConstant: menuButtonHight),
            quizOptionsButton.widthAnchor.constraint(equalToConstant: menuButtonWidth),
            quizOptionsButton.centerXAnchor.constraint(equalTo: centerXAnchor, constant: 0),
            quizOptionsButton.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: CGFloat(56+menuButtonHight)),
            
            questionBankButton.heightAnchor.constraint(equalToConstant: menuButtonHight),
            questionBankButton.widthAnchor.constraint(equalToConstant: menuButtonWidth),
            questionBankButton.centerXAnchor.constraint(equalTo: centerXAnchor, constant: 0),
            questionBankButton.topAnchor.constraint(equalTo: quizOptionsButton.bottomAnchor, constant: 14),
        ])
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
    
    @objc func bookmarkedQuestionsButtonTapped(_ sender: UIButton){
        let questions = viewModel.fetchBookmarkedQuestions()
        bookmarkedQuestionsButton.didHighlight(with: IDQConstants.contentBackgroundColor.withAlphaComponent(0.40))
        delegate?.idqPlayView(self, bookmarkedQuestions: questions)
    }
    
    @objc
    private func startViewTapped(_ gestureRecognizer: UITapGestureRecognizer) {
        startButtonView.didHighlight(with: IDQConstants.contentBackgroundColor.withAlphaComponent(0.40))
        let selectedGame = viewModel.didTapButton(for: .quicQuiz)
        delegate?.idqPlayView(self, didSelect: selectedGame)
    }
    
    //MARK: - Public
    
    public func setupBookmarkedButton() {
        bookmarkedQuestions = viewModel.fetchBookmarkedQuestions()
        if !(bookmarkedQuestions?.isEmpty ?? true) {
            bookmarkedQuestionsButton.isHidden = false
        }
    }
    
    public func shouldDisplayRateAppView() {
        if viewModel.shouldDisplay(view: rateTheAppView) && rateTheAppView.isHidden {
            let yDistance: CGFloat = 1.80*menuButtonHight + 24
            rateTheAppView.isHidden = false
            UIView.animate(withDuration: 2.0, delay: 0.10, usingSpringWithDamping: 0.90, initialSpringVelocity: 0.10, options: [], animations: {
                self.startButtonView.transform = CGAffineTransform(translationX: 0, y: yDistance)
                self.quickQuizDescriptionLabel.transform = CGAffineTransform(translationX: 0, y: yDistance)
                self.rateTheAppView.alpha = 1.0
            }, completion: nil)
        } else if startButtonView.transform == .identity {
            rateTheAppView.isHidden = true
            rateTheAppView.alpha = 0.0
        } else {
            rateTheAppView.isHidden = false
            rateTheAppView.alpha = 1.0
        }
    }
    
    public func shouldHideRateAppView() {
        UIView.animate(withDuration: 0.4, delay: 0.10, usingSpringWithDamping: 0.90, initialSpringVelocity: 0.10, options: [], animations: {
            self.rateTheAppView.alpha = 0.0
        }, completion: { _ in
            UIView.animate(withDuration: 1.0, animations: {
                self.startButtonView.transform = CGAffineTransform(translationX: 0, y: 0)
                self.quickQuizDescriptionLabel.transform = CGAffineTransform(translationX: 0, y: 0)
            }, completion: { _ in
                self.rateTheAppView.isHidden = true
            })
        })
    }
}

extension IDQPlayView: IDQRateTheAppViewDelegate {
    func didTapClose() {
        viewModel.didCloseRate()
        shouldHideRateAppView()
    }
    
    func didRateApp() {
        guard  let scene = self.window?.windowScene else {
            print("No scene found for Rate window")
            return
        }
        let didRateApp = UserDefaults.standard.bool(forKey: "didRateApp")
        
        if !didRateApp {
            SKStoreReviewController.requestReview(in: scene)
        } else {
            let urlString = "//itunes.apple.com/app/id\(IDQConstants.appID)"
            if let url = URL(string: urlString) { ///itms-apps://itunes.apple.com
                UIApplication.shared.open(url) 
            }
        }
        viewModel.didRateApp()
        shouldHideRateAppView()
    }
    
}
