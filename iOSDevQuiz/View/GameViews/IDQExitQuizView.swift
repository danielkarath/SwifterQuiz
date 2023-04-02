//
//  IDQExitQuizView.swift
//  iOSDevQuiz
//
//  Created by Daniel Karath on 4/2/23.
//
import UIKit

protocol IDQExitQuizViewDelegate: AnyObject {
    func didTapExitButton(_ idqExitQuizView: IDQExitQuizView)
    func didTapRejoinButton(_ idqExitQuizView: IDQExitQuizView)
}

class IDQExitQuizView: UIView {
    
    public weak var delegate: IDQExitQuizViewDelegate?

    private var question: IDQQuestion?
    
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
        let label = UILabel()
        label.text = "Do you want to quit?"
        label.numberOfLines = 1
        label.textAlignment = .left
        label.font = IDQConstants.setFont(fontSize: 20, isBold: true)
        label.textColor = IDQConstants.basicFontColor
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let detailLabel: UILabel = {
        let label = UILabel()
        label.text = "If you quit this quiz, you'll lose your progress you've made so far."
        label.numberOfLines = 0
        label.textAlignment = .left
        label.contentMode = .top
        label.font = IDQConstants.setFont(fontSize: 14, isBold: false)
        label.textColor = IDQConstants.basicFontColor
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    
    private let exitButton: UIButton = {
        let button = UIButton()
        button.frame.size = CGSize(width: UIScreen.main.bounds.width-32, height: 40) //.size = CGSize(width: width, height: height)
        button.layer.cornerRadius = 8
        button.setTitleColor(IDQConstants.contentBackgroundColor, for: .normal)
        button.titleLabel?.font = IDQConstants.setFont(fontSize: 20, isBold: true)
        button.backgroundColor = IDQConstants.errorColor
        button.setTitle("END QUIZ", for: .normal)
        button.setTitle("END QUIZ", for: .highlighted)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.isUserInteractionEnabled = true
        return button
    }()
    
    private let rejoinButton: UIButton = {
        let button = UIButton()
        button.frame.size = CGSize(width: UIScreen.main.bounds.width-32, height: 40) //.size = CGSize(width: width, height: height)
        button.layer.cornerRadius = 8
        button.setTitleColor(IDQConstants.basicFontColor, for: .normal)
        button.titleLabel?.font = IDQConstants.setFont(fontSize: 20, isBold: true)
        button.backgroundColor = IDQConstants.contentBackgroundColor
        button.setTitle("CONTINUE QUIZ", for: .normal)
        button.setTitle("CONTINUE QUIZ", for: .highlighted)
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
        self.layer.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 240)
        backgroundColor = IDQConstants.contentBackgroundColor
        layer.cornerRadius = 16
        exitButton.addTarget(self, action: #selector(exitButtonTapped(_:)), for: .touchUpInside)
        rejoinButton.addTarget(self, action: #selector(rejoinButtonTapped(_:)), for: .touchUpInside)
    }
    
    private func setupConstraints() {
        addSubviews(exitTitleLabel, exitImageView, exitButton, detailLabel, rejoinButton)
        NSLayoutConstraint.activate([
            exitImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            exitImageView.widthAnchor.constraint(equalToConstant: 32),
            exitImageView.heightAnchor.constraint(equalToConstant: 32),
            exitImageView.topAnchor.constraint(equalTo: topAnchor, constant: 16),
            
            exitTitleLabel.leadingAnchor.constraint(equalTo: exitImageView.trailingAnchor, constant: 12),
            exitTitleLabel.centerYAnchor.constraint(equalTo: exitImageView.centerYAnchor, constant: 2),
            exitTitleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -24),
            exitTitleLabel.heightAnchor.constraint(equalToConstant: 40),
            
            detailLabel.topAnchor.constraint(equalTo: exitImageView.bottomAnchor, constant: 4),
            detailLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            detailLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            detailLabel.heightAnchor.constraint(equalToConstant: 60),
            
            rejoinButton.bottomAnchor.constraint(equalTo: exitButton.topAnchor, constant: -16),
            rejoinButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            rejoinButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            rejoinButton.heightAnchor.constraint(equalToConstant: 50),
            
            exitButton.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -92),
            exitButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            exitButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            exitButton.heightAnchor.constraint(equalToConstant: 50),
        ])
    }
    
    @objc
    private func exitButtonTapped(_ sender: UIButton) {
        delegate?.didTapExitButton(self)
    }
    
    @objc
    private func rejoinButtonTapped(_ sender: UIButton) {
        delegate?.didTapRejoinButton(self)
    }
}

