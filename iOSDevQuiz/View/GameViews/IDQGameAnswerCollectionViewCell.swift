//
//  IDQGameAnswerCollectionViewCell.swift
//  iOSDevQuiz
//
//  Created by Daniel Karath on 3/12/23.
//

import UIKit

class IDQGameAnswerCollectionViewCell: UICollectionViewCell {
    
    static let cellidentifier: String = "IDQGameAnswerCollectionViewCell"
    
    private let answerImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.cornerRadius = 4
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let answerTextView: UITextView = {
        let textView = UITextView()
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.textColor = IDQConstants.basicFontColor
        textView.isEditable = false
        textView.isSelectable = false
        textView.isUserInteractionEnabled = false
        textView.backgroundColor = .clear.withAlphaComponent(0.0)
        textView.contentMode = .topLeft
        textView.font = UIFont(name: "Kailasa Regular", size: 14)!
        textView.text = ""
        textView.isAccessibilityElement = true
        return textView
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
        answerTextView.text = nil
    }
    
    //MARK: - Private
    
    private func setupView() {
        let color1: UIColor = IDQConstants.highlightedLightOrange
        let color2: UIColor = IDQConstants.highlightedDarkOrange
        translatesAutoresizingMaskIntoConstraints = false
        contentView.translatesAutoresizingMaskIntoConstraints = false
        layer.cornerRadius = 16
        backgroundColor = IDQConstants.contentBackgroundColor
        clipsToBounds = true
    }
    
    private func setupConstraints() {
        addSubviews(answerTextView, answerImageView)
        NSLayoutConstraint.activate([
            answerImageView.topAnchor.constraint(equalTo: topAnchor, constant: 16),
            answerImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            answerImageView.widthAnchor.constraint(equalToConstant: 24),
            answerImageView.heightAnchor.constraint(equalToConstant: 24),
            
            answerTextView.topAnchor.constraint(equalTo: topAnchor, constant: 12),
            answerTextView.leadingAnchor.constraint(equalTo: answerImageView.trailingAnchor, constant: 12),
            answerTextView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -12),
            answerTextView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -16),
        ])
    }
    
    private func setupAnswerIcon(_ imageView: UIImageView, answerSerial: Int) {
        var icon: UIImage?
        switch answerSerial {
        case 0:
            icon = UIImage(systemName: "circle.fill")?.withTintColor(tintColor, renderingMode: .alwaysTemplate)
        case 1:
            icon = UIImage(systemName: "square.fill")?.withTintColor(tintColor, renderingMode: .alwaysTemplate)
        case 2:
            icon = UIImage(systemName: "triangle.fill")?.withTintColor(tintColor, renderingMode: .alwaysTemplate)
        case 3:
            icon = UIImage(systemName: "diamond.fill")?.withTintColor(tintColor, renderingMode: .alwaysTemplate)
        default:
            icon = UIImage(systemName: "triangle.fill")?.withTintColor(tintColor, renderingMode: .alwaysTemplate)
        }
        imageView.image = icon
        imageView.tintColor = IDQConstants.backgroundColor
    }
    
    
    //MARK: - Public
    
    public func configure(with answer: IDQAnswer, serial: Int) {
        guard !answer.text.isEmpty else { return }
        answerTextView.text = answer.text
        answerTextView.configureFor(IDQConstants.keywords, fontSize: 14.0, keywordcolor: IDQConstants.highlightedDarkOrange)
        if serial >= 0 && serial < 4 {
            setupAnswerIcon(answerImageView, answerSerial: serial)
        } else {
            answerImageView.image = UIImage(systemName: "circle.fill")!
        }
    }
    
    public func didSelect(answer: IDQAnswer) -> Bool {
        guard answer.answerType != nil else {
            fatalError("Error at IDQGameAnswerCollectionViewCell - didSelect\nSelected answer does not have isCorrect value")
        }
        if answer.answerType == .correct {
            return true
        } else {
            return false
        }
    }
    
}
