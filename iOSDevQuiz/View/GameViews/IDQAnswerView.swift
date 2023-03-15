//
//  IDQAnswerView.swift
//  iOSDevQuiz
//
//  Created by Daniel Karath on 3/14/23.
//

import UIKit

protocol IDQIDQAnswerViewDelegate: AnyObject {
    func didTapContinue(_ answerView: IDQAnswerView)
}

class IDQAnswerView: UIView {
    
    public weak var delegate: IDQIDQAnswerViewDelegate?

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
        label.font = IDQConstants.setFont(fontSize: 14, isBold: false)
        label.textColor = IDQConstants.correctColor
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
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
        self.layer.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 200)
        backgroundColor = IDQConstants.contentBackgroundColor
        layer.cornerRadius = 16
        continueButton.addTarget(self, action: #selector(continueButtonTapped(_:)), for: .touchUpInside)
    }
    
    private func setupConstraints() {
        addSubviews(resultLabel, resultImageView, continueButton, detailLabel)
        NSLayoutConstraint.activate([
            resultImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            resultImageView.widthAnchor.constraint(equalToConstant: 32),
            resultImageView.heightAnchor.constraint(equalToConstant: 32),
            resultImageView.topAnchor.constraint(equalTo: topAnchor, constant: 16),
            
            resultLabel.leadingAnchor.constraint(equalTo: resultImageView.trailingAnchor, constant: 12),
            resultLabel.centerYAnchor.constraint(equalTo: resultImageView.centerYAnchor, constant: 2),
            resultLabel.widthAnchor.constraint(equalToConstant: 120),
            resultLabel.heightAnchor.constraint(equalToConstant: 40),
            
            detailLabel.topAnchor.constraint(equalTo: resultImageView.bottomAnchor, constant: 16),
            detailLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            detailLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            detailLabel.bottomAnchor.constraint(equalTo: continueButton.topAnchor, constant: -16),
            
            continueButton.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -32),
            continueButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            continueButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            continueButton.heightAnchor.constraint(equalToConstant: 40)
        ])
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
    
    //MARK: - Public
    
    public func idqAnswerView(_ view: IDQAnswerView, answer: IDQAnswer?) {
        print("JAJJJJ")
        guard let answer = answer else {
            return
        }
        let labels: [UILabel] = [resultLabel, detailLabel]
        if answer.isCorrect {
            DispatchQueue.main.async {
                self.resultImageView.tintColor = IDQConstants.correctColor
                self.resultImageView.image = UIImage(systemName: "checkmark.circle.fill")?.withTintColor(IDQConstants.correctColor, renderingMode: .alwaysTemplate)
                self.resultLabel.text = "Awesome!"
                for label in labels {
                    label.textColor = IDQConstants.correctColor
                }
                self.continueButton.backgroundColor = IDQConstants.correctColor
            }
        } else{
            DispatchQueue.main.async {
                self.resultImageView.tintColor = IDQConstants.errorColor
                self.resultImageView.image = UIImage(systemName: "x.circle.fill")?.withTintColor(IDQConstants.correctColor, renderingMode: .alwaysTemplate)
                self.resultLabel.text = "Incorrect"
                for label in labels {
                    label.textColor = IDQConstants.errorColor
                }
                self.continueButton.backgroundColor = IDQConstants.errorColor
            }
        }
    }
    
}