//
//  CountDownView.swift
//  iOSDevQuiz
//
//  Created by Daniel Karath on 3/10/23.
//

import UIKit

class CountDownView: UIView {
    
    private let colors: [UIColor] = [IDQConstants.correctColor, IDQConstants.highlightedLightOrange, IDQConstants.errorColor]
    
    private let viewSize: CGFloat = 140
    
    private var questionCountdownTimer = Timer()
    
    private let countDownLabel: UILabel = {
        let label = UILabel()
        label.text = " "
        label.numberOfLines = 1
        label.textAlignment = .center
        label.contentMode = .center
        label.textColor = IDQConstants.basicFontColor
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let circularView: UIView = {
        let view = UIView()
        
        return view
    }()
    
    //MARK: - Init
        
    override init(frame: CGRect) {
        super.init(frame: frame)
        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = IDQConstants.contentBackgroundColor
        self.layer.frame = CGRect(x: 0, y: 0, width: viewSize, height: viewSize)
        backgroundColor = IDQConstants.backgroundColor
        layer.cornerRadius = viewSize/2
        countDownLabel.font = IDQConstants.setFont(fontSize: viewSize/1.6, isBold: true)
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("Unsupported")
    }
    
    //MARK: - Private
    
    private func setupConstraints() {
        addSubviews(countDownLabel)
        NSLayoutConstraint.activate([
            countDownLabel.centerXAnchor.constraint(equalTo: centerXAnchor, constant: 0),
            countDownLabel.centerYAnchor.constraint(equalTo: centerYAnchor, constant: viewSize * 0.07),
            countDownLabel.heightAnchor.constraint(equalToConstant: viewSize),
            countDownLabel.widthAnchor.constraint(equalToConstant: viewSize),
        ])
    }
    
    private func circleAnimation(_ view: UIView, colors: [CGColor], duration: CFTimeInterval) {
        guard !colors.isEmpty else {return}
        let lineWidth: CGFloat = view.layer.frame.size.width/10
        let strokeLayer = CAShapeLayer()
        strokeLayer.fillColor = UIColor.clear.cgColor
        strokeLayer.strokeColor = colors.last
        strokeLayer.lineWidth = lineWidth
        
        strokeLayer.path = CGPath.init(roundedRect: view.bounds, cornerWidth: view.layer.frame.size.width/2, cornerHeight: view.layer.frame.size.height/2, transform: nil)
        
        view.layer.addSublayer(strokeLayer)
        
        // Create animation layer and add it to the stroke layer.
        let animation = CABasicAnimation(keyPath: "strokeEnd")
        animation.fromValue = CGFloat(0.0)
        animation.toValue = CGFloat(1.0)
        animation.duration = duration
        animation.fillMode = CAMediaTimingFillMode.forwards
        animation.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
        strokeLayer.add(animation, forKey: "circleAnimation")
        
        // Keyframe animation to change the color at 50% of the animation duration.
        let colorAnimation = CAKeyframeAnimation(keyPath: "strokeColor")
        
        colorAnimation.values = colors
        colorAnimation.keyTimes = [0.0]
        
        var i = colors.count
        for color in colors {
            if i <= 2 {
                let keyTime: NSNumber = 1.0
                colorAnimation.keyTimes?.append(keyTime)
                break
            } else {
                let keyTime: NSNumber = NSNumber(value: 1.0/Double(i-1))
                colorAnimation.keyTimes?.append(keyTime)
            }
            i -= 1
        }
        colorAnimation.duration = duration
        strokeLayer.add(colorAnimation, forKey: "colorAnimation")
    }
    
    private func startAnimation(with duration: Int) {
        var remainingTime: Int = duration
        UIView.animate(withDuration: TimeInterval(duration)) {
            self.circleAnimation(self, colors: self.colors.toCGColors(), duration: CFTimeInterval(duration))
            
            self.questionCountdownTimer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) {_ in
                remainingTime -= 1
                if remainingTime <= 0 {
                    self.countDownLabel.text = "0"
                    self.countDownLabel.textColor = IDQConstants.errorColor
                    self.questionCountdownTimer.invalidate()
                } else {
                    //self.countDownView.changeTimer(remainingTime)
                    self.countDownLabel.text = String(remainingTime)
                    if remainingTime <= duration/7 {
                        self.countDownLabel.textColor = IDQConstants.errorColor
                    } else if remainingTime <= duration/5 {
                        self.countDownLabel.textColor = IDQConstants.lightOrange
                    } else if remainingTime <= duration/3 {
                        self.countDownLabel.textColor = IDQConstants.highlightedLightOrange
                    }
                }
            }
        }
    }
    
    //MARK: - Public
    
    public func setupTimer(game: IDQGame) {
        startAnimation(with: Int(game.questionTimer.rawValue))
        countDownLabel.text = String(Int(game.questionTimer.rawValue))
    }
    
    
}
