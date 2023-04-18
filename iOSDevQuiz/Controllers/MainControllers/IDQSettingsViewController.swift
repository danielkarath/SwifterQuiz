//
//  IDQSettingsViewController.swift
//  iOSDevQuiz
//
//  Created by Daniel Karath on 3/2/23.
//

import UIKit
import SwiftUI
import SafariServices
import MessageUI
import StoreKit

/// Controller for various settings and options
final class IDQSettingsViewController: UIViewController {
    
    private var settingsSwiftUIControllerView: UIHostingController<IDQSettingsView>?
    private var userManager = IDQUserManager()
    private var didRateApp = false
    
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
        if let settingsSwiftUIControllerView = settingsSwiftUIControllerView {
            settingsSwiftUIControllerView.view.removeFromSuperview()
            settingsSwiftUIControllerView.removeFromParent()
        }
        
        let settingsSwiftUIVC = UIHostingController(
            rootView:
                IDQSettingsView(
                    viewModel: IDQSettingsViewViewModel(
                        cellViewModels: IDQSettingsOption.allCases.compactMap({
                            return IDQSettingsCellViewModel(type: $0, onTapHandler: { [weak self] option in
                                self?.handleTap(option: option)
                            })
                        })
                    )
                )
        )
        
        let swiftUIView: UIView = settingsSwiftUIVC.view
        addChild(settingsSwiftUIVC)
        settingsSwiftUIVC.didMove(toParent: self)
        view.addSubview(settingsSwiftUIVC.view)
        settingsSwiftUIVC.view.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            swiftUIView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 32),
            swiftUIView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: 0),
            swiftUIView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor, constant: 0),
            swiftUIView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor, constant: 0),
        ])
        
        self.settingsSwiftUIControllerView = settingsSwiftUIVC
    }
    
    private func handleTap(option: IDQSettingsOption) {
        guard Thread.current.isMainThread else { return }
        
        guard let url = option.targetURL else {
            if option == .rateApp {
                didTapRateApp()
            } else if option == .contact {
                showMailComposer()
            } else if option == .about {
                print("Did tap about")
            } else {
                print("Oppsie-poopsie")
            }
            return
        }
        openGitHubLink(url: url)
    }
    
    @objc
    private func openGitHubLink(url: URL) {
        let githubAppURL = url
        
        if UIApplication.shared.canOpenURL(githubAppURL) {
            UIApplication.shared.open(githubAppURL, options: [:], completionHandler: nil)
        } else {
            let safariViewController = SFSafariViewController(url: url)
            safariViewController.modalPresentationStyle = .popover
            present(safariViewController, animated: true)
        }
    }
    
    private func didTapRateApp() {
        guard  let scene = view.window?.windowScene else {
            print("No scene found for Rate window")
            return
        }
        
        if !didRateApp {
            didRateApp = true
            SKStoreReviewController.requestReview(in: scene)
        } else {
            if let url = URL(string: "itms-apps://itunes.apple.com") { ///app/id0000000000  - add your app url to the end here
                UIApplication.shared.open(url)
            }
        }
        
    }
    
    private func showMailComposer() {
        guard MFMailComposeViewController.canSendMail()  else {
            print("Can't send mail")
            return
        }
        var mailMessageText: String = ""
        
        let systemVersion = UIDevice.current.systemVersion
        let appName: String = Bundle.main.appName!.addWhitespaceBeforeCapitalLetters()
        
        mailMessageText = "------------------------------------------\nOS version: \(systemVersion)\napp version: \(Bundle.main.appVersion ?? "1.0")\n------------------------------------------\nPlease don't delete or modify the above information.\n\n"
        
        let composer = MFMailComposeViewController()
        composer.mailComposeDelegate = self
        composer.setToRecipients(["hello@danielkarath.com"])
        composer.setSubject("\(appName) app feedback")
        composer.setMessageBody(mailMessageText, isHTML: false)
        present(composer, animated: true)
    }
    
}

