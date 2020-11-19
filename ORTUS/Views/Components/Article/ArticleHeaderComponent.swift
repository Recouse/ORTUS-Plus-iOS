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
    var imageURL: String?
    
    func renderContent() -> ArticleHeaderComponentView {
        return ArticleHeaderComponentView()
    }
    
    func render(in content: ArticleHeaderComponentView) {
        guard let imageURL = imageURL else {
            return
        }
        
        content.imageView.kf.setImage(with: URL(string: imageURL))
    }
    
    func referenceSize(in bounds: CGRect) -> CGSize? {
        return nil
    }
    
    func shouldContentUpdate(with next: ArticleHeaderComponent) -> Bool {
        return false
    }
    
    static func == (lhs: ArticleHeaderComponent, rhs: ArticleHeaderComponent) -> Bool {
        return lhs.imageURL == rhs.imageURL
    }
}
