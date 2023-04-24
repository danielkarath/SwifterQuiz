//
//  CountDownView.swift
//  iOSDevQuiz
//
//  Created by Daniel Karath on 3/10/23.
//

import UIKit

protocol CountDownViewDelegate: AnyObject {
    func countDownView(_: CountDownView, didReachDeadline: Bool)
}

class CountDownView: UIView {
    
    public weak var delegate: CountDownViewDelegate?
    
    private let colors: [UIColor] = [IDQConstants.correctColor, IDQConstants.highlightedLightOrange, IDQConstants.errorColor]
    
    private var viewSize: CGFloat = 40
    
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
        view.translatesAutoresizingMaskIntoConstraints = false
        view.isHidden = true
        view.alpha = 0.80
        view.backgroundColor = IDQConstants.highlightedDarkOrange
        view.layer.frame = CGRect(x: 0, y: 0, width: 0, height: 0)
        return view
    }()
    
    private let strokeLayer = CAShapeLayer()
    
    //MARK: - Init
        
    override init(frame: CGRect) {
        super.init(frame: frame)
        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = IDQConstants.contentBackgroundColor
        if UIScreen.screenHeight < 980 {
            viewSize = 40.0
        } else if UIScreen.screenHeight < 1100 {
            viewSize = 60.0
        } else {
            viewSize = 80.0
        }
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
        addSubviews(countDownLabel, circularView)
        NSLayoutConstraint.activate([
            countDownLabel.centerXAnchor.constraint(equalTo: centerXAnchor, constant: 0),
            countDownLabel.centerYAnchor.constraint(equalTo: centerYAnchor, constant: viewSize * 0.07),
            countDownLabel.heightAnchor.constraint(equalToConstant: viewSize),
            countDownLabel.widthAnchor.constraint(equalToConstant: viewSize),
            
            
            circularView.centerXAnchor.constraint(equalTo: centerXAnchor, constant: 0),
            circularView.centerYAnchor.constraint(equalTo: centerYAnchor, constant: 0),
        ])
    }
    
    
    private func circleAnimation(_ view: UIView, layer: CAShapeLayer, colors: [CGColor], duration: CFTimeInterval) {
        guard !colors.isEmpty else {return}
        let lineWidth: CGFloat = view.layer.frame.size.width/10
        layer.fillColor = UIColor.clear.cgColor
        layer.strokeColor = colors.last
        layer.lineWidth = lineWidth
        
        layer.path = CGPath.init(roundedRect: view.bounds, cornerWidth: view.layer.frame.size.width/2, cornerHeight: view.layer.frame.size.height/2, transform: nil)
        
        view.layer.addSublayer(layer)
        
        // Create animation layer and add it to the stroke layer.
        let circleAnimation = CABasicAnimation(keyPath: "strokeEnd")
        circleAnimation.fromValue = CGFloat(0.0)
        circleAnimation.toValue = CGFloat(1.0)
        circleAnimation.duration = duration
        circleAnimation.fillMode = CAMediaTimingFillMode.forwards
        circleAnimation.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
        strokeLayer.add(circleAnimation, forKey: "circleAnimation")
        
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
    
    private func startAnimation(with duration: TimeInterval, delay: TimeInterval) {
        var remainingTime: TimeInterval = duration
        DispatchQueue.main.asyncAfter(deadline: .now() + delay) {
            UIView.animate(withDuration: TimeInterval(duration)) {
                self.circleAnimation(self, layer: self.strokeLayer, colors: self.colors.toCGColors(), duration: CFTimeInterval(duration))
                
                self.questionCountdownTimer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) {_ in
                    remainingTime -= 1
                    self.timeSpent = remainingTime
                    if remainingTime <= 0 {
                        self.countDownLabel.text = "0"
                        self.countDownLabel.textColor = IDQConstants.errorColor
                        self.stopTimer()
                        self.delegate?.countDownView(self, didReachDeadline: true)
                    } else {
                        //self.countDownView.changeTimer(remainingTime)
                        var durationString: String = String(remainingTime)
                        durationString = String(durationString.prefix(durationString.count - 2))
                        self.countDownLabel.text = durationString
                        
                        if remainingTime == 10 {
                            let targetSize: CGFloat = self.viewSize * 5.0
                            self.circularView.pulseAnimation(targetSize: targetSize)
                            
                        }
                        if remainingTime == 5 {
                            let targetSize: CGFloat = self.viewSize * 14.50
                            self.circularView.pulseAnimation(targetSize: targetSize, duration: 1.60)
                        }
                    }
                }
            }
        }
    }
    
    //MARK: - Public
    public func isTimerRunning() -> Bool {
        return questionCountdownTimer.isValid
    }
    
    public var timeSpent: TimeInterval = 0
    
    public func setupTimer(game: IDQGame, delay: TimeInterval) {
        startAnimation(with: game.questionTimer.rawValue, delay: delay)
        countDownLabel.text = String(Int(game.questionTimer.rawValue))
    }
    
    public func stopTimer() {
        timeSpent = 0
        if questionCountdownTimer.isValid {
            questionCountdownTimer.invalidate()
            countDownLabel.textColor = IDQConstants.basicFontColor
            strokeLayer.removeAllAnimations()
            strokeLayer.removeFromSuperlayer()
        }
    }
    
    public func pauseTimer() {
        if questionCountdownTimer.isValid {
            questionCountdownTimer.invalidate()
            strokeLayer.removeAllAnimations()
            strokeLayer.removeFromSuperlayer()
        }
    }
    
    public func unpauseTimer(game: IDQGame) {
        if !questionCountdownTimer.isValid {
            let reducedTime = Double(game.questionTimer.rawValue - Double(timeSpent))
            startAnimation(with: timeSpent, delay: 0)
            countDownLabel.text = String(timeSpent)
        }
    }
    
}
