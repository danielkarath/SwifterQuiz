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
        imageView.layer.zPosition = 1
        imageView.layer.cornerRadius = 2
        imageView.clipsToBounds = true
        imageView.backgroundColor = IDQConstants.contentBackgroundColor
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
        label.layer.zPosition = 5
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .left
        label.text = "Some difficulty"
        label.font = IDQConstants.setFont(fontSize: 12, isBold: false)
        label.textColor = IDQConstants.secondaryFontColor
        return label
    }()
    
    private let questionLabel: UILabel = {
        let label = UILabel()
        label.layer.zPosition = 8
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .left
        label.contentMode = .topLeft
        label.numberOfLines = 0
        label.text = "Some question"
        label.font = IDQConstants.setFont(fontSize: 20, isBold: true)
        label.textColor = IDQConstants.basicFontColor
        return label
    }()
    
    //MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.layer.cornerRadius = 8
        contentView.backgroundColor = IDQConstants.backgroundColor
        contentView.addSubviews(questionLabel, imageOuterView, difficultyLabel)
        imageOuterView.addSubview(questionTypeImageView)
        addConstraints()
        imageOuterView.gradient(IDQConstants.contentBackgroundColor.cgColor, IDQConstants.darkOrange.cgColor, direction: .vertical)
    }
    
    required init?(coder: NSCoder) {
        fatalError("Unsupported")
    }
    
    private func addConstraints() {
        NSLayoutConstraint.activate([
            
            imageOuterView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 140),
            imageOuterView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: 0),
            imageOuterView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: 0),
            imageOuterView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 0),
            
            questionTypeImageView.leadingAnchor.constraint(equalTo: imageOuterView.leadingAnchor, constant: 20),
            questionTypeImageView.trailingAnchor.constraint(equalTo: imageOuterView.trailingAnchor, constant: 0),
            questionTypeImageView.bottomAnchor.constraint(equalTo: imageOuterView.bottomAnchor, constant: 0),
            questionTypeImageView.topAnchor.constraint(equalTo: imageOuterView.topAnchor, constant: 0),
            
            difficultyLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            difficultyLabel.widthAnchor.constraint(equalToConstant: 60),
            difficultyLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            difficultyLabel.heightAnchor.constraint(equalToConstant: 30),
            
            questionLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            questionLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -64),
            questionLabel.topAnchor.constraint(equalTo: difficultyLabel.bottomAnchor, constant: -10),
            questionLabel.heightAnchor.constraint(equalToConstant: 65),
            
        ])
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        questionLabel.text = nil
        difficultyLabel.text = nil
    }
    
}
