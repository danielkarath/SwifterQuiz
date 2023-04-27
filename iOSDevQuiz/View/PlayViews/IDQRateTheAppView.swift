//
//  IDQRateTheAppView.swift
//  iOSDevQuiz
//
//  Created by Daniel Karath on 4/23/23.
//

import UIKit

protocol IDQRateTheAppViewDelegate: AnyObject {
    func didTapClose()
    func didRateApp()
}

class IDQRateTheAppView: UIView {
    
    public weak var delegate: IDQRateTheAppViewDelegate?
    
    private let subTitleHeight: CGFloat = UIScreen.screenHeight * 0.01524033
    private let titleHeight: CGFloat = UIScreen.screenHeight * 0.02579132
    private let titleBottomAnchor: CGFloat = UIScreen.screenHeight * 0.007034
    private let menuButtonWidth: CGFloat = UIScreen.screenWidth * 0.80
    private let menuButtonHight: CGFloat = UIScreen.screenHeight * 0.05633803
    private let smallIconSize: CGFloat = UIScreen.screenHeight * 0.02813599
    private let backgroundImageBottomAnchor: CGFloat = UIScreen.screenHeight * 0.017068
    private let backgroundImageTrailingAnchor: CGFloat = UIScreen.screenHeight * 0.02210199
    private let menuButtonCornerRadius: CGFloat = 14
    
    private let backgroundImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(systemName: "star.fill")
        imageView.image?.withTintColor(IDQConstants.basicFontColor, renderingMode: .alwaysTemplate)
        imageView.tintColor = IDQConstants.basicFontColor.withAlphaComponent(0.18)
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
        imageView.contentMode = .scaleAspectFit
        imageView.backgroundColor = IDQConstants.basicFontColor.withAlphaComponent(0.04)
        imageView.isAccessibilityElement = false
        imageView.frame = CGRect(x: 0, y: 0, width: UIScreen.screenHeight * 0.02813599, height: UIScreen.screenHeight * 0.02813599)
        imageView.clipsToBounds = true

        // Set the image
        let image = UIImage(systemName: "hand.thumbsup.fill")?.withRenderingMode(.alwaysTemplate)

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

        gradientLayer.colors = [IDQConstants.highlightedLightOrange.cgColor, IDQConstants.highlightedDarkOrange.cgColor]
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
        label.textColor = IDQConstants.secondaryFontColor
        label.font = IDQConstants.setFont(fontSize: 13, isBold: true)
        label.text = "Rate Me"
        label.isAccessibilityElement = false
        return label
    }()
    
    private let mainTitle: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = IDQConstants.basicFontColor
        label.font = IDQConstants.setFont(fontSize: 20, isBold: false)
        label.text = "Do you like the app?"
        label.isAccessibilityElement = false
        return label
    }()
    
    private let closeButton: UIButton = {
        let button = UIButton()
        button.frame.size = CGSize(width: 30, height: 30)
        button.titleLabel?.font = IDQConstants.setFont(fontSize: 16, isBold: false)
        button.backgroundColor = IDQConstants.secondaryFontColor.withAlphaComponent(0.0)
        button.setTitle("x", for: .normal)
        button.setTitleColor(IDQConstants.secondaryFontColor, for: .normal)
//        button.setImage(UIImage(systemName: "x.circle"), for: .normal)
//        button.setImage(UIImage(systemName: "x.circle"), for: .highlighted)
        button.tintColor = IDQConstants.secondaryFontColor
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
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
        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = IDQConstants.contentBackgroundColor
        frame.size = CGSize(width: menuButtonWidth, height: 1.80*menuButtonHight)
        layer.cornerRadius = menuButtonCornerRadius
        clipsToBounds = true
        
        mainTitle.font = IDQConstants.setFont(fontSize: titleHeight, isBold: false)
        subTitle.font = IDQConstants.setFont(fontSize: subTitleHeight, isBold: true)
        
        closeButton.addTarget(self, action: #selector(didTapClose(_:)), for: .touchUpInside)
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(didTapRate(_:)))
        self.addGestureRecognizer(tapGesture)
    }
    
    private func setupConstraints() {
        addSubviews(backgroundImageView, subTitle, mainTitle, closeButton, smallIconImageView)
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
            
            closeButton.topAnchor.constraint(equalTo: topAnchor, constant: 2),
            closeButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -2),
            closeButton.heightAnchor.constraint(equalToConstant: 30),
            closeButton.widthAnchor.constraint(equalToConstant: 30)
        ])
    }
    
    @objc
    private func didTapClose(_: UIButton) {
        delegate?.didTapClose()
    }
    
    @objc
    private func didTapRate(_ gestureRecognizer: UITapGestureRecognizer) {
        delegate?.didRateApp()
    }
}
