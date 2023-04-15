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
}

class IDQAnswerResultView: UIView {
    
    public weak var delegate: IDQAnswerResultViewDelegate?

    private var question: IDQQuestion?
    
    private var answerType: IDQAnswerType?
    
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
        label.text = " "
        label.numberOfLines = 1
        label.textAlignment = .left
        label.font = IDQConstants.setFont(fontSize: 20, isBold: true)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let detailLabel: UILabel = {
        let label = UILabel()
        label.text = "This is some explanation to the result so you can better understand it or whatever."
        label.numberOfLines = 0
        label.textAlignment = .left
        label.contentMode = .top
        label.font = IDQConstants.setFont(fontSize: 14, isBold: false)
        label.textColor = IDQConstants.correctColor
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let referenceButton: UIButton = {
        let button = UIButton()
        button.frame.size = CGSize(width: 24, height: 24)
        button.clipsToBounds = true
        button.setTitle("", for: .normal)
        button.isUserInteractionEnabled = true
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let bookmarkButton: UIButton = {
        let button = UIButton()
        button.frame.size = CGSize(width: 24, height: 24)
        button.clipsToBounds = true
        button.setTitle("", for: .normal)
        button.isUserInteractionEnabled = true
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let discardQuestionButton: UIButton = {
        let button = UIButton()
        button.frame.size = CGSize(width: 24, height: 24)
        button.clipsToBounds = true
        button.setTitle("", for: .normal)
        button.isUserInteractionEnabled = true
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let continueButton: UIButton = {
        let button = UIButton()
        button.frame.size = CGSize(width: UIScreen.main.bounds.width-32, height: 40) //.size = CGSize(width: width, height: height)
        button.layer.cornerRadius = 8
        button.setTitleColor(IDQConstants.contentBackgroundColor, for: .normal)
        button.backgroundColor = IDQConstants.secondaryFontColor
        button.titleLabel?.font = IDQConstants.setFont(fontSize: 20, isBold: true)
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
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("Unsupported")
    }
    
    
    //MARK: - Private
    
    private func setupView() {
        translatesAutoresizingMaskIntoConstraints = false
        self.layer.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 240)
        backgroundColor = IDQConstants.contentBackgroundColor
        layer.cornerRadius = 16
        
        referenceImageView.tintColor = IDQConstants.correctColor
        referenceImageView.frame = CGRect(x: referenceButton.layer.frame.minX, y: referenceButton.layer.frame.minY, width: 24, height: 24)
        referenceImageView.contentMode = .scaleAspectFit
        referenceButton.addSubview(referenceImageView)
        
        bookmarkUnfilledImageView.frame = CGRect(x: bookmarkButton.layer.frame.minX, y: bookmarkButton.layer.frame.minY, width: 24, height: 24)
        bookmarkFilledImageView.frame = CGRect(x: bookmarkButton.layer.frame.minX, y: bookmarkButton.layer.frame.minY, width: 24, height: 24)
        bookmarkUnfilledImageView.contentMode = .scaleAspectFit
        bookmarkFilledImageView.contentMode = .scaleAspectFit
        bookmarkButton.addSubview(bookmarkUnfilledImageView)
        
        noSignImageView.tintColor = IDQConstants.correctColor
        noSignImageView.frame = CGRect(x: discardQuestionButton.layer.frame.minX, y: discardQuestionButton.layer.frame.minY, width: 24, height: 24)
        noSignImageView.contentMode = .scaleAspectFit
        discardQuestionButton.addSubview(noSignImageView)
        
        discardQuestionButton.addTarget(self, action: #selector(discardQuestionButtonButtonTapped(_:)), for: .touchUpInside)
        referenceButton.addTarget(self, action: #selector(referenceButtonTapped(_:)), for: .touchUpInside)
        bookmarkButton.addTarget(self, action: #selector(bookmarkButtonTapped(_:)), for: .touchUpInside)
        continueButton.addTarget(self, action: #selector(continueButtonTapped(_:)), for: .touchUpInside)
    }
    
    private func setupConstraints() {
        addSubviews(resultLabel, resultImageView, continueButton, detailLabel, referenceButton, bookmarkButton, discardQuestionButton)
        NSLayoutConstraint.activate([
            resultImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            resultImageView.widthAnchor.constraint(equalToConstant: 32),
            resultImageView.heightAnchor.constraint(equalToConstant: 32),
            resultImageView.topAnchor.constraint(equalTo: topAnchor, constant: 16),
            
            resultLabel.leadingAnchor.constraint(equalTo: resultImageView.trailingAnchor, constant: 12),
            resultLabel.centerYAnchor.constraint(equalTo: resultImageView.centerYAnchor, constant: 2),
            resultLabel.widthAnchor.constraint(equalToConstant: 160),
            resultLabel.heightAnchor.constraint(equalToConstant: 40),
            
            referenceButton.centerYAnchor.constraint(equalTo: resultImageView.centerYAnchor, constant: 0),
            referenceButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -32),
            referenceButton.heightAnchor.constraint(equalToConstant: 24),
            referenceButton.widthAnchor.constraint(equalToConstant: 24),
            
            bookmarkButton.centerYAnchor.constraint(equalTo: resultImageView.centerYAnchor, constant: 0),
            bookmarkButton.trailingAnchor.constraint(equalTo: referenceButton.leadingAnchor, constant: -16),
            bookmarkButton.heightAnchor.constraint(equalToConstant: 24),
            bookmarkButton.widthAnchor.constraint(equalToConstant: 24),
            
            discardQuestionButton.centerYAnchor.constraint(equalTo: resultImageView.centerYAnchor, constant: 0),
            discardQuestionButton.trailingAnchor.constraint(equalTo: bookmarkButton.leadingAnchor, constant: -16),
            discardQuestionButton.heightAnchor.constraint(equalToConstant: 24),
            discardQuestionButton.widthAnchor.constraint(equalToConstant: 24),
            
            detailLabel.topAnchor.constraint(equalTo: resultImageView.bottomAnchor, constant: 4),
            detailLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            detailLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            detailLabel.bottomAnchor.constraint(equalTo: continueButton.topAnchor, constant: -8),
            
            continueButton.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -92),
            continueButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            continueButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            continueButton.heightAnchor.constraint(equalToConstant: 50)
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
        
        self.backgroundColor = backgroundColor
        self.resultImageView.tintColor = tintColor
        self.referenceImageView.tintColor = tintColor
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
        let safariViewController = SFSafariViewController(url: URL(string: question.reference!)!)
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
        } else {
            DispatchQueue.main.async {
                self.bookmarkFilledImageView.removeFromSuperview()
                self.bookmarkButton.addSubview(self.bookmarkUnfilledImageView)
            }
        }
        isBookmarked.toggle()
    }
    
    @objc
    private func discardQuestionButtonButtonTapped(_ sender: UIButton) {
        guard let question = self.question, self.question != nil else {return}
        
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
