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
        case pinCode, reportBug, signOut
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
//        renderer.render(
//            Section(
//                id: "pin",
//                header: ViewNode(Header(title: "PIN Code".uppercased())),
//                cells: [
//                    CellNode(
//                        FormLabel(title: "PIN Code Settings", onSelect: { [unowned self] in
//                            self.setPinCode()
//                        })
//                    )
//                ]
//            ),
//            Section(
//                id: "other",
//                header: ViewNode(Header(title: "Other".uppercased())),
//                cells: [
//                    CellNode(
//                        FormLabel(title: "Report a bug", onSelect: { [unowned self] in
//                            self.reportBug()
//                        })
//                    )
//                ]
//            ),
//            Section(
//                id: "signout",
//                header: ViewNode(Header(title: "")),
//                cells: [
//                    CellNode(
//                        FormLabel(
//                            title: "Sign Out",
//                            color: .systemRed,
//                            onSelect: { [unowned self] in
//                                self.signOut()
//                            }
//                        )
//                    )
//                ]
//            )
//        )
        renderer.render {
            Section(
                id: "pin",
                header: Header(title: "PIN Code".uppercased()),
                cells: {
                    FormLabel(title: "PIN Code Settings", onSelect: { [unowned self] in
                        self.setPinCode()
                    })
                }
            )
            
            Section(
                id: "other",
                header: Header(title: "Other".uppercased()),
                cells: {
                    FormLabel(title: "Report a bug", onSelect: { [unowned self] in
                        self.reportBug()
                    })
                }
            )
            
            Section(
                id: "signout",
                header: Header(title: ""),
                cells: {
                    FormLabel(
                        title: "Sign Out",
                        color: .systemRed,
                        onSelect: { [unowned self] in
                            self.signOut()
                        }
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
    
    func setPinCode() {
        viewModel.router.openPinSettings()
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
    
    func reportBug() {
        guard let url = URL(string: Global.telegramChatURL) else {
            return
        }
        
        UIApplication.shared.open(url, options: [:], completionHandler: nil)
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

