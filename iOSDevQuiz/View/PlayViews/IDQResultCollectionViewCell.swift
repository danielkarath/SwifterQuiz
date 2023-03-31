//
//  IDQResultCollectionViewCell.swift
//  iOSDevQuiz
//
//  Created by Daniel Karath on 3/21/23.
//

import UIKit

final class IDQResultCollectionViewCell: UICollectionViewCell {
    static let cellIdentifier = "IDQResultCollectionViewCell"
    
    let questionTypeImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.zPosition = 4
        imageView.layer.cornerRadius = 2
        imageView.clipsToBounds = true
        //imageView.backgroundColor = IDQConstants.contentBackgroundColor
        imageView.contentMode = .scaleToFill
        imageView.image = IDQConstants.arkitImage
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let imageOuterView: UIView = {
        let view = UIView()
        view.layer.zPosition = 3
        view.layer.cornerRadius = 2
        view.clipsToBounds = true
        view.backgroundColor = IDQConstants.contentBackgroundColor
        view.contentMode = .scaleToFill
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let difficultyLabel: UILabel = {
        let label = UILabel()
        label.layer.zPosition = 5
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .left
        label.text = "Some difficulty"
        label.font = IDQConstants.setFont(fontSize: 13, isBold: true)
        label.textColor = IDQConstants.secondaryFontColor
        return label
    }()
    
    private let isCorrectImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.zPosition = 10
        imageView.layer.cornerRadius = 0
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let questionLabel: UILabel = {
        let label = UILabel()
        label.layer.zPosition = 8
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .left
        label.contentMode = .topLeft
        label.numberOfLines = 0
        label.text = "Some question"
        label.font = IDQConstants.setFont(fontSize: 15, isBold: false)
        label.textColor = IDQConstants.basicFontColor
        return label
    }()
    
    //MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.layer.cornerRadius = 16
        contentView.clipsToBounds = true
        contentView.backgroundColor = IDQConstants.backgroundColor
        contentView.addSubviews(questionLabel, imageOuterView, difficultyLabel, isCorrectImageView)
        imageOuterView.addSubview(questionTypeImageView)
        setupBackgroundGradient()
        addConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("Unsupported")
    }
    
    private func addConstraints() {
        NSLayoutConstraint.activate([
            
            imageOuterView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 0),
            imageOuterView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: 0),
            imageOuterView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: 0),
            imageOuterView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 0),
            
            questionTypeImageView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 12),
            questionTypeImageView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 18),
            questionTypeImageView.widthAnchor.constraint(equalToConstant: frame.size.width/3.00),
            questionTypeImageView.heightAnchor.constraint(equalToConstant: frame.size.width/3.00),
            
            difficultyLabel.leadingAnchor.constraint(equalTo: isCorrectImageView.trailingAnchor, constant: 3),
            difficultyLabel.widthAnchor.constraint(lessThanOrEqualToConstant: 60),
            difficultyLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            difficultyLabel.heightAnchor.constraint(equalToConstant: 30),
            
            isCorrectImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 14),
            isCorrectImageView.centerYAnchor.constraint(equalTo: difficultyLabel.centerYAnchor, constant: -1.00),
            isCorrectImageView.widthAnchor.constraint(lessThanOrEqualToConstant: 14),
            isCorrectImageView.heightAnchor.constraint(lessThanOrEqualToConstant: 14),
            
            questionLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            questionLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -72),
            questionLabel.topAnchor.constraint(equalTo: difficultyLabel.bottomAnchor, constant: -4),
            questionLabel.heightAnchor.constraint(lessThanOrEqualToConstant: 90)
            
        ])
    }
    
    private func setupBackgroundGradient() {
        imageOuterView.frame.size = CGSize(width: contentView.layer.frame.width, height: contentView.layer.frame.height)
        imageOuterView.gradient(IDQConstants.highlightedContentBackgroundColor.cgColor, IDQConstants.backgroundColor.cgColor, direction: .horizontal)
    }
    
    private func setupIsCorrectIcon(isCorrect: Bool) {
        var markImage: UIImage?
        //self.isCorrectImageView.tintColor = IDQConstants.secondaryFontColor
        if isCorrect {
            markImage = (UIImage(systemName: "checkmark.circle.fill")?.withTintColor(IDQConstants.correctColor, renderingMode: .alwaysTemplate))
            self.isCorrectImageView.tintColor = IDQConstants.correctColor
        } else {
            markImage = (UIImage(systemName: "x.circle.fill")?.withTintColor(IDQConstants.correctColor, renderingMode: .alwaysTemplate))
            self.isCorrectImageView.tintColor = IDQConstants.errorColor
        }
        self.isCorrectImageView.image = markImage
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        questionLabel.text = nil
        difficultyLabel.text = nil
        imageOuterView.layer.sublayers?.forEach { $0.removeFromSuperlayer() }

    }
    
    public func configure(with quiz: IDQQuiz, index: Int) {
        guard quiz.questions.count >= index + 1 else { return }
        let question: IDQQuestion = quiz.questions[index].question
        let isCorrect: Bool = quiz.questions[index].answeredCorrectly
        setupIsCorrectIcon(isCorrect: isCorrect)
        questionLabel.text = question.question
        difficultyLabel.text = question.difficulty.rawValue
    }
    
}
