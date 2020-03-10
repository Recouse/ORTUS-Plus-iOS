//
//  ArticleModuleBuilder.swift
//  ORTUS
//
//  Created by Firdavs Khaydarov on 21/03/19.
//  Copyright (c) 2019 Firdavs. All rights reserved.
//

import Models

class ArticleModuleBuilder: ModuleBuilder {
    typealias M = ArticleViewController
    typealias P = Article
    
    static func build(with parameter: Article, customTransition transition: Transition? = nil) -> ArticleViewController {
        let router = ArticleRouter()
        let viewModel = ArticleViewModel(router: router, article: parameter)
        let viewController = ArticleViewController(viewModel: viewModel)
        router.viewController = viewController
        router.openTransition = transition
        
        return viewController
    }
}
