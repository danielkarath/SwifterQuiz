//
//  IDQResultViewViewModel.swift
//  iOSDevQuiz
//
//  Created by Daniel Karath on 3/21/23.
//
import UIKit

protocol IDQResultViewViewModelDelegate: AnyObject {
    func didGenerateGame()
}

final class IDQResultViewViewModel {
    
    public weak var delegate: IDQResultViewViewModelDelegate?
    
    //MARK: - Init
    init(
        
    ) {
        
    }
    
    public func setupResults(quiz: IDQQuiz) {
        
    }
    
}
