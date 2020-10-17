//
//  ArticleHeaderComponent.swift
//  ORTUS
//
//  Created by Firdavs Khaydarov on 21/03/19.
//  Copyright © 2019 Firdavs. All rights reserved.
//

import UIKit
import Carbon

struct ArticleHeaderComponent: Carbon.Component, Equatable {
    var article: Article
    
    func renderContent() -> ArticleHeaderComponentView {
        return ArticleHeaderComponentView()
    }
    
    func render(in content: ArticleHeaderComponentView) {
        if let imageURL = article.imageURL {
            content.imageView.kf.setImage(with: URL(string: imageURL))
        }
        
        content.titleLabel.text = article.title
    }
    
    func referenceSize(in bounds: CGRect) -> CGSize? {
        return nil
    }
    
    func shouldContentUpdate(with next: ArticleHeaderComponent) -> Bool {
        return false
    }
    
    static func == (lhs: ArticleHeaderComponent, rhs: ArticleHeaderComponent) -> Bool {
        return lhs.article.id == rhs.article.id
    }
}
