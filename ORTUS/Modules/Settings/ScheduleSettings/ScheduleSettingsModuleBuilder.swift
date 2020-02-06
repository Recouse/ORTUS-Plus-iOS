//
//  ScheduleSettingsModuleBuilder.swift
//  ORTUS
//
//  Created by Firdavs Khaydarov on 06/02/20.
//  Copyright (c) 2020 Firdavs. All rights reserved.
//

class ScheduleSettingsModuleBuilder: ModuleBuilder {
    typealias M = ScheduleSettingsViewController
    typealias P = Any?
    
    static func build(with parameter: Any? = nil, customTransition transition: Transition? = nil) -> ScheduleSettingsViewController {
        let router = ScheduleSettingsRouter()
        let viewModel = ScheduleSettingsViewModel(router: router)
        let viewController = ScheduleSettingsViewController(viewModel: viewModel)
        router.viewController = viewController
        router.openTransition = transition
        
        return viewController
    }
}
