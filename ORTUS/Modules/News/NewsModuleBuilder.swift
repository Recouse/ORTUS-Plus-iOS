//
//  NewsModuleBuilder.swift
//  ORTUS
//
//  Created by Firdavs Khaydarov on 21/03/19.
//  Copyright (c) 2019 Firdavs. All rights reserved.
//

class NewsModuleBuilder: ModuleBuilder {
    typealias M = NewsViewController
    typealias P = Any?
    
//    static func build(with parameter: Any? = nil, customTransition transition: Transition? = nil) ->
//    }

    static func build(with parameter: Any? = nil, customTransition transition: Transition? = nil) -> NewsViewController {
        let router = NewsRouter()
        let viewModel = NewsViewModel(router: router)
        let viewController = NewsViewController(viewModel: viewModel)
        router.viewController = viewController
        router.openTransition = transition
        
        return viewController
    }
}
