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

class SettingsViewController: TranslatableModule, ModuleViewModel, AlertPresentable {
    enum ID {
        case pinCode, reportBug, signOut, version
    }

    var viewModel: SettingsViewModel
    
    weak var settingsView: SettingsView! { return view as? SettingsView }
    weak var tableView: UITableView! { return settingsView.tableView }
    
    let renderer = Renderer(
        adapter: UITableViewAdapter(),
        updater: UITableViewUpdater()
    )
    
    init(viewModel: SettingsViewModel) {
        self.viewModel = viewModel
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        view = SettingsView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        prepareData()
        
        render()
    }
    
    override func prepareLocales() {
        title = "settings.title".localized()
    }
    
    func render() {
        renderer.render {
            Section(
                id: ID.pinCode,
                header: Header(title: ""),
                cells: {
                    FormSection(title: "PIN Code", onSelect: { [unowned self] in
                        self.viewModel.router.openPinSettings()
                    })
                    
                    FormSection(title: "Schedule", onSelect: { [unowned self] in
                        self.viewModel.router.openScheduleSettings()
                    })
                }
            )
            
            Section(
                id: ID.reportBug,
                header: Header(title: ""),
                cells: {
                    FormLink(title: "Report a bug", url: Global.telegramChatURL)
                }
            )
            
            Section(
                id: ID.signOut,
                header: Header(title: ""),
                cells: {
                    FormButton(
                        title: "Sign Out",
                        color: .systemRed,
                        onSelect: { [unowned self] in
                            self.signOut()
                        }
                    )
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
    
    func signOut() {
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
}

extension SettingsViewController {
    func prepareData() {
        renderer.target = tableView
        
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
}

