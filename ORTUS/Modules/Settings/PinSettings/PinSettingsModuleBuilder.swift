//
//  PinSettingsModuleBuilder.swift
//  ORTUS
//
//  Created by Firdavs Khaydarov on 31/01/20.
//  Copyright (c) 2020 Firdavs. All rights reserved.
//

class PinSettingsModuleBuilder: ModuleBuilder {
    typealias M = PinSettingsViewController
    typealias P = Any?
    
    static func build(with parameter: Any? = nil, customTransition transition: Transition? = nil) -> PinSettingsViewController {
        let router = PinSettingsRouter()
        let viewModel = PinSettingsViewModel(router: router)
        let viewController = PinSettingsViewController(viewModel: viewModel)
        router.viewController = viewController
        router.openTransition = transition
        
        return viewController
    }
}
