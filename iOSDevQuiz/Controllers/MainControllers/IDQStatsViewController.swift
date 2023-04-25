//
//  IDQStatsViewController.swift
//  iOSDevQuiz
//
//  Created by Daniel Karath on 3/2/23.
//
import UIKit
import SwiftUI

final class IDQStatsViewController: UIViewController {
    
    private var statsSwiftUIControllerView: UIHostingController<IDQStatsView>?
    private var userManager = IDQUserManager()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
        updateSwiftUIController()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = IDQConstants.backgroundColor
        addSwiftUIController()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
    private func addSwiftUIController() {
        updateSwiftUIController()
    }
    
    private func updateSwiftUIController() {
        if let statsSwiftUIControllerView = statsSwiftUIControllerView {
            statsSwiftUIControllerView.view.removeFromSuperview()
            statsSwiftUIControllerView.removeFromParent()
        }
        
        guard let user = userManager.fetchUser() else { return }
        
        let timeSpent: Double = user.totalPlayTime
        
        let totalScore: Double = Double(user.totalScore ?? 0)
        let totalPerformance: Double = (user.performance ?? 0)
        let gamesPlayed: Double = Double(user.numberOfQuizesPlayed ?? 0)
        let streak: Double = Double(user.streak ?? 0)
        
        let statsSwiftUIVC = UIHostingController(
            rootView:
                IDQStatsView(
                    totalScore: totalScore,
                    totalPerformance: totalPerformance,
                    quizesPlayed: gamesPlayed,
                    timeSpent: timeSpent,
                    streak: streak
                )
        )
        
        let swiftUIView: UIView = statsSwiftUIVC.view
        addChild(statsSwiftUIVC)
        statsSwiftUIVC.didMove(toParent: self)
        view.addSubview(statsSwiftUIVC.view)
        statsSwiftUIVC.view.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            swiftUIView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 0),
            swiftUIView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: 0),
            swiftUIView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor, constant: 0),
            swiftUIView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor, constant: 0),
        ])
        
        self.statsSwiftUIControllerView = statsSwiftUIVC
    }
}
