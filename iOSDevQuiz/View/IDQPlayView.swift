//
//  IDQPlayView.swift
//  iOSDevQuiz
//
//  Created by Daniel Karath on 3/2/23.
//

import UIKit

class IDQPlayView: UIView {
    
    private let appIconMiniImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = IDQConstants.appIconMiniature
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "iOS Developer Quiz"
        label.numberOfLines = 1
        label.textAlignment = .center
        label.textColor = IDQConstants.brandingColor
        label.font = IDQConstants.setFont(fontSize: 20, isBold: true)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let subTitle: UILabel = {
        let label = UILabel()
        label.text = "practice with 300+ questions"
        label.numberOfLines = 1
        label.textAlignment = .center
        label.textColor = IDQConstants.secondaryFontColor
        label.font = IDQConstants.setFont(fontSize: 11, isBold: false)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let startGameButton: UIButton = {
        let button = UIButton()
        
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("IDQPlayView is unsupported!")
    }
    
    private func setupView() {
        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = IDQConstants.backgroundColor
    }
    
    private func setupConstraints() {
        addSubviews(appIconMiniImageView, titleLabel, subTitle)
        NSLayoutConstraint.activate([
            appIconMiniImageView.heightAnchor.constraint(equalToConstant: 64),
            appIconMiniImageView.widthAnchor.constraint(equalToConstant: 64),
            appIconMiniImageView.centerXAnchor.constraint(equalTo: centerXAnchor, constant: 0),
            appIconMiniImageView.topAnchor.constraint(equalTo: topAnchor, constant: 16),
            
            subTitle.heightAnchor.constraint(equalToConstant: 18),
            subTitle.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width*0.60),
            subTitle.centerXAnchor.constraint(equalTo: centerXAnchor, constant: 0),
            subTitle.topAnchor.constraint(equalTo: appIconMiniImageView.bottomAnchor, constant: 16),
            
            titleLabel.heightAnchor.constraint(equalToConstant: 26),
            titleLabel.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width*0.80),
            titleLabel.centerXAnchor.constraint(equalTo: centerXAnchor, constant: 0),
            titleLabel.topAnchor.constraint(equalTo: subTitle.bottomAnchor, constant: 0),
        ])
        //playView.delegate = self
    }
    
    
}

//
//  RMEpisodeDetailView.swift
//  RickAndMorty
//
//  Created by Daniel Karath on 2/15/23.
//
/*
 import UIKit
 
 protocol RMEpisodeDetailViewDelegate: AnyObject {
 func rmEpisodeDetailView(
 _ detailView: RMEpisodeDetailView,
 didSelect character: RMCharacter
 )
 }
 
 final class RMEpisodeDetailView: UIView {
 
 public weak var delegate: RMEpisodeDetailViewDelegate?
 
 private var viewModel: RMEpisodeDetailViewViewModel? {
 didSet {
 spinner.stopAnimating()
 self.collectionView?.reloadData()
 self.collectionView?.isHidden = false
 UIView.animate(withDuration: 0.33, delay: 0) {
 self.collectionView?.alpha = 1.0
 }
 }
 }
 
 private var collectionView: UICollectionView?
 
 private let spinner: UIActivityIndicatorView = {
 let spinner = UIActivityIndicatorView(style: .large)
 spinner.hidesWhenStopped = true
 spinner.translatesAutoresizingMaskIntoConstraints = false
 return spinner
 }()
 
 //MARK: - Init
 override init(frame: CGRect) {
 super.init(frame: frame)
 translatesAutoresizingMaskIntoConstraints = false
 backgroundColor = RMConstants.darkBackgroundColor
 let collectionView = createCollectionView()
 addSubviews(collectionView, spinner)
 self.collectionView = collectionView
 addConstraints()
 
 spinner.startAnimating()
 }
 
 required init?(coder: NSCoder) {
 fatalError("Unsupported")
 }
 
 //MARK: - Private
 
 private func addConstraints() {
 guard let collectionView = collectionView else {
 return
 }
 NSLayoutConstraint.activate([
 spinner.heightAnchor.constraint(equalToConstant: 100),
 spinner.widthAnchor.constraint(equalToConstant: 100),
 spinner.centerXAnchor.constraint(equalTo: centerXAnchor, constant: 0),
 spinner.centerYAnchor.constraint(equalTo: centerYAnchor, constant: 0),
 
 collectionView.topAnchor.constraint(equalTo: topAnchor, constant: 0),
 collectionView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 0),
 collectionView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 0),
 collectionView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 0),
 ])
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
 collectionView.isHidden = true
 collectionView.alpha = 0.0
 collectionView.delegate = self
 collectionView.dataSource = self
 collectionView.register(RMEpisodeInfoCollectionViewCell.self, forCellWithReuseIdentifier: RMEpisodeInfoCollectionViewCell.cellIdentifier)
 collectionView.register(RMCharacterMiniatureCollectionViewCell .self, forCellWithReuseIdentifier: RMCharacterMiniatureCollectionViewCell.cellIdentifier)
 return collectionView
 }
 
 //MARK: - Public
 
 public func configure(with viewModel: RMEpisodeDetailViewViewModel) {
 self.viewModel = viewModel
 }
 
 }
 
 //MARK: - extensions
 
 extension RMEpisodeDetailView {
 func layout(for section: Int) -> NSCollectionLayoutSection {
 guard let sections = viewModel?.cellViewModels else {
 return createEpisodeInfoLayout()
 }
 
 switch sections[section] {
 case .information:
 return createEpisodeInfoLayout()
 case .characters:
 return createEpisodeCharacterLayout()
 default:
 return createEpisodeInfoLayout()
 }
 }
 
 public func createEpisodeInfoLayout() -> NSCollectionLayoutSection  {
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
 heightDimension: .absolute(40)),
 subitems: [item]
 )
 
 let section = NSCollectionLayoutSection(group: group)
 
 return section
 }
 
 public func createEpisodeCharacterLayout() -> NSCollectionLayoutSection  {
 let item = NSCollectionLayoutItem(layoutSize: .init(
 widthDimension: .fractionalWidth(0.25),
 heightDimension: .fractionalHeight(1))
 )
 
 item.contentInsets = NSDirectionalEdgeInsets(
 top: 2,
 leading: 2,
 bottom: 2,
 trailing: 2
 )
 
 let group = NSCollectionLayoutGroup.horizontal(layoutSize: .init(
 widthDimension: .fractionalWidth(1),
 heightDimension: .absolute(150)),
 subitems: [item]
 )
 
 let section = NSCollectionLayoutSection(group: group)
 
 return section
 }
 
 }
 
 extension RMEpisodeDetailView: UICollectionViewDelegate, UICollectionViewDataSource {
 
 func numberOfSections(in collectionView: UICollectionView) -> Int {
 return viewModel?.cellViewModels.count ?? 0
 }
 
 func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
 guard let sections = viewModel?.cellViewModels else {
 return 0
 }
 
 let sectionType = sections[section]
 
 switch sectionType {
 case .information(let viewModels):
 return viewModels.count
 case .characters(let viewModels):
 return viewModels.count
 default:
 return 0
 }
 }
 
 func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
 guard let sections = viewModel?.cellViewModels else {
 fatalError("No view model found")
 }
 
 let sectionType = sections[indexPath.section]
 
 switch sectionType {
 case .information(let viewModels):
 let cellViewModel = viewModels[indexPath.row]
 guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: RMEpisodeInfoCollectionViewCell.cellIdentifier, for: indexPath) as? RMEpisodeInfoCollectionViewCell else {
 fatalError()
 }
 cell.configure(with: cellViewModel)
 return cell
 case .characters(let viewModels):
 let cellViewModel = viewModels[indexPath.row]
 guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: RMCharacterMiniatureCollectionViewCell.cellIdentifier, for: indexPath) as? RMCharacterMiniatureCollectionViewCell else {
 fatalError()
 }
 cell.configure(with: cellViewModel)
 return cell
 }
 }
 
 func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
 collectionView.deselectItem(at: indexPath, animated: true)
 guard let viewModel = viewModel else {
 return
 }
 let sections = viewModel.cellViewModels
 
 
 let sectionType = sections[indexPath.section]
 
 switch sectionType {
 case .information(let viewModels):
 break
 case .characters:
 guard let character = viewModel.character(at: indexPath.row) else {
 return
 }
 delegate?.rmEpisodeDetailView(self, didSelect: character)
 }
 
 }
 
 }
 */
