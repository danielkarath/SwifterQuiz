//
//  ViewController.swift
//  iOSDevQuiz
//
//  Created by Daniel Karath on 3/2/23.
//

import UIKit

final class IDQTabBarController: UITabBarController {
    
    private let userManager = IDQUserManager()
    private let resultManager = IDQQuizResultManager()
//    private let viewModel = IDQResultViewViewModel()
    
    private var fullBlurView: UIVisualEffectView = {
        let view = UIVisualEffectView(effect: UIBlurEffect(style: .automatic))
        view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        view.clipsToBounds = true
        return view
    }()
        
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.hidesBackButton = true
        setupTabs()
        automaticallyGenerateUser()
        evaulateUserMetrics()
//        addDummyData(daysAgo: -8, score: 4)
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
        let viewControllers: [UIViewController] = [IDQPlayViewController(), IDQStatsViewController(), IDQSettingsViewController()]
        let menuIcons: [UIImage] = [UIImage(systemName: "list.bullet.clipboard.fill")!, UIImage(systemName: "chart.xyaxis.line")!, UIImage(systemName: "gearshape.fill")!]
        let titles: [String] = ["Quiz", "Stats", "Settings"]
        var navControllers: [UINavigationController] = []
        var i: Int = 0
        var j: Int = 0
        
        for viewController in viewControllers {
            viewController.navigationItem.largeTitleDisplayMode = .automatic
            navControllers.append(UINavigationController(rootViewController: viewControllers[i]))
            i = i + 1
        }
        
        for navController in navControllers {
            navController.navigationBar.prefersLargeTitles = false
            navController.navigationItem.largeTitleDisplayMode = .never
            navController.navigationBar.titleTextAttributes = [.foregroundColor: IDQConstants.highlightedDarkOrange]
            navController.navigationBar.largeTitleTextAttributes = [.foregroundColor: IDQConstants.highlightedDarkOrange]
            navController.navigationBar.backgroundColor = IDQConstants.backgroundColor.withAlphaComponent(0.0)
            navController.navigationBar.tintColor = IDQConstants.highlightedDarkOrange
            tabBar.tintColor = IDQConstants.highlightedDarkOrange
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
    
    private func automaticallyGenerateUser() {
        DispatchQueue.global(qos: .utility).async {
            self.userManager.createUser(name: "User")
        }
    }
    
    private func evaulateUserMetrics() {
        let calendar = Calendar.current
        let yesterdayDate = calendar.date(byAdding: .day, value: -1, to: Date.currentTime)!
        let serialQueue = DispatchQueue(label: "evaulateUserMetrics.serial.queue")
        var didPlayYesterday: Bool?
        
        serialQueue.async {
            didPlayYesterday = self.resultManager.didPlay(on: yesterdayDate)
        }
        serialQueue.async {
            guard didPlayYesterday != nil else {return}
            self.userManager.evaulateStreak(didPlayYesterday: didPlayYesterday!)
        }
    }
//    
//    private func addDummyData(daysAgo: TimeInterval, score: Int) {
//        
//        let quiz: IDQQuiz = IDQQuiz(gamestyle: .init(
//            gameName: "Dummy",
//            type: .basic,
//            questionTimer: .gazelle,
//            topics: [.basics],
//            numberOfQuestions: 10
//        ), questions: [
//            (question: fullQuestionList[0], answerType: .correct),
//            (question: fullQuestionList[1], answerType: .correct),
//            (question: fullQuestionList[2], answerType: .correct),
//            (question: fullQuestionList[3], answerType: .correct),
//            (question: fullQuestionList[4], answerType: .correct),
//            (question: fullQuestionList[5], answerType: .correct),
//            (question: fullQuestionList[6], answerType: .correct),
//            (question: fullQuestionList[7], answerType: .correct),
//            (question: fullQuestionList[8], answerType: .correct),
//            (question: fullQuestionList[9], answerType: .correct)
//        ], totalScore: score, quizDuration: 158, date: Date.currentTime.addingTimeInterval(3600 * 24 * daysAgo))
//        
//        let serialQueue = DispatchQueue(label: "saveMetrics.serial.queue")
//
//        serialQueue.async {
//            self.viewModel.evaulateStreak()
//            self.viewModel.save(quiz: quiz)
//        }
//        serialQueue.async {
//            self.viewModel.saveToDaytimeActivity(quiz)
//            self.viewModel.saveToUserRecords(quiz)
//        }
//        
//    }
}
