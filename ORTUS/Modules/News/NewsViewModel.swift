//
//  NewsViewModel.swift
//  ORTUS
//
//  Created by Firdavs Khaydarov on 21/03/19.
//  Copyright (c) 2019 Firdavs. All rights reserved.
//

import Foundation
import Promises
import Combine

class NewsViewModel: ViewModel {
    typealias SortedArticles = [Date: [Article]]
    
    let router: NewsRouter.Routes
    
    @Published var articles: SortedArticles = [:]
    
    private let urlSession = URLSession.shared
    
    private var cancellables = Set<AnyCancellable>()
        
    init(router: NewsRouter.Routes) {
        self.router = router
    }
    
    func loadArticles(forceUpdate: Bool = false) {
        if !forceUpdate {
            if let response = try? Cache.shared.fetch(
                ArticlesResponse.self,
                forKey: .news
            ) {
                articles = groupArticles(response.result.articles)
                return
            }
        }
        
        urlSession.publisher(
            for: .news,
            decoder: ArticleDecoder()
        ).sink(receiveCompletion: { completion in
            switch completion {
            case .failure(let error):
                print("Error on loading News:", error.localizedDescription)
            default:
                break
            }
        }, receiveValue: { response in
            self.articles = self.groupArticles(response.result.articles)
            
            Cache.shared.save(response, forKey: .news)
        }).store(in: &cancellables)
    }
    
    private func groupArticles(_ articles: [Article]) -> SortedArticles {
        Dictionary(grouping: articles, by: \.date.dayMonth)
    }
}
