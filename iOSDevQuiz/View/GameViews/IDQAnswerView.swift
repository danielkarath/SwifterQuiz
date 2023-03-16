//
//  IDQAnswerView.swift
//  iOSDevQuiz
//
//  Created by Daniel Karath on 3/14/23.
//

import UIKit
import SafariServices

protocol IDQIDQAnswerViewDelegate: AnyObject {
    func didTapContinue(_ answerView: IDQAnswerView)
}

class IDQAnswerView: UIView {
    
    public weak var delegate: IDQIDQAnswerViewDelegate?

    private var question: IDQQuestion?
    
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
        backgroundColor = IDQConstants.contentBackgroundColor
        self.layer.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 240)
        backgroundColor = IDQConstants.contentBackgroundColor
        layer.cornerRadius = 16
        
        referenceImageView.tintColor = IDQConstants.correctColor
        referenceImageView.frame = CGRect(x: referenceButton.layer.frame.minX, y: referenceButton.layer.frame.minY, width: 24, height: 24)
        referenceImageView.contentMode = .scaleAspectFit
        referenceButton.addSubview(referenceImageView)
        
        bookmarkUnfilledImageView.tintColor = IDQConstants.correctColor
        bookmarkUnfilledImageView.frame = CGRect(x: bookmarkButton.layer.frame.minX, y: bookmarkButton.layer.frame.minY, width: 24, height: 24)
        bookmarkFilledImageView.frame = CGRect(x: bookmarkButton.layer.frame.minX, y: bookmarkButton.layer.frame.minY, width: 24, height: 24)
        bookmarkUnfilledImageView.contentMode = .scaleAspectFit
        bookmarkFilledImageView.contentMode = .scaleAspectFit
        bookmarkButton.addSubview(bookmarkUnfilledImageView)
        
        referenceButton.addTarget(self, action: #selector(referenceButtonTapped(_:)), for: .touchUpInside)
        bookmarkButton.addTarget(self, action: #selector(bookmarkButtonTapped(_:)), for: .touchUpInside)
        continueButton.addTarget(self, action: #selector(continueButtonTapped(_:)), for: .touchUpInside)
    }
    
    private func setupConstraints() {
        addSubviews(resultLabel, resultImageView, continueButton, detailLabel, referenceButton, bookmarkButton)
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
    
    @objc
    private func continueButtonTapped(_ sender: UIButton) {
        print("next game")
        sender.isUserInteractionEnabled = false
        continueTimer = Timer.scheduledTimer(withTimeInterval: 3.0, repeats: false) {_ in
            sender.isUserInteractionEnabled = true
            self.continueTimer.invalidate()
        }
        delegate?.didTapContinue(self)
    }
    
    @objc
    private func referenceButtonTapped(_ sender: UIButton) {
        guard let question = self.question, self.question != nil else {return}
        let safariViewController = SFSafariViewController(url: URL(string: question.reference!)!)
        safariViewController.modalPresentationStyle = .popover
        if let viewController = self.getViewController() {
            viewController.present(safariViewController, animated: true, completion: nil)
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
    //MARK: - Public
    
    public func idqAnswerView(_ view: IDQAnswerView, question: IDQQuestion, answer: IDQAnswer?) {
        guard let answer = answer, question != nil else {
            return
        }
        resetView()
        self.question = question
        let labels: [UILabel] = [resultLabel, detailLabel]
        detailLabel.text = question.explanation
        if answer.isCorrect {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                self.resultImageView.tintColor = IDQConstants.correctColor
                self.referenceImageView.tintColor = IDQConstants.correctColor
                self.bookmarkButton.tintColor = IDQConstants.correctColor
                self.resultImageView.image = UIImage(systemName: "checkmark.circle.fill")?.withTintColor(IDQConstants.correctColor, renderingMode: .alwaysTemplate)
                let haapyArray = ["Awesome!", "Excellent!", "Correct", "Hoooray!", "Well done!", "Great job!", "Bravo!", "Very cool!"]
                let randomIndex = Int.random(in: 0..<haapyArray.count)
                self.resultLabel.text = haapyArray[randomIndex]
                
                for label in labels {
                    label.textColor = IDQConstants.correctColor
                }
                self.continueButton.backgroundColor = IDQConstants.correctColor
            }
        } else{
            DispatchQueue.main.async {
                self.resultImageView.tintColor = IDQConstants.errorColor
                self.referenceImageView.tintColor = IDQConstants.errorColor
                self.bookmarkButton.tintColor = IDQConstants.errorColor
                self.resultImageView.image = UIImage(systemName: "x.circle.fill")?.withTintColor(IDQConstants.correctColor, renderingMode: .alwaysTemplate)
                let haapyArray = ["Incorrect", "Incorrect", "Incorrect", "Wrong answer", "Oopsie"]
                let randomIndex = Int.random(in: 0..<haapyArray.count)
                self.resultLabel.text = haapyArray[randomIndex]
                for label in labels {
                    label.textColor = IDQConstants.errorColor
                }
                self.continueButton.backgroundColor = IDQConstants.errorColor
            }
        }
    }
    
}
