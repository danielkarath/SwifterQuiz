//
//  IDQBookmarkedQuestionCollectionViewCell.swift
//  iOSDevQuiz
//
//  Created by Daniel Karath on 4/21/23.
//

import UIKit

class IDQBookmarkedQuestionCollectionViewCell: UICollectionViewCell {
    
    static let cellidentifier: String = "IDQBookmarkedQuestionCollectionViewCell"
    
    private let questionLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = IDQConstants.basicFontColor
        label.numberOfLines = 0
        label.contentMode = .topLeft
        label.font = IDQConstants.setFont(fontSize: 14, isBold: false)
        label.text = ""
        label.isAccessibilityElement = true
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
    
    override func prepareForReuse() {
        super.prepareForReuse()
        questionLabel.text = nil
    }
    
    //MARK: - Private
    
    private func setupView() {
        translatesAutoresizingMaskIntoConstraints = false
        contentView.translatesAutoresizingMaskIntoConstraints = false
        layer.cornerRadius = 16
        backgroundColor = IDQConstants.contentBackgroundColor
        clipsToBounds = true
    }
    
    private func setupConstraints() {
        addSubviews(questionLabel)
        NSLayoutConstraint.activate([
            questionLabel.topAnchor.constraint(equalTo: topAnchor, constant: 16),
            questionLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            questionLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            questionLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -16),
        ])
    }
    
    
    //MARK: - Public
    
    public func configure(with question: IDQQuestion) {
        guard !question.question.isEmpty else { return }
        questionLabel.text = question.question
    }

    
}
