//
//  IDQAnswerView.swift
//  iOSDevQuiz
//
//  Created by Daniel Karath on 3/14/23.
//

import UIKit

class IDQAnswerView: UIView {

    private let resultImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.cornerRadius = 4
        imageView.clipsToBounds = true
        imageView.tintColor = IDQConstants.correctColor
        imageView.image = UIImage(systemName: "circle.fill")?.withTintColor(IDQConstants.correctColor, renderingMode: .alwaysTemplate)
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let resultLabel: UILabel = {
        let label = UILabel()
        label.text = "Awesome!"
        label.numberOfLines = 1
        label.textAlignment = .left
        label.font = IDQConstants.setFont(fontSize: 20, isBold: true)
        label.textColor = IDQConstants.correctColor
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
        let width: CGFloat = 60
        let height: CGFloat = width * 1.33
        button.frame.size = CGSize(width: width * 2, height: height * 2) //.size = CGSize(width: width, height: height)
        button.layer.cornerRadius = 8
        button.setTitleColor(IDQConstants.contentBackgroundColor, for: .normal)
        button.backgroundColor = IDQConstants.correctColor
        button.titleLabel?.font = IDQConstants.setFont(fontSize: 20, isBold: true)
        button.setTitle("CONTINUE", for: .normal)
        button.setTitle("CONTINUE", for: .highlighted)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.isEnabled = false
        button.isUserInteractionEnabled = false
        return button
    }()
    
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
    
}
