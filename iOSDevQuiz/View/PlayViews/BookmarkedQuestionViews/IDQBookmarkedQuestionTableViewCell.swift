//
//  IDQBookmarkedQuestionTableViewCell.swift
//  iOSDevQuiz
//
//  Created by Daniel Karath on 4/21/23.
//

import UIKit

class IDQBookmarkedQuestionTableViewCell: UITableViewCell {
    
    static let cellidentifier: String = "IDQBookmarkedQuestionTableViewCell"
    
    private let questionLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = IDQConstants.basicFontColor
        label.numberOfLines = 0
        label.contentMode = .topLeft
        label.font = IDQConstants.setFont(fontSize: 14, isBold: true)
        label.isAccessibilityElement = true
        return label
    }()
    
    private let answerView: UITextView = {
        let view = UITextView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .clear.withAlphaComponent(0.0)
        view.isEditable = false
        view.textColor = IDQConstants.secondaryFontColor
        view.contentMode = .topLeft
        view.font = IDQConstants.setFont(fontSize: 14, isBold: false)
        view.isAccessibilityElement = true
        return view
    }()
    
    
    //MARK: - Init
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
         super.init(style: style, reuseIdentifier: reuseIdentifier)
         setupView()
         setupConstraints()
     }
     
     required init?(coder: NSCoder) {
         fatalError("IDQPlayView is unsupported!")
     }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        layer.cornerRadius = 14
        questionLabel.text = nil
    }
    
    //MARK: - Private
    
    private func setupView() {
        layer.cornerRadius = 16
        backgroundColor = IDQConstants.contentBackgroundColor
        clipsToBounds = true
    }
    
    private func setupConstraints() {
        addSubviews(questionLabel, answerView)
        NSLayoutConstraint.activate([
            questionLabel.topAnchor.constraint(equalTo: topAnchor, constant: 8),
            questionLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            questionLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            questionLabel.heightAnchor.constraint(equalToConstant: 40),
            
            answerView.topAnchor.constraint(equalTo: questionLabel.bottomAnchor, constant: -4),
            answerView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -16),
            answerView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 14),
            answerView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -14)
        ])
    }
    
    
    //MARK: - Public
    
    public func configure(with question: IDQQuestion) {
        guard !question.question.isEmpty else { return }
        questionLabel.text = question.question
        for answer in question.answers {
            if answer.answerType == .correct {
                answerView.text = answer.text
            }
        }
    }


}
