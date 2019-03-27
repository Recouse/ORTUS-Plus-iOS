//
//  ArticleComponent.swift
//  ORTUS
//
//  Created by Firdavs Khaydarov on 21/03/19.
//  Copyright © 2019 Firdavs. All rights reserved.
//

import UIKit
import Carbon
import Kingfisher

struct ArticleComponent: IdentifiableComponent {
    var id: String
    var article: Article
    
    func renderContent() -> ArticleComponentView {
        return ArticleComponentView()
    }
    
    func render(in content: ArticleComponentView) {
        content.imageView.kf.setImage(with: URL(string: article.imageURL))
        content.authorLabel.text = article.author
        content.titleLabel.text = article.title
    }
    
    func referenceSize(in bounds: CGRect) -> CGSize? {
        return CGSize(width: bounds.width, height: 80)
    }
    
    func shouldContentUpdate(with next: ArticleComponent) -> Bool {
        return article.id != next.article.id
    }
}

