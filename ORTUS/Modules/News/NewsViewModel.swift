//
//  NewsViewModel.swift
//  ORTUS
//
//  Created by Firdavs Khaydarov on 21/03/19.
//  Copyright (c) 2019 Firdavs. All rights reserved.
//

import Foundation
import Promises

class NewsViewModel: ViewModel {
    typealias SortedArticles = [Date: [Article]]
    
    let router: NewsRouter.Routes
    
    var articles: SortedArticles = [:]
    
    init(router: NewsRouter.Routes) {
        self.router = router
    }
    
    func loadArticles() -> Promise<SortedArticles> {
        return Promise { fulfill, reject in
            APIClient.performRequest(
                ArticlesResponse.self,
                route: UserViewModel.isLoggedIn ? NewsApi.articles : NewsApi.publicArticles,
                isPublic: !UserViewModel.isLoggedIn,
//                route: NewsApi.publicArticles,
                decoder: ArticleDecoder()
            ).then { response in
                self.articles = Dictionary(grouping: response.result.articles, by: {
                    $0.date.dayMonth
                })
                                
                fulfill(self.articles)
            }.catch { error in
                reject(error)
            }
        }
    }
}
