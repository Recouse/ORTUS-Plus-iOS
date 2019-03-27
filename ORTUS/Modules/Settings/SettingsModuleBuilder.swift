//
//  SettingsModuleBuilder.swift
//  ORTUS
//
//  Created by Firdavs Khaydarov on 21/03/19.
//  Copyright (c) 2019 Firdavs. All rights reserved.
//

class SettingsModuleBuilder: ModuleBuilder {
    typealias M = SettingsViewController
    typealias P = Any?
    
    static func build(with parameter: Any? = nil, customTransition transition: Transition? = nil) -> SettingsViewController {
        let router = SettingsRouter()
        let viewModel = SettingsViewModel(router: router)
        let viewController = SettingsViewController(viewModel: viewModel)
        router.viewController = viewController
        router.openTransition = transition
        
        return viewController
    }
}
