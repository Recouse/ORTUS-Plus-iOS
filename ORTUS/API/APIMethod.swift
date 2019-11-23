//
//  APIMethod.swift
//  ORTUS
//
//  Created by Firdavs Khaydarov on 21/03/19.
//  Copyright © 2019 Firdavs. All rights reserved.
//

import Foundation
import KeychainAccess

enum APIMethod: String {
    case getPublicArticles
    case getArticles
    case getUserSchedule
    case getUserCourses
    case getUserNotifications
    
    var parameters: [String] {
        var values: [String] = []
        
        let keychain = Keychain()
        
        switch self {
        case .getPublicArticles:
            values.append(Global.clientID)
            values.append(Global.Locale.current)
        default:
            values.append(keychain[Global.Key.accessToken] ?? "")
            values.append(Global.Locale.current)
        }
        
        return values
    }
}
