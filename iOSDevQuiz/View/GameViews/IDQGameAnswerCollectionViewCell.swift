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
        imageView.backgroundColor = IDQConstants.backgroundColor.withAlphaComponent(0.25)
        //imageView.image = UIImage(systemName: "triangle.fill") //triangle.fill diamond.fill circle.fill square.fill
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let answerLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = IDQConstants.basicFontColor
        label.numberOfLines = 0
        label.contentMode = .topLeft
        label.font = IDQConstants.setFont(fontSize: 15, isBold: false)
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
    
//    override func prepareForReuse() {
//        super.prepareForReuse()
//        answerLabel.text = nil
//    }
    
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
        addSubviews(answerLabel, answerImageView)
        NSLayoutConstraint.activate([
            answerImageView.topAnchor.constraint(equalTo: topAnchor, constant: 16),
            answerImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            answerImageView.widthAnchor.constraint(equalToConstant: 24),
            answerImageView.heightAnchor.constraint(equalToConstant: 24),
            
            answerLabel.topAnchor.constraint(equalTo: topAnchor, constant: 16),
            answerLabel.leadingAnchor.constraint(equalTo: answerImageView.trailingAnchor, constant: 16),
            answerLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -32),
            //answerLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -16),
        ])
    }
    
    private func setupAnswerIcon(_ imageView: UIImageView, answerSerial: Int) {
        var icon: UIImage?
        var tintColor: UIColor = IDQConstants.darkOrange
        switch answerSerial {
        case 0:
            tintColor = IDQConstants.highlightedLightOrange.withAlphaComponent(0.90)
            icon = UIImage(systemName: "circle.fill")?.withTintColor(tintColor, renderingMode: .alwaysTemplate)
        case 1:
            tintColor = IDQConstants.lightOrange.withAlphaComponent(0.90)
            icon = UIImage(systemName: "square.fill")?.withTintColor(tintColor, renderingMode: .alwaysTemplate)
        case 2:
            tintColor = IDQConstants.highlightedDarkOrange.withAlphaComponent(0.90)
            icon = UIImage(systemName: "triangle.fill")?.withTintColor(tintColor, renderingMode: .alwaysTemplate)
        case 3:
            tintColor = IDQConstants.darkOrange.withAlphaComponent(0.90)
            icon = UIImage(systemName: "diamond.fill")?.withTintColor(tintColor, renderingMode: .alwaysTemplate)
        default:
            tintColor = IDQConstants.darkOrange.withAlphaComponent(0.90)
            icon = UIImage(systemName: "triangle.fill")?.withTintColor(tintColor, renderingMode: .alwaysTemplate)
        }
        imageView.image = icon
        imageView.tintColor = tintColor
    }
    
    
    //MARK: - Public
    
    public func configure(with answer: IDQAnswer, serial: Int) {
        guard !answer.text.isEmpty else { return }
        answerLabel.text = answer.text
        answerLabel.configureFor(IDQConstants.keywords)
        if serial >= 0 && serial < 4 {
            setupAnswerIcon(answerImageView, answerSerial: serial)
        } else {
            answerImageView.image = UIImage(systemName: "circle.fill")!
        }
    }
    
    public func didSelect(answer: IDQAnswer) -> Bool {
        guard answer.isCorrect != nil else {
            fatalError("Error at IDQGameAnswerCollectionViewCell - didSelect\nSelected answer does not have isCorrect value")
        }
        if answer.isCorrect {
            print("The answer is correct")
            answerLabel.text = "Correct"
            return true
        } else {
            print("The answer is NOT correct")
            answerLabel.text = "Incorrect"
            return false
        }
    }
    
}
