//
//  NewsViewModel.swift
//  ORTUS
//
//  Created by Firdavs Khaydarov on 21/03/19.
//  Copyright (c) 2019 Firdavs. All rights reserved.
//

import Foundation
import Promises
import Models

class NewsViewModel: ViewModel {
    typealias SortedArticles = [Date: [Article]]
    
    let router: NewsRouter.Routes
    
    var articles: SortedArticles = [:]
    
    var loadedFromCache: Bool = false
    
    init(router: NewsRouter.Routes) {
        self.router = router
    }
    
    @discardableResult
    func loadArticles() -> Promise<Bool> {
        return Promise { fulfill, reject in
            APIClient.performRequest(
                ArticlesResponse.self,
                route: UserViewModel.isLoggedIn ? NewsApi.articles : NewsApi.publicArticles,
                isPublic: !UserViewModel.isLoggedIn,
                decoder: ArticleDecoder()
            ).then { response in
                self.articles = self.groupArticles(response.result.articles)
                
                Cache.shared.save(response, forKey: Global.Key.newsCache)
                                
                fulfill(true)
            }.catch { error in
                reject(error)
            }
        }
    }
    
    func loadCachedArticles() -> Promise<Bool> {
        return Promise { fulfill, reject in
            do {
                let response = try Cache.shared.fetch(
                    ArticlesResponse.self,
                    forKey: Global.Key.newsCache
                )
                
                self.articles = self.groupArticles(response.result.articles)
                self.loadedFromCache = true
                
                fulfill(true)
            } catch {
                reject(error)
            }
        }
    }
    
    private func groupArticles(_ articles: [Article]) -> SortedArticles {
        Dictionary(grouping: articles, by: {
            $0.date.dayMonth
        })
    }
}
