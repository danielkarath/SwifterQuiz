//
//  IDQScoreView.swift
//  iOSDevQuiz
//
//  Created by Daniel Karath on 4/7/23.
//

import UIKit

final class IDQPercentageView: UIView {
    
    private let backgroundImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(systemName: "percent")
        imageView.image?.withTintColor(IDQConstants.backgroundColor, renderingMode: .alwaysTemplate)
        imageView.tintColor = IDQConstants.backgroundColor
        imageView.alpha = 1.0
        imageView.transform = CGAffineTransform(scaleX: -1, y: 1)
        imageView.contentMode = .scaleAspectFit
        imageView.isAccessibilityElement = false
        imageView.layer.zPosition = 1
        return imageView
    }()

    public let quizPercentageLabel: UILabel = {
        let label = UILabel()
        label.text = " "
        label.numberOfLines = 1
        label.textAlignment = .center
        label.textColor = IDQConstants.highlightedDarkOrange
        label.font = IDQConstants.setFont(fontSize: 21, isBold: true)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.layer.zPosition = 4
        return label
    }()
    
    private let quizPercentageDescriptionLabel: UILabel = {
        let label = UILabel()
        label.text = "Performance"
        label.numberOfLines = 1
        label.textAlignment = .center
        label.textColor = IDQConstants.contentBackgroundColor
        label.font = IDQConstants.setFont(fontSize: 13, isBold: true)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.layer.zPosition = 3
        return label
    }()
    
    private let descriptionView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        //view.backgroundColor = IDQConstants.highlightedDarkOrange
        let color1: UIColor = IDQConstants.highlightedLightOrange
        let color2: UIColor = IDQConstants.highlightedDarkOrange
        view.frame.size = CGSize(width: 90, height: 54)
        view.gradient(color1.cgColor, color2.cgColor, direction: .bottomLeftToTopRight)
        view.clipsToBounds = true
        view.layer.zPosition = 2
        return view
    }()
    
    //MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("IDQPlayView is unsupported!")
    }
    
    //MARK: - Private
    private func setupView() {
        translatesAutoresizingMaskIntoConstraints = false
        //frame.size = CGSize(width: 70, height: 60)
        backgroundColor = IDQConstants.contentBackgroundColor
        layer.cornerRadius = 4
        clipsToBounds = true
    }
    
    private func setupConstraints() {
        
        addSubviews(descriptionView, quizPercentageLabel, backgroundImageView)
        descriptionView.addSubview(quizPercentageDescriptionLabel)
        NSLayoutConstraint.activate([
            quizPercentageLabel.centerYAnchor.constraint(equalTo: centerYAnchor, constant: 12),
            quizPercentageLabel.centerXAnchor.constraint(equalTo: centerXAnchor, constant: 0),
            quizPercentageLabel.widthAnchor.constraint(equalToConstant: 80),
            quizPercentageLabel.heightAnchor.constraint(equalToConstant: 80),
            
            descriptionView.topAnchor.constraint(equalTo: topAnchor, constant: -40),
            descriptionView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 0),
            descriptionView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 0),
            descriptionView.heightAnchor.constraint(equalToConstant: 54),
            
            quizPercentageDescriptionLabel.centerXAnchor.constraint(equalTo: descriptionView.centerXAnchor, constant: 0),
            quizPercentageDescriptionLabel.topAnchor.constraint(equalTo: topAnchor, constant: 1),
            quizPercentageDescriptionLabel.widthAnchor.constraint(equalToConstant: 80),
            quizPercentageDescriptionLabel.heightAnchor.constraint(equalToConstant: 16),
            
            backgroundImageView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 6),
            backgroundImageView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 6),
            backgroundImageView.widthAnchor.constraint(equalToConstant: 36),
            backgroundImageView.heightAnchor.constraint(equalToConstant: 36),
        ])
    }
    
    
}