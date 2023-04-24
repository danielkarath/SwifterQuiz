//
//  IDQAnswerResultView.swift
//  iOSDevQuiz
//
//  Created by Daniel Karath on 3/14/23.
//

import UIKit
import SafariServices

protocol IDQAnswerResultViewDelegate: AnyObject {
    func didTapContinue(_ answerResultView: IDQAnswerResultView)
    func didTapDisableQuestion(_ answerResultView: IDQAnswerResultView, for question: IDQQuestion)
}

class IDQAnswerResultView: UIView {
    
    private let questionManager = IDQQuestionManager()
    private let userManager = IDQUserManager()
    
    public weak var delegate: IDQAnswerResultViewDelegate?

    private var question: IDQQuestion?
    
    private var answerType: IDQAnswerType?
    
    private var imageSize: CGFloat = {
        var returnValue: CGFloat = 0
        if UIScreen.screenHeight < 980 {
            returnValue = 24
        } else if UIScreen.screenHeight < 1100 {
            returnValue = 34
        } else {
            returnValue = 40
        }
        return returnValue
    }()
    
    private var actionButtonHeight: CGFloat = {
        var returnValue: CGFloat = 50
        if UIScreen.screenHeight < 980 {
            returnValue = 50
        } else if UIScreen.screenHeight < 1100 {
            returnValue = 60
        } else {
            returnValue = 80
        }
        return returnValue
    }()
    
    private let resultImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.cornerRadius = 4
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let resultLabel: UILabel = {
        let label = UILabel()
        var fontSize: CGFloat = 20
        if UIScreen.screenHeight < 980 {
            fontSize = 20
        } else if UIScreen.screenHeight < 1100 {
            fontSize = 24
        } else {
            fontSize = 28
        }
        label.text = " "
        label.numberOfLines = 1
        label.textAlignment = .left
        label.font = IDQConstants.setFont(fontSize: fontSize, isBold: true)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let detailLabel: UILabel = {
        let label = UILabel()
        var fontSize: CGFloat = 14
        if UIScreen.screenHeight < 980 {
            fontSize = 14
        } else if UIScreen.screenHeight < 1100 {
            fontSize = 20
        } else {
            fontSize = 24
        }
        label.text = "This is some explanation to the result so you can better understand it or whatever."
        label.numberOfLines = 0
        label.textAlignment = .left
        label.contentMode = .top
        label.font = IDQConstants.setFont(fontSize: fontSize, isBold: false)
        label.textColor = IDQConstants.correctColor
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let referenceButton: UIButton = {
        let button = UIButton()
        button.setTitle("", for: .normal)
        button.isUserInteractionEnabled = true
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let bookmarkButton: UIButton = {
        let button = UIButton()
        button.setTitle("", for: .normal)
        button.isUserInteractionEnabled = true
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let discardQuestionButton: UIButton = {
        let button = UIButton()
        button.setTitle("", for: .normal)
        button.isUserInteractionEnabled = true
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let continueButton: UIButton = {
        let button = UIButton()
        var fontSize: CGFloat = 20
        if UIScreen.screenHeight < 980 {
            fontSize = 20
        } else if UIScreen.screenHeight < 1100 {
            fontSize = 24
        } else {
            fontSize = 28
        }
        button.frame.size = CGSize(width: UIScreen.screenWidth-32, height: 40) //.size = CGSize(width: width, height: height)
        button.layer.cornerRadius = 8
        button.setTitleColor(IDQConstants.contentBackgroundColor, for: .normal)
        button.backgroundColor = IDQConstants.secondaryFontColor
        button.titleLabel?.font = IDQConstants.setFont(fontSize: fontSize, isBold: true)
        button.setTitle("CONTINUE", for: .normal)
        button.setTitle("CONTINUE", for: .highlighted)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.isUserInteractionEnabled = true
        return button
    }()
    
    let referenceImageView = UIImageView(image: UIImage(systemName: "book.closed.fill"))
    
    let bookmarkUnfilledImageView = UIImageView(image: UIImage(systemName: "bookmark"))
    let bookmarkFilledImageView = UIImageView(image: UIImage(systemName: "bookmark.fill"))
    
    let noSignImageView = UIImageView(image: UIImage(systemName: "nosign"))
    
    private var isBookmarked: Bool = false
    
    private var continueTimer = Timer()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
        setupButtons()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("Unsupported")
    }
    
    
    //MARK: - Private
    
    private func setupView() {
        translatesAutoresizingMaskIntoConstraints = false
        self.layer.frame = CGRect(x: 0, y: 0, width: UIScreen.screenWidth, height: 240)
        backgroundColor = IDQConstants.contentBackgroundColor
        layer.cornerRadius = 16
        
        if question?.reference != nil {
            referenceButton.isHidden = false
        } else {
            referenceButton.isHidden = true
        }
        
        discardQuestionButton.addTarget(self, action: #selector(discardQuestionButtonButtonTapped(_:)), for: .touchUpInside)
        referenceButton.addTarget(self, action: #selector(referenceButtonTapped(_:)), for: .touchUpInside)
        bookmarkButton.addTarget(self, action: #selector(bookmarkButtonTapped(_:)), for: .touchUpInside)
        continueButton.addTarget(self, action: #selector(continueButtonTapped(_:)), for: .touchUpInside)
    }
    
    private func setupButtons() {
        let buttons: [UIButton] = [bookmarkButton, discardQuestionButton, referenceButton]
        let imageViews: [UIImageView] = [bookmarkUnfilledImageView, noSignImageView, referenceImageView, bookmarkFilledImageView]
        
        var i: Int = 0
        for imageView in imageViews {
            if i <= buttons.count - 1 {
                let button = buttons[i]
                imageView.tintColor = IDQConstants.correctColor
                imageView.frame = CGRect(x: button.layer.frame.minX, y: button.layer.frame.minY, width: imageSize, height: imageSize)
                imageView.contentMode = .scaleAspectFit
                button.addSubview(imageView)
                i += 1
            } else {
                imageView.tintColor = IDQConstants.correctColor
                imageView.frame = CGRect(x: bookmarkButton.layer.frame.minX, y: bookmarkButton.layer.frame.minY, width: imageSize, height: imageSize)
                imageView.contentMode = .scaleAspectFit
                i = 0
            }
        }
        
        for button in buttons {
            button.frame.size = CGSize(width: imageSize, height: imageSize)
            button.clipsToBounds = true
            
        }
    }
    
    private func setupConstraints() {
        var resultImageViewheight: CGFloat = 32
        var resultImageViewoffset: CGFloat = 16
        var resultLabelWidth: CGFloat = 160
        var imageViewMidOffset: CGFloat = 16

        if UIScreen.screenHeight < 980 {
            resultImageViewheight = 32
            resultImageViewoffset = 16
            resultLabelWidth = 160
            imageViewMidOffset = 16
        } else if UIScreen.screenHeight < 1100 {
            resultImageViewheight = 40
            resultImageViewoffset = 20
            resultLabelWidth = 200
            imageViewMidOffset = 20
        } else {
            resultImageViewheight = 48
            resultImageViewoffset = 24
            resultLabelWidth = 230
            imageViewMidOffset = 24
        }
        
        
        addSubviews(resultLabel, resultImageView, continueButton, detailLabel, referenceButton, bookmarkButton, discardQuestionButton)
        NSLayoutConstraint.activate([
            resultImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: resultImageViewoffset),
            resultImageView.widthAnchor.constraint(equalToConstant: resultImageViewheight),
            resultImageView.heightAnchor.constraint(equalToConstant: resultImageViewheight),
            resultImageView.topAnchor.constraint(equalTo: topAnchor, constant: resultImageViewoffset),
            
            resultLabel.leadingAnchor.constraint(equalTo: resultImageView.trailingAnchor, constant: 12),
            resultLabel.centerYAnchor.constraint(equalTo: resultImageView.centerYAnchor, constant: 2),
            resultLabel.widthAnchor.constraint(equalToConstant: resultLabelWidth),
            resultLabel.heightAnchor.constraint(equalToConstant: 40),
            
            bookmarkButton.centerYAnchor.constraint(equalTo: resultImageView.centerYAnchor, constant: 0),
            bookmarkButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -32),
            bookmarkButton.heightAnchor.constraint(equalToConstant: imageSize),
            bookmarkButton.widthAnchor.constraint(equalToConstant: imageSize),
            
            discardQuestionButton.centerYAnchor.constraint(equalTo: resultImageView.centerYAnchor, constant: 0),
            discardQuestionButton.trailingAnchor.constraint(equalTo: bookmarkButton.leadingAnchor, constant: -imageViewMidOffset),
            discardQuestionButton.heightAnchor.constraint(equalToConstant: imageSize),
            discardQuestionButton.widthAnchor.constraint(equalToConstant: imageSize),
            
            referenceButton.centerYAnchor.constraint(equalTo: resultImageView.centerYAnchor, constant: 0),
            referenceButton.trailingAnchor.constraint(equalTo: discardQuestionButton.leadingAnchor, constant: -imageViewMidOffset),
            referenceButton.heightAnchor.constraint(equalToConstant: imageSize),
            referenceButton.widthAnchor.constraint(equalToConstant: imageSize),
            
            detailLabel.topAnchor.constraint(equalTo: resultImageView.bottomAnchor, constant: 4),
            detailLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: resultImageViewoffset),
            detailLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -resultImageViewoffset),
            detailLabel.bottomAnchor.constraint(equalTo: continueButton.topAnchor, constant: -8),
            
            continueButton.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -92),
            continueButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: resultImageViewoffset),
            continueButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -resultImageViewoffset),
            continueButton.heightAnchor.constraint(equalToConstant: actionButtonHeight)
        ])
    }
    
    private func resetView() {
        if isBookmarked {
            DispatchQueue.main.async {
                self.bookmarkFilledImageView.removeFromSuperview()
                self.bookmarkButton.addSubview(self.bookmarkUnfilledImageView)
                self.isBookmarked = false
            }
        }
    }
    
    private func configure(_view: IDQAnswerResultView, with design: IDQAnswerType) {
        var titleStringArray: [String] = []
        var backgroundColor: UIColor?
        var tintColor: UIColor?
        var iconName: String?
        self.answerType = design
        
        switch design {
        case .correct:
            titleStringArray = ["Awesome!", "Excellent!", "Correct", "Hoooray!", "Well done!", "Great job!", "Bravo!", "Very cool!", "Splendid!"]
            backgroundColor = IDQConstants.correctBackgroundColor
            tintColor = IDQConstants.correctColor
            iconName = "checkmark.circle.fill"
        case .wrong:
            titleStringArray =  ["Incorrect", "Incorrect", "Incorrect", "Wrong answer", "Oopsie"]
            backgroundColor = IDQConstants.errorBackgroundColor
            tintColor = IDQConstants.errorColor
            iconName = "x.circle.fill"
        case .runOutOfTime:
            titleStringArray =  ["Out of time"]
            backgroundColor = IDQConstants.warningBackgroundColor
            tintColor = IDQConstants.warningColor
            iconName = "clock.badge.exclamationmark"
        case .passed:
            titleStringArray =  ["Passed"]
            backgroundColor = IDQConstants.warningBackgroundColor
            tintColor = IDQConstants.warningColor
            iconName = "questionmark.square.dashed"
        case .leftQuestion:
            titleStringArray =  ["Left Game"]
            backgroundColor = IDQConstants.warningBackgroundColor
            tintColor = IDQConstants.warningColor
            iconName = "rectangle.portrait.and.arrow.forward"
        default:
            backgroundColor = IDQConstants.warningBackgroundColor
            tintColor = IDQConstants.warningColor
            iconName = "clock.badge.exclamationmark"
        }
        
        if question?.reference != nil {
            referenceButton.isHidden = false
        } else {
            referenceButton.isHidden = true
        }
        self.backgroundColor = backgroundColor
        self.resultImageView.tintColor = tintColor
        self.referenceImageView.tintColor = tintColor
        self.bookmarkUnfilledImageView.tintColor = tintColor
        self.bookmarkButton.tintColor = tintColor
        self.noSignImageView.tintColor = tintColor
        self.resultImageView.image = UIImage(systemName: iconName!)?.withTintColor(tintColor!, renderingMode: .alwaysTemplate)
        let randomIndex = Int.random(in: 0..<titleStringArray.count)
        self.resultLabel.text = titleStringArray[randomIndex]
        for label in [resultLabel, detailLabel] {
            label.textColor = tintColor
        }
        self.continueButton.backgroundColor = tintColor
    }
    
    @objc
    private func continueButtonTapped(_ sender: UIButton) {
        sender.isUserInteractionEnabled = false
        continueTimer = Timer.scheduledTimer(withTimeInterval: 3.0, repeats: false) {_ in
            sender.isUserInteractionEnabled = true
            self.continueTimer.invalidate()
        }
        delegate?.didTapContinue(self)
    }
    
    @objc
    private func referenceButtonTapped(_ sender: UIButton) {
        guard let question = self.question, self.question != nil, answerType != nil else {return}
        
        guard let referenceUrl = URL(string: question.reference!), IDQConstants.allowedDomainStrings.contains(referenceUrl.host ?? "") else {
            print("The website is not allowed")
            return
        }
        
        let safariViewController = SFSafariViewController(url: referenceUrl)
        safariViewController.modalPresentationStyle = .popover
        if let viewController = self.getViewController() {
            viewController.present(safariViewController, animated: true, completion: nil)
        }
        if referenceImageView.image != UIImage(systemName: "book.fill") {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.50) {
                self.referenceImageView.image = UIImage(systemName: "book.fill")
            }
        }
    }


    
    @objc
    private func bookmarkButtonTapped(_ sender: UIButton) {
        guard let question = self.question, self.question != nil else {return}
        if !isBookmarked {
            DispatchQueue.main.async {
                self.bookmarkUnfilledImageView.removeFromSuperview()
                self.bookmarkButton.addSubview(self.bookmarkFilledImageView)
            }
            DispatchQueue.global(qos: .background).async {
                self.questionManager.bookmark(question)
            }
        } else {
            DispatchQueue.main.async {
                self.bookmarkFilledImageView.removeFromSuperview()
                self.bookmarkButton.addSubview(self.bookmarkUnfilledImageView)
            }
            DispatchQueue.global(qos: .background).async {
                guard let user = self.userManager.fetchUser() else {
                    return
                }
                self.questionManager.removeBookmark(question, for: user)
            }
        }
        isBookmarked.toggle()
    }
    
    @objc
    private func discardQuestionButtonButtonTapped(_ sender: UIButton) {
        guard let question = self.question else {return}
        delegate?.didTapDisableQuestion(self, for: question)
    }
    
    //MARK: - Public
    public func idqAnswerResultView(_ view: IDQAnswerResultView, question: IDQQuestion, answeredCorrectly: Bool) {
        resetView()
        self.question = question
        detailLabel.text = question.explanation
        if answeredCorrectly {
            configure(_view: self, with: .correct)
        } else{
            configure(_view: self, with: .wrong)
        }
    }
    
    public func idqAnswerResultView(_ view: IDQAnswerResultView, question: IDQQuestion, didNotAnswer: IDQAnswerType) {
        resetView()
        self.question = question
        detailLabel.text = question.explanation
        if didNotAnswer == .runOutOfTime {
            configure(_view: self, with: .runOutOfTime)
        } else if didNotAnswer == .passed {
            configure(_view: self, with: .passed)
        } else {
            configure(_view: self, with: .leftQuestion)
        }
    }
    
}

extension IDQAnswerResultView: SFSafariViewControllerDelegate {
    func safariViewController(_ controller: SFSafariViewController, shouldLoad url: URL, for policy: SFSafariViewController.Configuration) -> Bool {
        guard let safeUrlHost = url.host else {return false}
        guard IDQConstants.allowedDomainStrings.contains(safeUrlHost) else {
            print("The website is not allowed")
            return false
        }
        return true
    }
}
