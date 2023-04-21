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
        imageView.contentMode = .scaleToFill
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
        let fontSize: CGFloat = UIScreen.main.bounds.height * 0.01524033
        label.layer.zPosition = 5
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .left
        label.text = "Some difficulty"
        label.font = IDQConstants.setFont(fontSize: fontSize, isBold: true)
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
        let fontSize: CGFloat = UIScreen.main.bounds.height * 0.02227433 //0.01758499
        label.layer.zPosition = 8
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .left
        label.contentMode = .topLeft
        label.numberOfLines = 0
        label.text = "Some question"
        label.font = IDQConstants.setFont(fontSize: fontSize, isBold: false)
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
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
                
        imageOuterView.gradient(IDQConstants.highlightedContentBackgroundColor.cgColor, IDQConstants.backgroundColor.cgColor, direction: .horizontal)
    }
    
    private func addConstraints() {
        let difficultyLabelHeight: CGFloat = UIScreen.main.bounds.height * 0.03516999
        let difficultyLabelWidth: CGFloat = UIScreen.main.bounds.height * 0.09378664
        let isCorrectImageViewSize: CGFloat = UIScreen.main.bounds.height * 0.01641266
        
        NSLayoutConstraint.activate([
            
            imageOuterView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 0),
            imageOuterView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: 0),
            imageOuterView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: 0),
            imageOuterView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 0),
            
            questionTypeImageView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 16),
            questionTypeImageView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 16),
            questionTypeImageView.widthAnchor.constraint(equalToConstant: frame.size.width/2.70),
            questionTypeImageView.heightAnchor.constraint(equalToConstant: frame.size.width/2.70),
            
            difficultyLabel.leadingAnchor.constraint(equalTo: isCorrectImageView.trailingAnchor, constant: 3),
            difficultyLabel.widthAnchor.constraint(lessThanOrEqualToConstant: difficultyLabelWidth),
            difficultyLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            difficultyLabel.heightAnchor.constraint(equalToConstant: difficultyLabelHeight),
            
            isCorrectImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: isCorrectImageViewSize),
            isCorrectImageView.centerYAnchor.constraint(equalTo: difficultyLabel.centerYAnchor, constant: -1.00),
            isCorrectImageView.widthAnchor.constraint(lessThanOrEqualToConstant: isCorrectImageViewSize),
            isCorrectImageView.heightAnchor.constraint(lessThanOrEqualToConstant: isCorrectImageViewSize),
            
            questionLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            questionLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -64),
            questionLabel.topAnchor.constraint(equalTo: difficultyLabel.bottomAnchor, constant: -2),
            questionLabel.heightAnchor.constraint(lessThanOrEqualToConstant: 90)
            
        ])
    }
    
    private func setupBackgroundGradient() {
        imageOuterView.frame.size = CGSize(width: contentView.layer.frame.width, height: contentView.layer.frame.height)
        imageOuterView.gradient(IDQConstants.highlightedContentBackgroundColor.cgColor, IDQConstants.backgroundColor.cgColor, direction: .horizontal)
    }
    
    private func setupIsCorrectIcon(answerType: IDQAnswerType) {
        var markImage: UIImage?
        
        switch answerType {
        case .correct:
            markImage = (UIImage(systemName: "checkmark.circle.fill")?.withTintColor(IDQConstants.correctColor, renderingMode: .alwaysTemplate))
            self.isCorrectImageView.tintColor = IDQConstants.correctColor
        case .wrong:
            markImage = (UIImage(systemName: "x.circle.fill")?.withTintColor(IDQConstants.correctColor, renderingMode: .alwaysTemplate))
            self.isCorrectImageView.tintColor = IDQConstants.errorColor
        case .passed:
            markImage = (UIImage(systemName: "exclamationmark.triangle.fill")?.withTintColor(IDQConstants.warningColor, renderingMode: .alwaysTemplate))
            self.isCorrectImageView.tintColor = IDQConstants.warningColor
        case .runOutOfTime:
            markImage = (UIImage(systemName: "exclamationmark.triangle.fill")?.withTintColor(IDQConstants.warningColor, renderingMode: .alwaysTemplate))
            self.isCorrectImageView.tintColor = IDQConstants.warningColor
        case .leftQuestion:
            markImage = (UIImage(systemName: "exclamationmark.triangle.fill")?.withTintColor(IDQConstants.warningColor, renderingMode: .alwaysTemplate))
            self.isCorrectImageView.tintColor = IDQConstants.warningColor
        }
        
        self.isCorrectImageView.image = markImage
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        questionLabel.text = nil
        difficultyLabel.text = nil
        questionTypeImageView.image = nil
        isCorrectImageView.image = nil
        //imageOuterView.layer.sublayers?.forEach { $0.removeFromSuperlayer() }

    }
    
    public func configure(with quiz: IDQQuiz, index: Int) {
        guard quiz.questions.count >= index + 1 else { return }
        let question: IDQQuestion = quiz.questions[index].question
        let answerType: IDQAnswerType = quiz.questions[index].answerType
        setupIsCorrectIcon(answerType: answerType)
        questionLabel.text = question.question
        difficultyLabel.text = question.difficulty.rawValue
        questionTypeImageView.image = question.topic.image
    }
    
}
