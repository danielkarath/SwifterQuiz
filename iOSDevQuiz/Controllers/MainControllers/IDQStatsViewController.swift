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
        
        // Update the SwiftUI view
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
            // Remove the existing SwiftUI view from the view hierarchy
            statsSwiftUIControllerView.view.removeFromSuperview()
            statsSwiftUIControllerView.removeFromParent()
        }
        
        let myUser = userManager.fetchUser()
        let statsSwiftUIVC = UIHostingController(rootView: IDQStatsView(totalScore: Double(myUser?.totalScore ?? 0), totalPerformance: myUser?.performance ?? 0))
        
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
