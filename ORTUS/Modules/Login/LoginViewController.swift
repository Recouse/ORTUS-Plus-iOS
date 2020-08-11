//
//  LoginViewController.swift
//  ORTUS
//
//  Created by Firdavs Khaydarov on 07/12/19.
//  Copyright (c) 2019 Firdavs. All rights reserved.
//

import UIKit
import SafariServices

class LoginViewController: Module, ModuleViewModel, AlertPresentable {
    var viewModel: LoginViewModel
    
    weak var loginView: LoginView! { return view as? LoginView }
    weak var signInButton: Button! { return loginView.signInButton }
    
    let onboardingViewController = LoginOnboardingViewController()
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    init(viewModel: LoginViewModel) {
        self.viewModel = viewModel
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        view = LoginView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        prepareOnboardingViewController()
        prepareData()
    }
    
    @objc func signIn() {
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
            
            self.viewModel.router.openMainTabBarController()
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
}

extension LoginViewController {
    func prepareOnboardingViewController() {
        addChild(onboardingViewController)
        loginView.onboardingContentView = onboardingViewController.view
    }
    
    func prepareData() {
        signInButton.addTarget(self, action: #selector(signIn), for: .touchUpInside)
        
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
        
        signInButton.setTitle("Sign in with ORTUS", for: .normal)
    }
}
