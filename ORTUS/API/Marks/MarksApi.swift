//
//  MarksApi.swift
//  ORTUS
//
//  Created by Firdavs Khaydarov on 05/02/20.
//  Copyright © 2020 Firdavs. All rights reserved.
//

import Alamofire

enum MarksApi: API {
    case marks
    
    var method: HTTPMethod {
        switch self {
        default:
            return .post
        }
    }
    
    var path: String {
        switch self {
        default:
            return "oauth/marks"
        }
    }
    
    var parameters: Parameters? {
        switch self {
        case .marks:
            return parameters(for: .getUserMarks)
        }
    }
}
