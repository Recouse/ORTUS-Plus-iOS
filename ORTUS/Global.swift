//
//  Global.swift
//  ORTUS
//
//  Created by Firdavs Khaydarov on 21/03/19.
//  Copyright © 2019 Firdavs. All rights reserved.
//

import Foundation
import UIKit

struct Global {    
    struct Key {
        static let accessToken = "access_token"
        static let accessTokenEncrypted = "access_token_encrypted"
        static let refreshToken = "refresh_token"
        static let tokenExpiresOn = "expires_on"
        static let ortusPinCode = "ortus_pin_code"
        
        static let courseJSHandler = "courseHandler"
        
        // Settings keys
        static let appearance = "appearance"
        static let showEvents = "show_events"
        
        // App group
        static let appGroup = "group.me.recouse.ORTUS"
    }
    
    struct Event {
        static let loggedIn = "loggedIn"
    }
    
    struct Server {
        static let baseURL = "https://apps.rtu.lv/mobile-api/v1/"
        static let pinAuthURL = "https://id2.rtu.lv/openam/UI/Login"
    }
    
    struct Locale {
        static var current: String {
            return Bundle.main.preferredLocalizations.first ?? "en"
        }
    }
    
    enum Module: String {
        case home, schedule, notifications
    }
    
    struct QuickAction {
        static let ortusAction = "OrtusAction"
        static let schedule = "ScheduleAction"
        static let notifications = "NotificationsAction"
    }
    
    // UI
    struct UI {
        static let edgeInset: CGFloat = 16
        
        // TabBar
        enum TabBar: Int {
            case home, schedule, notifications
        }
        
        static var isIphoneX: Bool {
            return UIDevice().userInterfaceIdiom == .phone && UIScreen.main.nativeBounds.height >= 1792
        }
        
        static var isIphone5: Bool {
            return UIDevice().userInterfaceIdiom == .phone && UIScreen.main.nativeBounds.height == 1136
        }
    }
    
    static let ortusURL = "https://ortus.rtu.lv/"
    
    static let privacyPolicyURL = "https://ortus.plus/privacypolicy/"
    
    static let feedbackEmail = "feedback@ortus.plus"
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
