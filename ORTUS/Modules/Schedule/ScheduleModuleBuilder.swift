//
//  ScheduleModuleBuilder.swift
//  ORTUS
//
//  Created by Firdavs Khaydarov on 25/03/19.
//  Copyright (c) 2019 Firdavs. All rights reserved.
//

class ScheduleModuleBuilder: ModuleBuilder {
    typealias M = ScheduleViewController
    typealias P = Any?
    
    static func build(with parameter: Any? = nil, customTransition transition: Transition? = nil) -> ScheduleViewController {
        let router = ScheduleRouter()
        let viewModel = ScheduleViewModel(router: router)
        let viewController = ScheduleViewController(viewModel: viewModel)
        router.viewController = viewController
        router.openTransition = transition
        
        return viewController
    }
}
