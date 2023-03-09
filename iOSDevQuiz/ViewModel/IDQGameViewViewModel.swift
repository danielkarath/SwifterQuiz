//
//  IDQGameViewModel.swift
//  iOSDevQuiz
//
//  Created by Daniel Karath on 3/8/23.
//

import UIKit

protocol IDQGameViewModelDelegate: AnyObject {
    func didAnswerQuestion()
}

final class IDQGameViewViewModel {
    
    public weak var delegate: IDQGameViewModelDelegate?
    
    //MARK: - Init
    init(
        
    ) {
        
    }
    
    
    
}
