//
//  CourseModuleBuilder.swift
//  ORTUS
//
//  Created by Firdavs Khaydarov on 24/12/19.
//  Copyright (c) 2019 Firdavs. All rights reserved.
//

class CourseModuleBuilder: ModuleBuilder {
    typealias M = CourseViewController
    typealias P = Course
    
    static func build(with parameter: Course, customTransition transition: Transition? = nil) -> CourseViewController {
        let router = CourseRouter()
        let viewModel = CourseViewModel(course: parameter, router: router)
        let viewController = CourseViewController(viewModel: viewModel)
        router.viewController = viewController
        router.openTransition = transition
        
        return viewController
    }
}
