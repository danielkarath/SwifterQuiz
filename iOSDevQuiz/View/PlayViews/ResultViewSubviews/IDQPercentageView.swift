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
        var fontSize: CGFloat = UIScreen.screenHeight * 0.02461899
        if UIScreen.screenHeight  > 1080 {
            fontSize = UIScreen.screenHeight * 0.03769988
        }
        label.text = " "
        label.numberOfLines = 1
        label.textAlignment = .center
        label.textColor = IDQConstants.highlightedDarkOrange
        label.font = IDQConstants.setFont(fontSize: fontSize, isBold: true)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.layer.zPosition = 4
        return label
    }()
    
    private let quizPercentageDescriptionLabel: UILabel = {
        let label = UILabel()
        var fontSize: CGFloat = UIScreen.screenHeight * 0.01524033
        label.text = "Accuracy"
        label.numberOfLines = 1
        label.textAlignment = .center
        label.textColor = IDQConstants.contentBackgroundColor
        label.font = IDQConstants.setFont(fontSize: fontSize, isBold: true)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.layer.zPosition = 3
        return label
    }()
    
    private let descriptionView: UIView = {
        let view = UIView()
        var statsViewHeight: CGFloat = UIScreen.screenHeight * 0.05627198
        var statsViewWidth: CGFloat = UIScreen.screenHeight * 0.10550996
        
        if UIScreen.screenHeight  > 1080 {
            statsViewWidth = UIScreen.screenWidth * 0.285131
        }
        view.translatesAutoresizingMaskIntoConstraints = false
        let color1: UIColor = IDQConstants.highlightedLightOrange
        let color2: UIColor = IDQConstants.highlightedDarkOrange
        view.frame.size = CGSize(width: statsViewWidth, height: statsViewHeight)
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
        layer.cornerRadius = UIScreen.screenHeight * 0.00468933
        clipsToBounds = true
    }
    
    private func setupConstraints() {
        let statsViewHeight: CGFloat = UIScreen.screenHeight * 0.05627198
        let descriptionViewTopAnchor: CGFloat = -(UIScreen.screenHeight * 0.03745252)
        let scoreLabelSize: CGFloat = UIScreen.screenHeight * 0.15
        let scoreLabelCenterY: CGFloat = UIScreen.screenHeight * 0.014068
        let descriptionLabelHeight: CGFloat = UIScreen.screenHeight * 0.01875733
        let descriptionLabelWidth: CGFloat = UIScreen.screenHeight * 0.07033998
        let descriptionLabelTopAnchor: CGFloat = UIScreen.screenHeight * 0.00347233
        var backgroundImageViewSize: CGFloat = UIScreen.screenHeight * 0.04220399
        var backgroundImageOffset: CGFloat = UIScreen.screenHeight * 0.007034
        
        if UIScreen.screenHeight  > 1080 {
            backgroundImageViewSize = UIScreen.screenWidth * 0.12
            backgroundImageOffset = UIScreen.screenWidth * 0.023
        }
        
        addSubviews(descriptionView, quizPercentageLabel, backgroundImageView)
        descriptionView.addSubview(quizPercentageDescriptionLabel)
        NSLayoutConstraint.activate([
            quizPercentageLabel.centerYAnchor.constraint(equalTo: centerYAnchor, constant: scoreLabelCenterY),
            quizPercentageLabel.centerXAnchor.constraint(equalTo: centerXAnchor, constant: 0),
            quizPercentageLabel.widthAnchor.constraint(equalToConstant: scoreLabelSize),
            quizPercentageLabel.heightAnchor.constraint(equalToConstant: scoreLabelSize),
            
            descriptionView.topAnchor.constraint(equalTo: topAnchor, constant: descriptionViewTopAnchor),
            descriptionView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 0),
            descriptionView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 0),
            descriptionView.heightAnchor.constraint(equalToConstant: statsViewHeight),
            
            quizPercentageDescriptionLabel.centerXAnchor.constraint(equalTo: descriptionView.centerXAnchor, constant: 0),
            quizPercentageDescriptionLabel.topAnchor.constraint(equalTo: topAnchor, constant: descriptionLabelTopAnchor),
            quizPercentageDescriptionLabel.widthAnchor.constraint(equalToConstant: descriptionLabelWidth),
            quizPercentageDescriptionLabel.heightAnchor.constraint(equalToConstant: descriptionLabelHeight),
            
            backgroundImageView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: backgroundImageOffset),
            backgroundImageView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: backgroundImageOffset),
            backgroundImageView.widthAnchor.constraint(equalToConstant: backgroundImageViewSize),
            backgroundImageView.heightAnchor.constraint(equalToConstant: backgroundImageViewSize),
        ])
    }
    
    
}
