//
//  StartTrueOrFalseButtonView.swift
//  iOSDevQuiz
//
//  Created by Daniel Karath on 5/2/23.
//

import UIKit

class StartTrueOrFalseButtonView: UIView {
    
    private let subTitleHeight: CGFloat = UIScreen.screenHeight * 0.01524033
    private let titleHeight: CGFloat = UIScreen.screenHeight * 0.02579132
    private let titleBottomAnchor: CGFloat = UIScreen.screenHeight * 0.007034
    private let menuButtonWidth: CGFloat = UIScreen.screenWidth * 0.80
    private let menuButtonHight: CGFloat = UIScreen.screenHeight * 0.05633803
    private let smallIconSize: CGFloat = UIScreen.screenHeight * 0.02813599
    private let backgroundImageBottomAnchor: CGFloat = UIScreen.screenHeight * 0.014068
    private let backgroundImageTrailingAnchor: CGFloat = UIScreen.screenHeight * 0.01610199
    private let menuButtonCornerRadius: CGFloat = 14//UIScreen.screenHeight * 0.01172332943
    
    private let backgroundImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        let originalImage = UIImage(systemName: "arrowtriangle.left.and.line.vertical.and.arrowtriangle.right.fill")!
        let flippedImage = originalImage.imageFlippedForRightToLeftLayoutDirection()
        imageView.image = flippedImage
        imageView.image?.withTintColor(IDQConstants.basicFontColor, renderingMode: .alwaysTemplate)
        imageView.tintColor = IDQConstants.basicFontColor.withAlphaComponent(0.18)
        imageView.alpha = 0.30
        imageView.transform = CGAffineTransform(scaleX: -1, y: 1)
        imageView.contentMode = .scaleAspectFit
        imageView.isAccessibilityElement = false
        return imageView
    }()
    
    private let triangleLayer: CAShapeLayer = {
        let triangleLayer = CAShapeLayer()
        let trianglePath = UIBezierPath()
        let fillColor: UIColor = IDQConstants.secondaryFontColor.withAlphaComponent(0.15)
        let maxY: CGFloat = UIScreen.screenHeight > 1000 ? 150 : 100
        let maxX = UIScreen.main.bounds.width
        
//        trianglePath.move(to: CGPoint(x: 0, y: 0))
//        trianglePath.addLine(to: CGPoint(x: maxX, y: 0))
//        trianglePath.addLine(to: CGPoint(x: 0, y: maxY * 0.8))
        
        trianglePath.move(to: CGPoint(x: 0, y: 0))
        trianglePath.addLine(to: CGPoint(x: maxX*0.70, y: 0))
        trianglePath.addLine(to: CGPoint(x: 0, y: maxY))
        trianglePath.close()
        
        triangleLayer.path = trianglePath.cgPath
        triangleLayer.fillColor = fillColor.cgColor
//        triangleLayer.strokeColor = UIColor.black.cgColor
        triangleLayer.lineWidth = 0.0
        
        return triangleLayer
    }()

    private let smallIconImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.layer.cornerRadius = 4
        imageView.contentMode = .scaleAspectFit
        imageView.backgroundColor = IDQConstants.contentBackgroundColor.withAlphaComponent(0.64)
        imageView.isAccessibilityElement = false
        imageView.frame = CGRect(x: 0, y: 0, width: UIScreen.screenHeight * 0.02813599, height: UIScreen.screenHeight * 0.02813599)
        imageView.clipsToBounds = true

        let image = UIImage(systemName: "signpost.right.and.left.fill")?.withRenderingMode(.alwaysTemplate)

        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = imageView.bounds

        let maskLayer = CALayer()
        maskLayer.contents = image?.cgImage

        let padding: CGFloat = UIScreen.screenHeight * 0.02813599 * 0.15
        let paddedFrame = CGRect(x: padding, y: padding, width: imageView.bounds.width - padding * 2, height: imageView.bounds.height - padding * 2)

        maskLayer.frame = paddedFrame

        gradientLayer.colors = [IDQConstants.highlightedLightOrange.cgColor, IDQConstants.highlightedDarkOrange.cgColor]
        gradientLayer.startPoint = CGPoint(x: 1.0, y: 0.0)
        gradientLayer.endPoint = CGPoint(x: 0.0, y: 1.0)

        gradientLayer.mask = maskLayer

        imageView.layer.addSublayer(gradientLayer)

        return imageView
    }()

    
    private let subTitle: GradientLabel = {
        let label = GradientLabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.alpha = 0.55
        label.textColor = IDQConstants.secondaryFontColor
        label.font = IDQConstants.setFont(fontSize: 13, isBold: true)
        label.text = "True or false"
        label.isAccessibilityElement = false
        return label
    }()
    
    private let mainTitle: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = IDQConstants.basicFontColor
        label.font = IDQConstants.setFont(fontSize: 20, isBold: false)
        label.text = "How far will you get?"
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
        backgroundColor = IDQConstants.contentBackgroundColor
        //gradient(color1.cgColor, color2.cgColor, direction: .bottomLeftToTopRight)
        
        mainTitle.font = IDQConstants.setFont(fontSize: titleHeight, isBold: false)
        subTitle.font = IDQConstants.setFont(fontSize: subTitleHeight, isBold: true)
    }
    
    private func setupConstraints() {
        self.layer.addSublayer(triangleLayer)
        addSubviews(backgroundImageView, smallIconImageView, subTitle, mainTitle) //smallIconOuterView
        //smallIconOuterView.addSubview(smallIconImageView)
        backgroundImageView.bounds = bounds
        
        let backgroundImageSize: CGFloat = UIScreen.screenHeight * 0.11267606
        
        NSLayoutConstraint.activate([
            backgroundImageView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: backgroundImageBottomAnchor),
            backgroundImageView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: backgroundImageTrailingAnchor),
            backgroundImageView.widthAnchor.constraint(equalToConstant: backgroundImageSize),
            backgroundImageView.heightAnchor.constraint(equalToConstant: backgroundImageSize),
            
//            smallIconOuterView.topAnchor.constraint(equalTo: topAnchor, constant: 10),
//            smallIconOuterView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8),
//            smallIconOuterView.widthAnchor.constraint(equalToConstant: smallIconSize),
//            smallIconOuterView.heightAnchor.constraint(equalToConstant: smallIconSize),
            smallIconImageView.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            smallIconImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8),
            smallIconImageView.widthAnchor.constraint(equalToConstant: smallIconSize),
            smallIconImageView.heightAnchor.constraint(equalToConstant: smallIconSize),
            
            
//            smallIconImageView.centerYAnchor.constraint(equalTo: smallIconOuterView.centerYAnchor, constant: 0),
//            smallIconImageView.centerXAnchor.constraint(equalTo: smallIconOuterView.centerXAnchor, constant: 0),
//            smallIconImageView.widthAnchor.constraint(equalToConstant: smallIconSize * 0.75),
//            smallIconImageView.heightAnchor.constraint(equalToConstant: smallIconSize * 0.75),
            
            subTitle.centerYAnchor.constraint(equalTo: smallIconImageView.centerYAnchor, constant: smallIconSize * 0.125),
            subTitle.leadingAnchor.constraint(equalTo: smallIconImageView.trailingAnchor, constant: smallIconSize * 0.25),
            
            mainTitle.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -(titleBottomAnchor)),
            mainTitle.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8),
        ])
    }
    
    
    
}
