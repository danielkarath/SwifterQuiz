//
//  IDQScoreView.swift
//  iOSDevQuiz
//
//  Created by Daniel Karath on 4/7/23.
//

import UIKit

final class IDQScoreView: UIView {
    
    private let backgroundImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(systemName: "target")
        imageView.image?.withTintColor(IDQConstants.backgroundColor, renderingMode: .alwaysTemplate)
        imageView.tintColor = IDQConstants.backgroundColor
        imageView.alpha = 1.0
        imageView.transform = CGAffineTransform(scaleX: -1, y: 1)
        imageView.contentMode = .scaleAspectFit
        imageView.isAccessibilityElement = false
        imageView.layer.zPosition = 1
        return imageView
    }()

    public let quizScoreLabel: UILabel = {
        let label = UILabel()
        var fontSize: CGFloat = UIScreen.main.bounds.height * 0.02461899
        label.text = " "
        label.numberOfLines = 1
        label.textAlignment = .center
        label.textColor = IDQConstants.highlightedDarkOrange
        label.font = IDQConstants.setFont(fontSize: fontSize, isBold: true)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.layer.zPosition = 4
        return label
    }()
    
    private let quizScoreDescriptionLabel: UILabel = {
        let label = UILabel()
        var fontSize: CGFloat = UIScreen.main.bounds.height * 0.01524033
        label.text = "Score"
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
        var statsViewHeight: CGFloat = UIScreen.main.bounds.height * 0.05627198
        var statsViewWidth: CGFloat = UIScreen.main.bounds.height * 0.10550996
        
        if UIScreen.main.bounds.height  > 1080 {
            statsViewWidth = UIScreen.main.bounds.height * 0.14067995
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
        layer.cornerRadius = 4
        clipsToBounds = true
    }
    
    private func setupConstraints() {
        var statsViewHeight: CGFloat = UIScreen.main.bounds.height * 0.05627198
        var descriptionViewTopAnchor: CGFloat = -(UIScreen.main.bounds.height * 0.03745252)
        var scoreLabelSize: CGFloat = UIScreen.main.bounds.height * 0.09378664
        var scoreLabelCenterY: CGFloat = UIScreen.main.bounds.height * 0.014068
        var descriptionLabelHeight: CGFloat = UIScreen.main.bounds.height * 0.01875733
        var descriptionLabelWidth: CGFloat = UIScreen.main.bounds.height * 0.07033998
        var descriptionLabelTopAnchor: CGFloat = UIScreen.main.bounds.height * 0.00347233
        var backgroundImageViewSize: CGFloat = UIScreen.main.bounds.height * 0.04220399
        var backgroundImageOffset: CGFloat = UIScreen.main.bounds.height * 0.007034
        
        if UIScreen.main.bounds.height  > 1080 {
            backgroundImageViewSize = backgroundImageViewSize * 1.40
            backgroundImageOffset = backgroundImageOffset * 1.40
        }
        
        addSubviews(descriptionView, quizScoreLabel, backgroundImageView)
        descriptionView.addSubview(quizScoreDescriptionLabel)
        NSLayoutConstraint.activate([
            quizScoreLabel.centerYAnchor.constraint(equalTo: centerYAnchor, constant: scoreLabelCenterY),
            quizScoreLabel.centerXAnchor.constraint(equalTo: centerXAnchor, constant: 0),
            quizScoreLabel.widthAnchor.constraint(equalToConstant: scoreLabelSize),
            quizScoreLabel.heightAnchor.constraint(equalToConstant: scoreLabelSize),
            
            descriptionView.topAnchor.constraint(equalTo: topAnchor, constant: descriptionViewTopAnchor),
            descriptionView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 0),
            descriptionView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 0),
            descriptionView.heightAnchor.constraint(equalToConstant: statsViewHeight),
            
            quizScoreDescriptionLabel.centerXAnchor.constraint(equalTo: descriptionView.centerXAnchor, constant: 0),
            quizScoreDescriptionLabel.topAnchor.constraint(equalTo: topAnchor, constant: descriptionLabelTopAnchor),
            quizScoreDescriptionLabel.widthAnchor.constraint(equalToConstant: descriptionLabelWidth),
            quizScoreDescriptionLabel.heightAnchor.constraint(equalToConstant: descriptionLabelHeight),
            
            backgroundImageView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: backgroundImageOffset),
            backgroundImageView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: backgroundImageOffset),
            backgroundImageView.widthAnchor.constraint(equalToConstant: backgroundImageViewSize),
            backgroundImageView.heightAnchor.constraint(equalToConstant: backgroundImageViewSize),
        ])
    }
    
    
}
