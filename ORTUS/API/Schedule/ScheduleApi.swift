//
//  ScheduleApi.swift
//  ORTUS
//
//  Created by Firdavs Khaydarov on 01/10/19.
//  Copyright © 2019 Firdavs. All rights reserved.
//

import Foundation
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
            var p = parameters(for: .getUserSchedule)
            
            let dateFormatter = LatviaDateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd"
            
            var params = p["params"] as? [String]
            params?.insert(dateFormatter.string(from: date), at: 1)
            p["params"] = params
            
            return p
        }
    }
}

