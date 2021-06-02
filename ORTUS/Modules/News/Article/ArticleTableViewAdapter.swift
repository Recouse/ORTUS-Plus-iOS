//
//  ArticleTableViewAdapter.swift
//  ORTUS
//
//  Created by Firdavs Khaydarov on 22/03/19.
//  Copyright © 2019 Firdavs. All rights reserved.
//

import UIKit
import Carbon

protocol ArticleTableViewAdapterDelegate: AnyObject {
    func scrollViewDidScroll(_ scrollView: UIScrollView)
}

class ArticleTableViewAdapter: UITableViewAdapter {
    weak var delegate: ArticleTableViewAdapterDelegate?
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        delegate?.scrollViewDidScroll(scrollView)
    }
}

