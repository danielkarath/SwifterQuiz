//
//  IDQExitQuizView.swift
//  iOSDevQuiz
//
//  Created by Daniel Karath on 4/2/23.
//
import UIKit

protocol IDQExitQuizViewDelegate: AnyObject {
    func didConfirmExit(_ idqExitQuizView: IDQExitQuizView)
    func didTapRejoinButton(_ idqExitQuizView: IDQExitQuizView)
}

class IDQExitQuizView: UIView {
    
    public weak var delegate: IDQExitQuizViewDelegate?

    private var question: IDQQuestion?
    
    private var imageSize: CGFloat = {
        var returnValue: CGFloat = 0
        if UIScreen.screenHeight < 980 {
            returnValue = 32
        } else if UIScreen.screenHeight < 1100 {
            returnValue = 40
        } else {
            returnValue = 48
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
    
    private let exitImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.cornerRadius = 4
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.tintColor = IDQConstants.basicFontColor
        imageView.image = UIImage(systemName: "rectangle.portrait.and.arrow.forward")?.withTintColor(IDQConstants.basicFontColor, renderingMode: .alwaysTemplate)
        return imageView
    }()
    
    private let exitTitleLabel: UILabel = {
        var fontSize: CGFloat = 20
        if UIScreen.screenHeight < 980 {
            fontSize = 20
        } else if UIScreen.screenHeight < 1100 {
            fontSize = 24
        } else {
            fontSize = 28
        }
        let label = UILabel()
        label.text = "Do you want to quit?"
        label.numberOfLines = 1
        label.textAlignment = .left
        label.font = IDQConstants.setFont(fontSize: fontSize, isBold: true)
        label.textColor = IDQConstants.basicFontColor
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let detailLabel: UILabel = {
        var fontSize: CGFloat = 14
        if UIScreen.screenHeight < 980 {
            fontSize = 14
        } else if UIScreen.screenHeight < 1100 {
            fontSize = 20
        } else {
            fontSize = 24
        }
        let label = UILabel()
        label.text = "If you quit this quiz, you'll lose your progress you've made so far."
        label.numberOfLines = 0
        label.textAlignment = .left
        label.contentMode = .top
        label.font = IDQConstants.setFont(fontSize: fontSize, isBold: false)
        label.textColor = IDQConstants.basicFontColor
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    
    private let exitButton: UIButton = {
        let button = UIButton()
        var fontSize: CGFloat = 20
        if UIScreen.screenHeight < 980 {
            fontSize = 20
        } else if UIScreen.screenHeight < 1100 {
            fontSize = 24
        } else {
            fontSize = 28
        }
        button.frame.size = CGSize(width: UIScreen.screenWidth-32, height: 50)
        button.layer.cornerRadius = 8
        button.setTitleColor(IDQConstants.contentBackgroundColor, for: .normal)
        button.titleLabel?.font = IDQConstants.setFont(fontSize: fontSize, isBold: true)
        button.backgroundColor = IDQConstants.errorColor
        button.setTitle("END QUIZ", for: .normal)
        button.setTitle("END QUIZ", for: .highlighted)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.isUserInteractionEnabled = true
        return button
    }()
    
    private let rejoinButton: UIButton = {
        var fontSize: CGFloat = 20
        if UIScreen.screenHeight < 980 {
            fontSize = 20
        } else if UIScreen.screenHeight < 1100 {
            fontSize = 24
        } else {
            fontSize = 28
        }
        let button = UIButton()
        button.frame.size = CGSize(width: UIScreen.screenWidth-32, height: 50)
        button.layer.cornerRadius = 8
        button.setTitleColor(IDQConstants.basicFontColor, for: .normal)
        button.titleLabel?.font = IDQConstants.setFont(fontSize: fontSize, isBold: true)
        button.backgroundColor = IDQConstants.contentBackgroundColor
        button.setTitle("RETURN", for: .normal)
        button.setTitle("RETURN", for: .highlighted)
        button.layer.borderWidth = 2.0
        button.layer.borderColor = IDQConstants.basicFontColor.cgColor
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
        self.layer.frame = CGRect(x: 0, y: 0, width: UIScreen.screenWidth, height: 240)
        backgroundColor = IDQConstants.contentBackgroundColor
        layer.cornerRadius = 16
        exitButton.addTarget(self, action: #selector(exitButtonTapped(_:)), for: .touchUpInside)
        rejoinButton.addTarget(self, action: #selector(rejoinButtonTapped(_:)), for: .touchUpInside)
    }
    
    private func setupConstraints() {
        var resultImageViewoffset: CGFloat = 16
        if UIScreen.screenHeight < 980 {
            resultImageViewoffset = 16
        } else if UIScreen.screenHeight < 1100 {
            resultImageViewoffset = 20
        } else {
            resultImageViewoffset = 24
        }
        addSubviews(exitTitleLabel, exitImageView, exitButton, detailLabel, rejoinButton)
        NSLayoutConstraint.activate([
            exitImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: resultImageViewoffset),
            exitImageView.widthAnchor.constraint(equalToConstant: imageSize),
            exitImageView.heightAnchor.constraint(equalToConstant: imageSize),
            exitImageView.topAnchor.constraint(equalTo: topAnchor, constant: resultImageViewoffset),
            
            exitTitleLabel.leadingAnchor.constraint(equalTo: exitImageView.trailingAnchor, constant: 12),
            exitTitleLabel.centerYAnchor.constraint(equalTo: exitImageView.centerYAnchor, constant: 2),
            exitTitleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -24),
            exitTitleLabel.heightAnchor.constraint(equalToConstant: 40),
            
            detailLabel.topAnchor.constraint(equalTo: exitImageView.bottomAnchor, constant: 4),
            detailLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: resultImageViewoffset),
            detailLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -resultImageViewoffset),
            detailLabel.heightAnchor.constraint(equalToConstant: 60),
            
            rejoinButton.bottomAnchor.constraint(equalTo: exitButton.topAnchor, constant: -16),
            rejoinButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: resultImageViewoffset),
            rejoinButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -resultImageViewoffset),
            rejoinButton.heightAnchor.constraint(equalToConstant: actionButtonHeight),
            
            exitButton.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -92),
            exitButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: resultImageViewoffset),
            exitButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -resultImageViewoffset),
            exitButton.heightAnchor.constraint(equalToConstant: actionButtonHeight),
        ])
    }
    
    @objc
    private func exitButtonTapped(_ sender: UIButton) {
        delegate?.didConfirmExit(self)
    }
    
    @objc
    private func rejoinButtonTapped(_ sender: UIButton) {
        delegate?.didTapRejoinButton(self)
    }
}

