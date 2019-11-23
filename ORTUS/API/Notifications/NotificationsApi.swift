//
//  NotificationsApi.swift
//  ORTUS
//
//  Created by Firdavs Khaydarov on 04/10/19.
//  Copyright © 2019 Firdavs. All rights reserved.
//

import Alamofire

enum NotificationsApi: API {
    case notifications
    
    var method: HTTPMethod {
        switch self {
        default:
            return .post
        }
    }
    
    var path: String {
        switch self {
        default:
            return "oauth/notifications"
        }
    }
    
    var parameters: Parameters? {
        switch self {
        case .notifications:
            return parameters(for: .getUserNotifications)
        }
    }
}
