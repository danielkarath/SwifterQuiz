//
//  IDQDisableQuestionView.swift
//  iOSDevQuiz
//
//  Created by Daniel Karath on 4/17/23.
//

import UIKit

protocol IDQDisableQuestionViewDelegate: AnyObject {
    func didDismiss(_ disableQuestionView: IDQDisableQuestionView)
    func didTapDisable(_ disableQuestionView: IDQDisableQuestionView)
    func didTapReport(_ disableQuestionView: IDQDisableQuestionView)
}


class IDQDisableQuestionView: UIView {
    
    public weak var delegate: IDQDisableQuestionViewDelegate?
    
    private var question: IDQQuestion?
    
    private let disableImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.layer.cornerRadius = 4
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFit
        imageView.tintColor = IDQConstants.basicFontColor
        imageView.image = UIImage(systemName: "nosign")?.withTintColor(IDQConstants.basicFontColor, renderingMode: .alwaysTemplate)
        return imageView
    }()
    
    private let disableTitleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Disable Question"
        label.numberOfLines = 1
        label.textAlignment = .center
        label.font = IDQConstants.setFont(fontSize: 20, isBold: true)
        label.textColor = IDQConstants.basicFontColor
        return label
    }()
    
    private let disableExplanationLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = ""
        label.numberOfLines = 0
        label.textAlignment = .left
        label.font = IDQConstants.setFont(fontSize: 12, isBold: false)
        label.textColor = IDQConstants.secondaryFontColor
        return label
    }()
    
    private let disableButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.frame.size = CGSize(width: 128, height: 30) //.size = CGSize(width: width, height: height)
        button.layer.cornerRadius = 4
        button.setTitleColor(IDQConstants.whiteColor, for: .normal)
        button.backgroundColor = IDQConstants.errorColor
        button.titleLabel?.font = IDQConstants.setFont(fontSize: 14, isBold: true)
        button.setTitle("DISABLE", for: .normal)
        button.setTitle("DISABLE", for: .highlighted)
        button.isUserInteractionEnabled = true
        return button
    }()
    
    private let reportButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.frame.size = CGSize(width: 30, height: 30)
        button.clipsToBounds = true
        button.setTitle("", for: .normal)
        button.isUserInteractionEnabled = true
        return button
    }()

    private let closeButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.frame.size = CGSize(width: 16, height: 16)
        button.clipsToBounds = true
        button.setTitle("", for: .normal)
        button.isUserInteractionEnabled = true
        //button.setImage(UIImage(systemName: "xmark"), for: .normal)
        return button
    }()
    
    let envelopeImageView = UIImageView(image: UIImage(systemName: "envelope"))
    let xMarkImageView = UIImageView(image: UIImage(systemName: "xmark"))

    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("Unsupported")
    }
    
    
    //MARK: - Private
    
    private func setupView() {
        translatesAutoresizingMaskIntoConstraints = false
        self.layer.frame = CGRect(x: 0, y: 0, width: 260, height: 350)
        backgroundColor = IDQConstants.contentBackgroundColor
        layer.cornerRadius = 16
        
        setup(closeButton, with: xMarkImageView, tintColor: IDQConstants.basicFontColor)
        setup(reportButton, with: envelopeImageView, tintColor: IDQConstants.basicFontColor)
        disableExplanationLabel.text = "By tapping disable you confirm to disable the question. Disabled questions will no longer be asked again unless you undo this action in the Quiz Settings menu.\n\nAlternatively you can report the question by tapping the envelop button. This action does not disable the question."
        
        disableButton.addTarget(self, action: #selector(disableButtonTapped(_:)), for: .touchUpInside)
        reportButton.addTarget(self, action: #selector(reportButtonTapped(_:)), for: .touchUpInside)
        closeButton.addTarget(self, action: #selector(closeButtonTapped(_:)), for: .touchUpInside)
    }
    
    private func setupConstraints() {
        addSubviews(disableTitleLabel, disableExplanationLabel, disableImageView, closeButton, disableButton, reportButton)
        NSLayoutConstraint.activate([
            closeButton.topAnchor.constraint(equalTo: topAnchor, constant: 16),
            closeButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -12),
            closeButton.heightAnchor.constraint(equalToConstant: 24),
            closeButton.widthAnchor.constraint(equalToConstant: 24),

            disableImageView.topAnchor.constraint(equalTo: topAnchor, constant: 16),
            disableImageView.widthAnchor.constraint(equalToConstant: 60),
            disableImageView.heightAnchor.constraint(equalToConstant: 60),
            disableImageView.centerXAnchor.constraint(equalTo: centerXAnchor, constant: 0),
            
            disableTitleLabel.topAnchor.constraint(equalTo: disableImageView.bottomAnchor, constant: 12),
            disableTitleLabel.centerXAnchor.constraint(equalTo: centerXAnchor, constant: 0),
            disableTitleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 0),
            disableTitleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 0),
            disableTitleLabel.heightAnchor.constraint(equalToConstant: 30),
            
            disableExplanationLabel.topAnchor.constraint(equalTo: disableTitleLabel.bottomAnchor, constant: -12),
            disableExplanationLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            disableExplanationLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
            disableExplanationLabel.bottomAnchor.constraint(equalTo: disableButton.topAnchor, constant: -8),
            
            reportButton.heightAnchor.constraint(equalToConstant: 30),
            reportButton.widthAnchor.constraint(equalToConstant: 30),
            reportButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            reportButton.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -8),
            
            disableButton.heightAnchor.constraint(equalToConstant: 30),
            disableButton.leadingAnchor.constraint(equalTo: reportButton.trailingAnchor, constant: 16),
            disableButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            disableButton.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -8),
        ])
    }
    
    private func setup(_ button: UIButton, with imageView: UIImageView, tintColor: UIColor) {
        imageView.tintColor = tintColor
        imageView.frame = CGRect(x: button.layer.frame.minX, y: button.layer.frame.minY, width: button.layer.frame.size.width, height: button.layer.frame.size.height)
        imageView.contentMode = .scaleAspectFit
        button.addSubview(imageView)
    }
    
    @objc
    private func disableButtonTapped(_ sender: UIButton) {
        delegate?.didTapDisable(self)
    }
    
    @objc
    private func reportButtonTapped(_ sender: UIButton) {
        delegate?.didTapReport(self)
    }
    
    @objc
    private func closeButtonTapped(_ sender: UIButton) {
        delegate?.didDismiss(self)
    }
}
