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

class SettingsViewController: ORTUSTableViewController, ModuleViewModel, AlertPresentable {
    enum ID {
        case main, pinCode, schedule, reportBug, privacyPolicy, signOut, version
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
    
    override func prepareLocales() {
        title = "settings.title".localized()
    }
    
    override func prepareData() {
        super.prepareData()
        
        tableView.refreshControl = nil
        
        renderer.adapter.didSelect = { [unowned self] context in
            guard let id = context.node.id as? ID else {
                return
            }
            
            switch id {
            case .pinCode:
                self.viewModel.router.openPinSettings()
            case .schedule:
                self.viewModel.router.openScheduleSettings()
            case .reportBug:
                self.openUrl(Global.githubIssuesURL)
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
        renderer.render {
            Section(
                id: ID.main,
                header: Header(title: ""),
                cells: {
                    FormSection(title: "PIN Code").identified(by: ID.pinCode)
                    
                    FormSection(title: "Schedule").identified(by: ID.schedule)
                }
            )
            
            Section(
                id: ID.reportBug,
                header: Header(title: ""),
                cells: {
                    FormLink(title: "Report a bug").identified(by: ID.reportBug)
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
        alert.addAction(UIAlertAction(title: "Sign out", style: .destructive, handler: { _ in
            UserViewModel.signOut()
        }))
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        
        present(alert, animated: true, completion: nil)
    }
    
    @objc func signedOut() {
        EventLogger.log(.signedOut)
        
        viewModel.router.openLogin()
    }
    
    func deselectSelectedRow() {
        guard let selectedIndexPath = tableView.indexPathForSelectedRow else {
            return
        }
        
        tableView.deselectRow(at: selectedIndexPath, animated: true)
    }
}

