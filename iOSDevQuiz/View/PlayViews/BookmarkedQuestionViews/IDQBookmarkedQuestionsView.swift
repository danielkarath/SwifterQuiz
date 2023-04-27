//
//  IDQBookmarkedQuestionsView.swift
//  iOSDevQuiz
//
//  Created by Daniel Karath on 4/21/23.
//

import UIKit
import SafariServices

class IDQBookmarkedQuestionsView: UIView {
        
    private let questionManager = IDQQuestionManager()
    
    private let userManager = IDQUserManager()
    
    private var user: IDQUser?
    
    private var questions: [IDQQuestion]? {
        didSet {
            self.bookmarkedQuestionsTableView?.reloadData()
        }
    }
    
    private var bookmarkedQuestionsTableView: UITableView?
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = IDQConstants.highlightedDarkOrange
        label.text = "Bookmarks"
        label.numberOfLines = 1
        label.contentMode = .center
        label.textAlignment = .center
        label.font = IDQConstants.setFont(fontSize: 20, isBold: false)
        label.isAccessibilityElement = true
        return label
    }()
    
    //MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
        let tableView = createCollectionView()
        self.bookmarkedQuestionsTableView = tableView
        addSubviews(tableView, titleLabel)
        setupConstraints()
        setupCollectionView(tableView)
    }
    
    required init?(coder: NSCoder) {
        fatalError("Unsupported")
    }
    
    
    //MARK: - Private
    
    private func setupView() {
        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = IDQConstants.backgroundColor
        DispatchQueue.global(qos: .userInteractive).async {
            self.user = self.userManager.fetchUser()
        }
    }
    
    private func createCollectionView() -> UITableView {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.backgroundColor = UIColor.clear.withAlphaComponent(0.0)
        tableView.isHidden = true
        tableView.alpha = 0.0
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(IDQBookmarkedQuestionTableViewCell.self, forCellReuseIdentifier: IDQBookmarkedQuestionTableViewCell.cellidentifier)
        //tableView.register(IDQBookmarkedQuestionTableViewCell.self, withReuseIdentifier: IDQBookmarkedQuestionTableViewCell.cellidentifier)
        return tableView
    }
    
    private func setupCollectionView(_ tableView: UITableView) {
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    private func setupConstraints() {
        guard let tableView = bookmarkedQuestionsTableView else {
            return
        }
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: -16),
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            titleLabel.heightAnchor.constraint(equalToConstant: 30),
            
            tableView.topAnchor.constraint(equalTo: topAnchor, constant: 24),
            tableView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 24),
            tableView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -24),
            tableView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -32),
        ])
    }
    
    //MARK: - Public
    public func configure(with questions: [IDQQuestion]) {
        guard !questions.isEmpty else {
            fatalError("Wrong configuration at IDQBookmarkedQuestionView configure")
        }
        self.bookmarkedQuestionsTableView?.alpha = 1.0
        self.bookmarkedQuestionsTableView?.isHidden = false
        self.questions = questions
    }

}

extension IDQBookmarkedQuestionsView: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return questions?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: IDQBookmarkedQuestionTableViewCell.cellidentifier, for: indexPath) as? IDQBookmarkedQuestionTableViewCell else {
            fatalError("Unsupported cell")
        }
        guard let questions = self.questions else {
            fatalError("Unsupported cell")
        }
        guard questions.count > indexPath.row else {
            fatalError("Unsupported cell")
        }
        let bookmarkedQuestion = questions[indexPath.row]
        cell.configure(with: bookmarkedQuestion)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 140
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let trash = UIContextualAction(style: .destructive,
                                       title: "Delete") { [weak self] (action, view, completionHandler) in
            guard let questions = self?.questions else {return}
            guard questions.count > indexPath.row else {return}
            guard self?.user != nil else {return}
            let question = questions[indexPath.row]
            self?.questions?.remove(at: indexPath.row)
            self?.questionManager.removeBookmark(question, for: (self?.user)!)
            completionHandler(true)
        }
        trash.backgroundColor = IDQConstants.errorColor
        let configuration = UISwipeActionsConfiguration(actions: [trash])
        return configuration
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        guard let questions = self.questions else {return}
        guard questions.count > indexPath.row else {return}
        if questions[indexPath.row].referenceURLString != nil {
            let urlString = questions[indexPath.row].referenceURLString
            guard let referenceUrl = URL(string: urlString!), IDQConstants.allowedDomainStrings.contains(referenceUrl.host ?? "") else {
                print("The website is not allowed")
                return
            }
            
            let safariViewController = SFSafariViewController(url: referenceUrl)
            safariViewController.modalPresentationStyle = .popover
            if let viewController = self.getViewController() {
                viewController.present(safariViewController, animated: true, completion: nil)
            }
        }
    }
}
