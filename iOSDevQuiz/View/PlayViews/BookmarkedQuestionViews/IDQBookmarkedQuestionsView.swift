//
//  IDQBookmarkedQuestionsView.swift
//  iOSDevQuiz
//
//  Created by Daniel Karath on 4/21/23.
//

import UIKit

class IDQBookmarkedQuestionsView: UIView {

    private var bookmarkedQuestionsCollectionView: UICollectionView?
        
    private var questions: [IDQQuestion]? {
        didSet {
            self.bookmarkedQuestionsCollectionView?.reloadData()
        }
    }
    
    //MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
        let collectionView = createCollectionView()
        self.bookmarkedQuestionsCollectionView = collectionView
        addSubview(collectionView)
        setupConstraints()
        setupCollectionView(collectionView)
    }
    
    required init?(coder: NSCoder) {
        fatalError("Unsupported")
    }
    
    
    //MARK: - Private
    
    private func setupView() {
        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = IDQConstants.backgroundColor
    }
    
    private func createCollectionView() -> UICollectionView {
        let layout = UICollectionViewCompositionalLayout { section, _ in
            return self.layout(for: section)
        }
        let collectionView = UICollectionView(
            frame: .zero,
            collectionViewLayout: layout
        )
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = .clear.withAlphaComponent(0.0)
        collectionView.isHidden = true
        collectionView.alpha = 0.0
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(IDQBookmarkedQuestionCollectionViewCell.self, forCellWithReuseIdentifier: IDQBookmarkedQuestionCollectionViewCell.cellidentifier)
        return collectionView
    }
    
    private func setupCollectionView(_ collectionView: UICollectionView) {
        collectionView.delegate = self
        collectionView.dataSource = self
    }
    
    private func setupConstraints() {
        guard let collectionView = bookmarkedQuestionsCollectionView else {
            return
        }
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: topAnchor, constant: 18),
            collectionView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 24),
            collectionView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -24),
            collectionView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -32),
        ])
    }
    
    //MARK: - Public
    public func configure(with questions: [IDQQuestion]) {
        guard !questions.isEmpty else {
            fatalError("Wrong configuration at IDQBookmarkedQuestionView configure")
        }
        self.bookmarkedQuestionsCollectionView?.alpha = 1.0
        self.bookmarkedQuestionsCollectionView?.isHidden = false
        self.questions = questions
    }

}

extension IDQBookmarkedQuestionsView {
    func layout(for section: Int) -> NSCollectionLayoutSection {
        let item = NSCollectionLayoutItem(layoutSize: .init(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .fractionalHeight(1))
        )
        
        item.contentInsets = NSDirectionalEdgeInsets(
            top: 4,
            leading: 2,
            bottom: 4,
            trailing: 2
        )
        
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: .init(
            widthDimension: .fractionalWidth(1),
            heightDimension: .absolute(120)),
            subitems: [item]
        )
        
        let section = NSCollectionLayoutSection(group: group)
        
        return section
    }
    
}

extension IDQBookmarkedQuestionsView: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return questions?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: IDQBookmarkedQuestionCollectionViewCell.cellidentifier, for: indexPath) as? IDQBookmarkedQuestionCollectionViewCell else {
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
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let screenBounds = UIScreen.main.bounds
        let width = (screenBounds.width-64)
        return CGSize(width: width, height: width * 1.5)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: IDQBookmarkedQuestionCollectionViewCell.cellidentifier, for: indexPath) as? IDQBookmarkedQuestionCollectionViewCell else {
            fatalError("Unsupported cell")
        }
        guard let questions = self.questions else {return}
        guard questions.count > indexPath.row else {return}
        if questions[indexPath.row].reference != nil {
            let urlString = questions[indexPath.row].reference
            print("Goto website:\n\(urlString)")
        }
    }

}
