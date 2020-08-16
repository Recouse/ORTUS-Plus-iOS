//
//  AppearanceSettingsModuleBuilder.swift
//  ORTUS
//
//  Created by Firdavs Khaydarov on 8/12/20.
//  Copyright (c) 2020 Firdavs. All rights reserved.
//

class AppearanceSettingsModuleBuilder: ModuleBuilder {
    typealias M = AppearanceSettingsViewController
    typealias P = Any?
    
    static func build(with parameter: Any? = nil, customTransition transition: Transition? = nil) -> AppearanceSettingsViewController {
        let router = AppearanceSettingsRouter()
        let viewModel = AppearanceSettingsViewModel(router: router)
        let viewController = AppearanceSettingsViewController(viewModel: viewModel)
        router.viewController = viewController
        router.openTransition = transition
        
        return viewController
    }
}
