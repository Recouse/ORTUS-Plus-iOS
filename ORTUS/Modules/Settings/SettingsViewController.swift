//
//  SettingsViewController.swift
//  ORTUS
//
//  Created by Firdavs Khaydarov on 21/03/19.
//  Copyright (c) 2019 Firdavs. All rights reserved.
//

import UIKit
import Carbon
import SafariServices
import MessageUI

class SettingsViewController: ORTUSTableViewController, ModuleViewModel, AlertPresentable {
    enum ID {
        case main, appearance, pinCode, schedule
        case shareFeedback, privacyPolicy, signOut, version
    }

    var viewModel: SettingsViewModel
    
    init(viewModel: SettingsViewModel) {
        self.viewModel = viewModel
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        render()
    }
    
    override func prepareData() {
        super.prepareData()
        
        title = L10n.Settings.title
        
        tableView.refreshControl = nil
        
        renderer.adapter.didSelect = { [unowned self] context in
            guard let id = context.node.id as? ID else {
                return
            }
            
            switch id {
            case .appearance:
                self.viewModel.router.openAppearanceSettings()
            case .pinCode:
                self.viewModel.router.openPinSettings()
            case .schedule:
                self.viewModel.router.openScheduleSettings()
            case .shareFeedback:
                self.shareFeedback()
            case .privacyPolicy:
                self.openUrl(Global.privacyPolicyURL)
            case .signOut:
                self.signOut()
            default:
                break
            }
        }
        
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(authComplete),
            name: .authComplete,
            object: nil)
        
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(authFailed),
            name: .authFailed,
            object: nil)
        
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(signedOut),
            name: .userSignedOut,
            object: nil)
    }
    
    func render() {
        var mainCells = [
            CellNode(FormSection(title: "PIN Code").identified(by: ID.pinCode)),
            CellNode(FormSection(title: "Schedule").identified(by: ID.schedule))
        ]
        
        if  #available(iOS 13.0, *) {
            mainCells.insert(
                CellNode(FormSection(title: "Appearance").identified(by: ID.appearance)),
                at: 0
            )
        }
        
        renderer.render {
            Section(
                id: ID.main,
                header: ViewNode(Header(title: "")),
                cells: mainCells
            )
                        
            Section(
                id: ID.shareFeedback,
                header: Header(title: ""),
                cells: {
                    FormLink(title: "Share Feedback").identified(by: ID.shareFeedback)
                }
            )
            
            Section(
                id: ID.privacyPolicy,
                header: Header(title: ""),
                cells: {
                    FormLink(title: "Privacy Policy").identified(by: ID.privacyPolicy)
                }
            )
            
            Section(
                id: ID.signOut,
                header: Header(title: ""),
                cells: {
                    FormButton(
                        title: "Sign Out",
                        color: .systemRed
                    ).identified(by: ID.signOut)
                }
            )
            
            Section(
                id: ID.version,
                cells: {
                    VersionComponent(
                        version: "\(Bundle.main.versionNumber ?? "") (\(Bundle.main.buildNumber ?? ""))",
                        onSelect: nil
                    )
                }
            )
        }
    }
    
    func addAccount() {
        guard let url = OAuth.buildAuthURL() else { return }
        
        let authController = SFSafariViewController(url: url)
        present(authController, animated: true, completion: nil)
    }
    
    @objc func authComplete() {
        guard let authController = presentedViewController as? SFSafariViewController else {
            return
        }
        
        authController.dismiss(animated: true) { [weak self] in
            guard let self = self else { return }
            
            self.render()
        }
    }
    
    @objc func authFailed() {
        guard let authController = presentedViewController as? SFSafariViewController else {
            return
        }
        
        authController.dismiss(animated: true) { [weak self] in
            guard let self = self else { return }
            
            self.alert(message: "Error on processing. Please try again.")
        }
    }
    
    func shareFeedback() {
        deselectSelectedRow()
        
        guard MFMailComposeViewController.canSendMail() else {
            return
        }
        
        let mailController = MFMailComposeViewController()
        mailController.mailComposeDelegate = self
        mailController.setToRecipients([Global.feedbackEmail])
        
        let body = """
        ORTUS+ for iOS
        Version \(Bundle.main.versionNumber ?? "") (\(Bundle.main.buildNumber ?? "")), \(UIDevice.current.systemName) \(UIDevice.current.systemVersion)
        """
        
        mailController.setMessageBody(body, isHTML: false)

        present(mailController, animated: true)
    }
    
    func openUrl(_ urlString: String) {
        guard let url = URL(string: urlString) else {
            return
        }
        
        UIApplication.shared.open(url, options: [.universalLinksOnly: true]) { [unowned self] success in
            guard !success else {
                self.deselectSelectedRow()
                return
            }
            
            let safariController = SFSafariViewController(url: url)
            self.present(safariController, animated: true, completion: nil)
        }
    }
    
    func signOut() {
        deselectSelectedRow()
        
        let alert = UIAlertController(title: "Are you sure?", message: "You will be signed out from your account. Do you want to sign out?", preferredStyle: .actionSheet)
        alert.addAction(UIAlertAction(title: "Sign out", style: .destructive, handler: { [unowned self] _ in
            Overlay.showLoading(on: self)
            UserViewModel.signOut()
        }))
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        
        present(alert, animated: true, completion: nil)
    }
    
    @objc func signedOut() {
        EventLogger.log(.signedOut)
        
        viewModel.router.openLogin()
    }
}

extension SettingsViewController: MFMailComposeViewControllerDelegate {
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        controller.dismiss(animated: true, completion: nil)
    }
}

