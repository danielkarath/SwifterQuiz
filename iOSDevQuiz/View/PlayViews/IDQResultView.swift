//
//  IDQResultView.swift
//  iOSDevQuiz
//
//  Created by Daniel Karath on 3/21/23.
//

import UIKit

protocol IDQResultViewDelegate: AnyObject {
    func idqResultView(_ resultView: IDQResultView, didFinishQuiz quiz: IDQQuiz?)
}

class IDQResultView: UIView {
    
    public weak var delegate: IDQPlayViewDelegate?
    
    private var quiz: IDQQuiz?
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Results"
        label.numberOfLines = 1
        label.textAlignment = .center
        label.textColor = IDQConstants.highlightedDarkOrange
        label.font = IDQConstants.setFont(fontSize: 21, isBold: true)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    //MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
        setupConstraints()
//        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(startViewTapped(_:)))
//        addGestureRecognizer(tapGesture)
    }
    
    required init?(coder: NSCoder) {
        fatalError("IDQPlayView is unsupported!")
    }
    
    private func setupView() {
        let color1: UIColor = IDQConstants.highlightedLightOrange
        let color2: UIColor = IDQConstants.highlightedDarkOrange
        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = IDQConstants.backgroundColor
    }
    
    //MARK: - Private
    
    private func setupConstraints() {
        addSubviews(titleLabel)
        NSLayoutConstraint.activate([
            titleLabel.heightAnchor.constraint(equalToConstant: 26),
            titleLabel.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width*0.80),
            titleLabel.centerXAnchor.constraint(equalTo: centerXAnchor, constant: 0),
            titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: 70),
        ])
    }
    
    //MARK: - Public
    
    public func configure(quiz: IDQQuiz) {
        titleLabel.text = "Total Score: \(quiz.totalScore)"
    }
}
