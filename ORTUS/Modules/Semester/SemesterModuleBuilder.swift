//
//  SemesterModuleBuilder.swift
//  ORTUS
//
//  Created by Firdavs Khaydarov on 04/02/20.
//  Copyright (c) 2020 Firdavs. All rights reserved.
//

import Models

class SemesterModuleBuilder: ModuleBuilder {
    typealias M = SemesterViewController
    typealias P = Semester
    
    static func build(with parameter: Semester, customTransition transition: Transition? = nil) -> SemesterViewController {
        let router = SemesterRouter()
        let viewModel = SemesterViewModel(semester: parameter, router: router)
        let viewController = SemesterViewController(viewModel: viewModel)
        router.viewController = viewController
        router.openTransition = transition
        
        return viewController
    }
}
