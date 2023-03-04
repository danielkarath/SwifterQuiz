//
//  ViewController.swift
//  iOSDevQuiz
//
//  Created by Daniel Karath on 3/2/23.
//

import UIKit

final class IDQTabBarController: UITabBarController {
    private var fullBlurView: UIVisualEffectView = {
        let view = UIVisualEffectView(effect: UIBlurEffect(style: .automatic))
        view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        view.clipsToBounds = true
        return view
    }()
        
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTabs()
    }
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        fullBlurView.effect = nil
        fullBlurView.effect = UIBlurEffect(style: .automatic)
    }

    private func setupTabs() {
        tabBar.backgroundColor = IDQConstants.contentBackgroundColor.withAlphaComponent(0.20)
        tabBar.addSubview(fullBlurView)
        fullBlurView.frame = tabBar.bounds
        let viewControllers: [UIViewController] = [IDQStatsViewController(), IDQPlayViewController(), IDQSettingsViewController()]
        let menuIcons: [UIImage] = [UIImage(systemName: "chart.xyaxis.line")!, UIImage(systemName: "swift")!, UIImage(systemName: "gearshape.fill")!]
        let titles: [String] = ["Stats", "Quiz", "Settings"]
        var navControllers: [UINavigationController] = []
        var i: Int = 0
        var j: Int = 0
        
        for viewController in viewControllers {
            viewController.navigationItem.largeTitleDisplayMode = .automatic
            navControllers.append(UINavigationController(rootViewController: viewControllers[i]))
            i = i + 1
        }
        for navController in navControllers {
            navController.navigationBar.prefersLargeTitles = true
            navController.navigationBar.titleTextAttributes = [.foregroundColor: IDQConstants.brandingColor]
            navController.navigationBar.largeTitleTextAttributes = [.foregroundColor: IDQConstants.brandingColor]
            navController.navigationBar.backgroundColor = IDQConstants.backgroundColor.withAlphaComponent(0.0)
            tabBar.tintColor = IDQConstants.brandingColor
            tabBar.layer.cornerRadius = tabBar.layer.frame.height/2
            tabBar.layer.masksToBounds = true
            navController.tabBarItem = UITabBarItem(
                title: titles[j],
                image: menuIcons[j],
                tag: j
            )
            j = j + 1
        }
        setViewControllers(navControllers, animated: true)
    }
    
}

