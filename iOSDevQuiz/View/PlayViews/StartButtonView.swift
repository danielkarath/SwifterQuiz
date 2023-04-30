//
//  StartButtonView.swift
//  iOSDevQuiz
//
//  Created by Daniel Karath on 3/8/23.
//

import UIKit

class StartButtonView: UIView {
        
    private let subTitleHeight: CGFloat = UIScreen.screenHeight * 0.01524033
    private let titleHeight: CGFloat = UIScreen.screenHeight * 0.02579132
    private let titleBottomAnchor: CGFloat = UIScreen.screenHeight * 0.007034
    private let menuButtonWidth: CGFloat = UIScreen.screenWidth * 0.80
    private let menuButtonHight: CGFloat = UIScreen.screenHeight * 0.05633803
    private let smallIconSize: CGFloat = UIScreen.screenHeight * 0.02813599
    private let backgroundImageBottomAnchor: CGFloat = UIScreen.screenHeight * 0.014068
    private let backgroundImageTrailingAnchor: CGFloat = UIScreen.screenHeight * 0.02110199
    private let menuButtonCornerRadius: CGFloat = 14//UIScreen.screenHeight * 0.01172332943
    
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
    
//    private let smallIconImageView: UIImageView = {
//        let imageView = UIImageView()
//        imageView.translatesAutoresizingMaskIntoConstraints = false
//        imageView.layer.cornerRadius = 4
//        imageView.backgroundColor = UIColor.black.withAlphaComponent(0.05)
//
//        let image = UIImage(systemName: "swift")?.withTintColor(IDQConstants.basicFontColor, renderingMode: .alwaysTemplate)
//
//        imageView.tintColor = .white
//        imageView.image = image
//        imageView.contentMode = .scaleAspectFit
//        imageView.isAccessibilityElement = false
//        return imageView
//    }()
    
    private let smallIconImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.layer.cornerRadius = 4
        imageView.contentMode = .scaleAspectFit
        imageView.backgroundColor = IDQConstants.basicFontColor.withAlphaComponent(0.04)
        imageView.isAccessibilityElement = false
        imageView.frame = CGRect(x: 0, y: 0, width: UIScreen.screenHeight * 0.02813599, height: UIScreen.screenHeight * 0.02813599)
        imageView.clipsToBounds = true

        // Set the image
        let image = UIImage(systemName: "swift")?.withRenderingMode(.alwaysTemplate)

        // Create a gradient layer
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = imageView.bounds

        // Create a mask using the image
        let maskLayer = CALayer()
        maskLayer.contents = image?.cgImage

        // Add inner padding
        let padding: CGFloat = UIScreen.screenHeight * 0.02813599 * 0.15
        let paddedFrame = CGRect(x: padding, y: padding, width: imageView.bounds.width - padding * 2, height: imageView.bounds.height - padding * 2)

        maskLayer.frame = paddedFrame

        gradientLayer.colors = [IDQConstants.whiteColor.cgColor, UIColor.white.cgColor]
        gradientLayer.startPoint = CGPoint(x: 1.0, y: 0.0)
        gradientLayer.endPoint = CGPoint(x: 0.0, y: 1.0)

        gradientLayer.mask = maskLayer

        // Add the gradient layer to the image view's layer
        imageView.layer.addSublayer(gradientLayer)

        return imageView
    }()
    
    private let subTitle: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.alpha = 0.55
        label.textColor = .white//UIColor(red: 220/255, green: 220/255, blue: 220/255, alpha: 1.0)
        label.font = IDQConstants.setFont(fontSize: 13, isBold: true)
        label.text = "Quick Quiz"
        label.isAccessibilityElement = false
        return label
    }()
    
    private let mainTitle: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .white
        label.font = IDQConstants.setFont(fontSize: 20, isBold: false)
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
        clipsToBounds = true
        gradient(color1.cgColor, color2.cgColor, direction: .bottomLeftToTopRight)
        
        mainTitle.font = IDQConstants.setFont(fontSize: titleHeight, isBold: false)
        subTitle.font = IDQConstants.setFont(fontSize: subTitleHeight, isBold: true)
    }
    
    private func setupConstraints() {
        addSubviews(backgroundImageView, smallIconImageView, subTitle, mainTitle)
        backgroundImageView.bounds = bounds
        
        let backgroundImageSize: CGFloat = UIScreen.screenHeight * 0.11267606
        
        NSLayoutConstraint.activate([
            backgroundImageView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: backgroundImageBottomAnchor),
            backgroundImageView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: backgroundImageTrailingAnchor),
            backgroundImageView.widthAnchor.constraint(equalToConstant: backgroundImageSize),
            backgroundImageView.heightAnchor.constraint(equalToConstant: backgroundImageSize),
            
            smallIconImageView.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            smallIconImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8),
            smallIconImageView.widthAnchor.constraint(equalToConstant: smallIconSize),
            smallIconImageView.heightAnchor.constraint(equalToConstant: smallIconSize),
            
            subTitle.centerYAnchor.constraint(equalTo: smallIconImageView.centerYAnchor, constant: smallIconSize * 0.125),
            subTitle.leadingAnchor.constraint(equalTo: smallIconImageView.trailingAnchor, constant: smallIconSize * 0.25),
            
            mainTitle.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -(titleBottomAnchor)),
            mainTitle.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8),
        ])
    }
    
   
}
