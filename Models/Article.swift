//
//  Article.swift
//  ORTUS
//
//  Created by Firdavs Khaydarov on 21/03/19.
//  Copyright © 2019 Firdavs. All rights reserved.
//

import Foundation

public typealias ArticlesResponse = Response<Articles>

public struct Articles: Codable {
    public let articles: [Article]
}

public struct Article: Codable {
    public let text: String
    public let id: Int
    public let date: Date
    public let title, author: String
    public let imageURL: String?
}

public class ArticleDecoder: JSONDecoder {
    public let dateFormatter = DateFormatter()
    
    public override init() {
        super.init()
        
        dateFormatter.setAPIDefaultFormat()
        dateDecodingStrategy = .formatted(dateFormatter)
    }
}
