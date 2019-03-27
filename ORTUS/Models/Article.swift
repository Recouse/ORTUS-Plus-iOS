//
//  Article.swift
//  ORTUS
//
//  Created by Firdavs Khaydarov on 21/03/19.
//  Copyright © 2019 Firdavs. All rights reserved.
//

import Foundation

typealias ArticlesResponse = Response<Articles>

struct Articles: Codable {
    let articles: [Article]
}

struct Article: Codable {
    let text: String
    let id: Int
    let date: Date
    let title, author, imageURL: String
}

class ArticleDecoder: JSONDecoder {
    let dateFormatter = DateFormatter()
    
    override init() {
        super.init()
        
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm"
        dateDecodingStrategy = .formatted(dateFormatter)
    }
}
