//
//  IDQStatsViewController.swift
//  iOSDevQuiz
//
//  Created by Daniel Karath on 3/2/23.
//
import UIKit

/// Controller to show and serach for characters
final class IDQStatsViewController: UIViewController {

    //private let characterListView = RMCharacterListView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = IDQConstants.backgroundColor
        //setupConstraints()
    }
    
    
//    private func setupConstraints() {
//        view.addSubview(characterListView)
//        NSLayoutConstraint.activate([
//            characterListView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: -16),
//            characterListView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor, constant: 0),
//            characterListView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor, constant: 0),
//            characterListView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: 32),
//        ])
//        characterListView.delegate = self
//    }

}
