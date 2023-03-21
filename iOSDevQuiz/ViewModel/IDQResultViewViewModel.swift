//
//  IDQResultViewViewModel.swift
//  iOSDevQuiz
//
//  Created by Daniel Karath on 3/21/23.
//
import UIKit


/*


protocol IDQResultViewViewModelDelegate: AnyObject {
    func didLoadInitialQuestions()
    func didLoadMoreCharacters(with newIndexPaths: [IndexPath])
    func didSelectQuestion(_ question: IDQQuestion)
}


/// IDQResultViewViewModel View Model handles question list view logic.
final class IDQResultViewViewModel: NSObject {
    
    public weak var delegate: IDQResultViewViewModelDelegate?
    
    /// isLoadingMoreCharacters var is used as a guard against mutiple calls of fetchAdditionalQuestions() by scrolling down.
    private var isLoadingMoreQuestions: Bool = false
    
    /// Array of IDQQuestion fetched by fetchQuestions method. Whenever a character is fetched it's added to the cellViewModels (array of IDQQuestionCollectionViewCellViewModel) that is used to populate the cells with data.
    private var questionTuples: [IDQQuestion] = [] {
        didSet {
            for question in questionTuples {
                let viewModel = IDQCharacterQuestionCollectionViewCellViewModel(
                    episodeDataURL: URL(string: question.url)
                )
                if !cellViewModels.contains(viewModel) {
                    cellViewModels.append(viewModel)
                }
            }
        }
    }
    
    /// Array of IDQQuestionCollectionViewCellViewModel to populate the IDQQuestionCollectionViewCell cells with data
    private var cellViewModels: [IDQCharacterQuestionCollectionViewCellViewModel] = []
    
    private var apiInfo: IDQGetAllQuestionsResponse.Info? = nil
    
    /// The fetchCharacter method calls the execute API method in IDQService that utilizes the Rick and Morthy API to fetch the initial 20 questionTuples.
    public func fetchQuestions() {
        IDQService.shared.execute(
            .listQuestionsRequests,
            expecting: IDQGetAllQuestionsResponse.self
        ) { [weak self] result in
            switch result {
            case .success(let responseModel):
                let results = responseModel.results
                let info = responseModel.info
                self?.apiInfo = info
                self?.questionTuples = results
                DispatchQueue.main.async {
                    self?.delegate?.didLoadInitialQuestions()
                }
            case .failure(let error):
                print(String(describing: error))
            }
        }
    }
    
    /// Paginates if additional questionTuples are needed
    public func fetchAdditionalQuestions(url: URL) {
        guard !isLoadingMoreQuestions else {
            return
        }
        isLoadingMoreQuestions = true
        guard let request = IDQRequest(url: url) else {
            isLoadingMoreQuestions = false
            print("Failled to create request")
            return
        }
        
        IDQService.shared.execute(
            request,
            expecting: IDQGetAllQuestionsResponse.self) { [weak self] result in
                guard let strongSelf = self else {
                    return
                }
                switch result {
                case .success(let responseModel):
                    let moreResults = responseModel.results
                    let info = responseModel.info
                    strongSelf.apiInfo = info
                    let originalCount = strongSelf.questionTuples.count
                    let newCount = moreResults.count
                    let total = originalCount + newCount
                    let startingIndex = total - newCount
                    let indexPathsToAdd: [IndexPath] = Array(startingIndex..<(startingIndex + newCount)).compactMap({
                        return IndexPath(row: $0, section: 0)
                    })
                    strongSelf.questionTuples.append(contentsOf: moreResults)
                    DispatchQueue.main.async {
                        strongSelf.delegate?.didLoadMoreCharacters(
                            with: indexPathsToAdd
                        )
                        strongSelf.isLoadingMoreQuestions = false
                    }
                case .failure(let failure):
                    print(String(describing: failure))
                    strongSelf.isLoadingMoreQuestions = false
                }
            }
    }
    
    public var shouldShowLoadIndicator: Bool {
        return apiInfo?.next != nil
    }
    
    
}

//MARK: CollectionView implementations

extension IDQResultViewViewModel: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return cellViewModels.count ?? 50
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: IDQCharacterQuestionCollectionViewCell.cellIdentifier, for: indexPath) as? IDQCharacterQuestionCollectionViewCell else {
            fatalError("Unsupported cell")
        }

        let viewModel = cellViewModels[indexPath.row]
        cell.configure(with: viewModel)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        guard kind == UICollectionView.elementKindSectionFooter,
              let footer = collectionView.dequeueReusableSupplementaryView(
                ofKind: kind,
                withReuseIdentifier: IDQFooterLoadingCollectionReusableView.identifier,
                for: indexPath
              ) as? IDQFooterLoadingCollectionReusableView else {
            fatalError("Unsupported kind")
        }
        footer.startAnimating()
        return footer
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
        guard shouldShowLoadIndicator else {
            return .zero
        }
        return CGSize(width: collectionView.frame.width, height: 100)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let screenBounds = UIScreen.main.bounds
        let width = (screenBounds.width-32)
        return CGSize(width: width, height: width * 0.40)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        let selectedQuestion = questionTuples[indexPath.row]
        delegate?.didSelectQuestion(selectedQuestion)
    }
    
}

//MARK: ScrollView implementation

extension IDQResultViewViewModel: UIScrollViewDelegate {
    
    /// When there are additional characters available, the activityIndicator will appear once while loading them once scrolled down.
    /// - Parameter scrollView: The collectionViews scrollview
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        guard shouldShowLoadIndicator,
              !isLoadingMoreQuestions,
              !cellViewModels.isEmpty,
              let nextURLString = apiInfo?.next,
              let url = URL(string: nextURLString)
        else {
            return
        }
        
        Timer.scheduledTimer(withTimeInterval: 0.2, repeats: false) { [weak self] timer in
            let offset = scrollView.contentOffset.y
            let totalContentHeight = scrollView.contentSize.height
            let totalScrollViewFixedHeight = scrollView.frame.size.height
            
            if offset >= (totalContentHeight - totalScrollViewFixedHeight - 120) {
                self?.fetchAdditionalQuestions(url: url)
            }
            timer.invalidate()
        }
    }
}


*/
