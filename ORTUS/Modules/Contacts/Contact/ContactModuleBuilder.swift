//
//  ContactModuleBuilder.swift
//  ORTUS
//
//  Created by Firdavs Khaydarov on 4/10/20.
//  Copyright (c) 2020 Firdavs. All rights reserved.
//

class ContactModuleBuilder: ModuleBuilder {
    typealias M = ContactViewController
    typealias P = Any?
    
    static func build(with parameter: Any? = nil, customTransition transition: Transition? = nil) -> ContactViewController {
        let router = ContactRouter()
        let viewModel = ContactViewModel(router: router)
        let viewController = ContactViewController(viewModel: viewModel)
        router.viewController = viewController
        router.openTransition = transition
        
        return viewController
    }
}
