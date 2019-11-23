//
//  InboxModuleBuilder.swift
//  ORTUS
//
//  Created by Firdavs Khaydarov on 03/10/19.
//  Copyright (c) 2019 Firdavs. All rights reserved.
//

class InboxModuleBuilder: ModuleBuilder {
    typealias M = InboxViewController
    typealias P = Any?
    
    static func build(with parameter: Any? = nil, customTransition transition: Transition? = nil) -> InboxViewController {
        let router = InboxRouter()
        let viewModel = InboxViewModel(router: router)
        let viewController = InboxViewController(viewModel: viewModel)
        router.viewController = viewController
        router.openTransition = transition
        
        return viewController
    }
}
