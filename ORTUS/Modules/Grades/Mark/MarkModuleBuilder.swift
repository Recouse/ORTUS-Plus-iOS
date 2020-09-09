//
//  MarkModuleBuilder.swift
//  ORTUS
//
//  Created by Firdavs Khaydarov on 8/19/20.
//  Copyright (c) 2020 Firdavs. All rights reserved.
//

import Models

class MarkModuleBuilder: ModuleBuilder {
    typealias M = MarkViewController
    typealias P = Mark
    
    static func build(with parameter: Mark, customTransition transition: Transition? = nil) -> MarkViewController {
        let router = MarkRouter()
        let viewModel = MarkViewModel(mark: parameter, router: router)
        let viewController = MarkViewController(viewModel: viewModel)
        router.viewController = viewController
        router.openTransition = transition
        
        return viewController
    }
}
