//
//  ScheduleApi.swift
//  ORTUS
//
//  Created by Firdavs Khaydarov on 01/10/19.
//  Copyright © 2019 Firdavs. All rights reserved.
//

import Alamofire

enum ScheduleApi: API {
    case schedule(date: Date)
    
    var method: HTTPMethod {
        switch self {
        default:
            return .post
        }
    }
    
    var path: String {
        switch self {
        default:
            return "oauth/schedule"
        }
    }
    
    var parameters: Parameters? {
        switch self {
        case let .schedule(date):
            var params = parameters(for: .getUserSchedule)
            
            print(date)
            
            return params
        }
    }
}

