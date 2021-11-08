//
//  APIMethod.swift
//  ORTUS
//
//  Created by Firdavs Khaydarov on 21/03/19.
//  Copyright © 2019 Firdavs. All rights reserved.
//

import Foundation

enum APIMethod: String {
    case getPublicArticles
    case getArticles
    case getUserSchedule
    case getUserCourses
    case getUserNotifications
    case getUserMarks
    case getPublicContacts
    
    var parameters: [String] {
        var values: [String] = []
        
        let keychain = Keychain.default
        
        switch self {
        case .getPublicArticles, .getPublicContacts:
            values.append(Global.clientID)
            values.append(Global.Locale.current)
        default:
            values.append(keychain[.accessToken] ?? "")
            values.append(Global.Locale.current)
        }
        
        return values
    }
}
