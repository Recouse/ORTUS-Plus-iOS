//
//  ArticleRoute.swift
//  ORTUS
//
//  Created by Firdavs Khaydarov on 21/03/19.
//  Copyright © 2019 Firdavs. All rights reserved.
//

import UIKit

protocol ArticleRoute: Route {
    func openArticle(_ article: Article)
    
}

extension ArticleRoute where Self: RouterProtocol {
    func openArticle(_ article: Article) {
        let transition = self.transition
        let module = ArticleModuleBuilder.build(with: article, customTransition: transition)
        
        open(module, transition: transition, completion: nil)
    }
}
