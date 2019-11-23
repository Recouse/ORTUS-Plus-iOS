//
//  CoursesApi.swift
//  ORTUS
//
//  Created by Firdavs Khaydarov on 01/10/19.
//  Copyright © 2019 Firdavs. All rights reserved.
//

import Alamofire

enum CoursesApi: API {
    case courses
    
    var method: HTTPMethod {
        switch self {
        default:
            return .post
        }
    }
    
    var path: String {
        switch self {
        default:
            return "oauth/courses"
        }
    }
    
    var parameters: Parameters? {
        switch self {
        case .courses:
            return parameters(for: .getUserCourses)
        }
    }
}
