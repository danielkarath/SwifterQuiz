//
//  StartButtonView.swift
//  iOSDevQuiz
//
//  Created by Daniel Karath on 3/8/23.
//

import UIKit

class StartButtonView: UIView {
    
    public weak var delegate: IDQPlayViewDelegate?
    
    private let menuButtonWidth: CGFloat = UIScreen.main.bounds.width * 0.80
    private let menuButtonHight: CGFloat = 48.0
    private let menuButtonCornerRadius: CGFloat = 8.0
    
    private let backgroundImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(systemName: "swift")
        imageView.image?.withTintColor(IDQConstants.basicFontColor, renderingMode: .alwaysTemplate)
        imageView.tintColor = .white
        imageView.alpha = 0.30
        imageView.transform = CGAffineTransform(scaleX: -1, y: 1)
        imageView.contentMode = .scaleAspectFit
        imageView.isAccessibilityElement = false
        return imageView
    }()
    
    private let smallIconImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.layer.cornerRadius = 4
        imageView.backgroundColor = UIColor.black.withAlphaComponent(0.05)
        
        //let padding: CGFloat = 6
        let image = UIImage(systemName: "swift")?.withTintColor(IDQConstants.basicFontColor, renderingMode: .alwaysTemplate)
        //let resizableImage = image?.resizableImage(withCapInsets: UIEdgeInsets(top: padding, left: padding, bottom: padding, right: padding), resizingMode: .stretch)
        
        imageView.tintColor = .white
        imageView.image = image
        imageView.contentMode = .center
        imageView.isAccessibilityElement = false
        return imageView
    }()
    
    private let subTitle: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.alpha = 0.55
        label.textColor = .white//UIColor(red: 220/255, green: 220/255, blue: 220/255, alpha: 1.0)
        label.font = IDQConstants.setFont(fontSize: 13, isBold: true)
        label.text = "Start Quiz"
        label.isAccessibilityElement = false
        return label
    }()
    
    private let mainTitle: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .white
        label.font = IDQConstants.setFont(fontSize: UIScreen.main.bounds.width/20, isBold: false)
        label.text = "Test your Swift skills"
        label.isAccessibilityElement = false
        return label
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
    
    private func setupView() {
        let color1: UIColor = IDQConstants.highlightedLightOrange
        let color2: UIColor = IDQConstants.highlightedDarkOrange
        translatesAutoresizingMaskIntoConstraints = false
        frame.size = CGSize(width: menuButtonWidth, height: 1.80*menuButtonHight)
        layer.cornerRadius = menuButtonCornerRadius
        backgroundColor = IDQConstants.backgroundColor
        clipsToBounds = true
        gradient(color1.cgColor, color2.cgColor, direction: .bottomLeftToTopRight)
        

    }
    
    private func setupConstraints() {
        addSubviews(backgroundImageView, smallIconImageView, subTitle, mainTitle)
        backgroundImageView.bounds = bounds
        NSLayoutConstraint.activate([
            backgroundImageView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 12),
            backgroundImageView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 18),
            backgroundImageView.widthAnchor.constraint(equalToConstant: frame.size.width/3.25),
            backgroundImageView.heightAnchor.constraint(equalToConstant: frame.size.width/3.25),
            
            smallIconImageView.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            smallIconImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8),
            smallIconImageView.widthAnchor.constraint(equalToConstant: 24),
            smallIconImageView.heightAnchor.constraint(equalToConstant: 24),
            
            subTitle.centerYAnchor.constraint(equalTo: smallIconImageView.centerYAnchor, constant: 3),
            subTitle.leadingAnchor.constraint(equalTo: smallIconImageView.trailingAnchor, constant: 6),
            
            mainTitle.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -6),
            mainTitle.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8),
        ])
    }
    
    @objc
    private func startViewTapped(_ gestureRecognizer: UITapGestureRecognizer) {
        //delegate?.idqPlayView(didTapOn: self)
    }
   
}
