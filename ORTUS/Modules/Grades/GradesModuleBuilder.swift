//
//  GradesModuleBuilder.swift
//  ORTUS
//
//  Created by Firdavs Khaydarov on 04/02/20.
//  Copyright (c) 2020 Firdavs. All rights reserved.
//

class GradesModuleBuilder: ModuleBuilder {
    typealias M = GradesViewController
    typealias P = Any?
    
    static func build(with parameter: Any? = nil, customTransition transition: Transition? = nil) -> GradesViewController {
        let router = GradesRouter()
        let viewModel = GradesViewModel(router: router)
        let viewController = GradesViewController(viewModel: viewModel)
        router.viewController = viewController
        router.openTransition = transition
        
        return viewController
    }
}
