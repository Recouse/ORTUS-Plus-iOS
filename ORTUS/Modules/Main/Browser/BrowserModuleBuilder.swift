//
//  BrowserModuleBuilder.swift
//  ORTUS
//
//  Created by Firdavs Khaydarov on 24/12/19.
//  Copyright (c) 2019 Firdavs. All rights reserved.
//

class BrowserModuleBuilder: ModuleBuilder {
    typealias M = BrowserViewController
    typealias P = String
    
    static func build(with parameter: String, customTransition transition: Transition? = nil) -> BrowserViewController {
        let router = BrowserRouter()
        let viewModel = BrowserViewModel(url: parameter, router: router)
        let viewController = BrowserViewController(viewModel: viewModel)
        router.viewController = viewController
        router.openTransition = transition
        
        return viewController
    }
}
