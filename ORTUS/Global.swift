//
//  Global.swift
//  ORTUS
//
//  Created by Firdavs Khaydarov on 21/03/19.
//  Copyright © 2019 Firdavs. All rights reserved.
//

import Foundation
import UIKit
import Localize_Swift

struct Global {    
    struct Key {
        static let accessToken = "access_token"
        static let accessTokenEncrypted = "access_token_encrypted"
        static let refreshToken = "refresh_token"
        static let tokenExpiresOn = "expires_on"
    }
    
    struct Server {
        static let baseURL = "https://apps.rtu.lv/mobile-api/v1/"
        static let pinAuthURL = "https://id2.rtu.lv/openam/UI/Login"
    }
    
    struct Locale {
        static var current: String {
            return Localize.currentLanguage()
        }
    }
    
    // UI
    struct UI {
        static let edgeInset: CGFloat = 16
        
        // TabBar
        enum TabBar: Int {
            case news, schedule, courses, inbox, settings
        }
    }
}

enum HTTPHeaderField: String {
    case token = "Token"
    case contentType = "Content-Type"
    case acceptType = "Accept"
    case acceptEncoding = "Accept-Encoding"
    case authorization = "Authorization"
    case cacheControl = "Cache-Control"
}

enum ContentType: String {
    case json = "application/json"
}

enum CacheControl: String {
    case noCache = "no-cache"
}
