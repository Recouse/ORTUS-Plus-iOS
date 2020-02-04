//
//  NotificationsModuleBuilder.swift
//  ORTUS
//
//  Created by Firdavs Khaydarov on 03/10/19.
//  Copyright (c) 2019 Firdavs. All rights reserved.
//

class NotificationsModuleBuilder: ModuleBuilder {
    typealias M = NotificationsViewController
    typealias P = Any?
    
    static func build(with parameter: Any? = nil, customTransition transition: Transition? = nil) -> NotificationsViewController {
        let router = NotificationsRouter()
        let viewModel = NotificationsViewModel(router: router)
        let viewController = NotificationsViewController(viewModel: viewModel)
        router.viewController = viewController
        router.openTransition = transition
        
        return viewController
    }
}
