//
//  NewsRouter.swift
//  ORTUS
//
//  Created by Firdavs Khaydarov on 21/03/19.
//  Copyright (c) 2019 Firdavs. All rights reserved.
//

final class NewsRouter: Router<NewsViewController>, ArticleRoute {
    typealias Routes = ArticleRoute & Closable
    
    var transition: Transition {
        return PushTransition()
    }
}
