//
//  CoursesModuleBuilder.swift
//  ORTUS
//
//  Created by Firdavs Khaydarov on 25/03/19.
//  Copyright (c) 2019 Firdavs. All rights reserved.
//

class CoursesModuleBuilder: ModuleBuilder {
    typealias M = CoursesViewController
    typealias P = Any?
    
    static func build(with parameter: Any? = nil, customTransition transition: Transition? = nil) -> CoursesViewController {
        let router = CoursesRouter()
        let viewModel = CoursesViewModel(router: router)
        let viewController = CoursesViewController(viewModel: viewModel)
        router.viewController = viewController
        router.openTransition = transition
        
        return viewController
    }
}
