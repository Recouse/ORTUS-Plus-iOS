//
//  NewsApi.swift
//  ORTUS
//
//  Created by Firdavs Khaydarov on 21/03/19.
//  Copyright © 2019 Firdavs. All rights reserved.
//

import Alamofire

enum NewsApi: API {
    case publicArticles
    
    var method: HTTPMethod {
        switch self {
        default:
            return .post
        }
    }
    
    var path: String {
        switch self {
        case .publicArticles:
            return "oauth/news"
        }
    }
    
    var parameters: Parameters? {
        switch self {
        case .publicArticles:
            return parameters(for: .getPublicArticles)
        }
    }
}
