//
//  ArticleViewModel.swift
//  ORTUS
//
//  Created by Firdavs Khaydarov on 21/03/19.
//  Copyright (c) 2019 Firdavs. All rights reserved.
//

import Models

class ArticleViewModel: ViewModel {
    let router: ArticleRouter.Routes
    
    let article: Article
    
    init(router: ArticleRouter.Routes, article: Article) {
        self.router = router
        self.article = article
    }
}
