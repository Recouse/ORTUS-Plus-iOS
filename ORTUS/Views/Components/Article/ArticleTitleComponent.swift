//
//  ArticleTitleComponent.swift
//  ORTUS
//
//  Created by Firdavs Khaydarov on 11/19/20.
//  Copyright © 2020 Firdavs. All rights reserved.
//

import UIKit
import Carbon

struct ArticleTitleComponent: Component {
    let article: Article
    
    func renderContent() -> ArticleTitleComponentView {
        return ArticleTitleComponentView()
    }
    
    func render(in content: ArticleTitleComponentView) {
        content.authorLabel.text = article.author
        content.titleLabel.text = article.title
        
        let dateFormatter = LatviaDateFormatter()
        dateFormatter.dateStyle = .medium
        content.dateLabel.text = dateFormatter.string(from: article.date)
    }
    
    func referenceSize(in bounds: CGRect) -> CGSize? {
        return nil
    }
}
