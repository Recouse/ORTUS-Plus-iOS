//
//  LoginModuleBuilder.swift
//  ORTUS
//
//  Created by Firdavs Khaydarov on 07/12/19.
//  Copyright (c) 2019 Firdavs. All rights reserved.
//

class LoginModuleBuilder: ModuleBuilder {
    typealias M = LoginViewController
    typealias P = Any?
    
    static func build(with parameter: Any? = nil, customTransition transition: Transition? = nil) -> LoginViewController {
        let router = LoginRouter()
        let viewModel = LoginViewModel(router: router)
        let viewController = LoginViewController(viewModel: viewModel)
        router.viewController = viewController
        router.openTransition = transition
        
        return viewController
    }
}
