//
//  ContactsModuleBuilder.swift
//  ORTUS
//
//  Created by Firdavs Khaydarov on 4/9/20.
//  Copyright (c) 2020 Firdavs. All rights reserved.
//

class ContactsModuleBuilder: ModuleBuilder {
    typealias M = ContactsViewController
    typealias P = Any?
    
    static func build(with parameter: Any? = nil, customTransition transition: Transition? = nil) -> ContactsViewController {
        let router = ContactsRouter()
        let viewModel = ContactsViewModel(router: router)
        let viewController = ContactsViewController(viewModel: viewModel)
        router.viewController = viewController
        router.openTransition = transition
        
        return viewController
    }
}
