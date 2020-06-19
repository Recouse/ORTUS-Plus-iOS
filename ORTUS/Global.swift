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
        static let ortusPinCode = "ortus_pin_code"
        
        static let courseJSHandler = "courseHandler"
        
        // Settings keys
        static let showEvents = "show_events"
        
        // App group
        static let appGroup = "group.me.recouse.ORTUS"
        
        // Cache
        static let scheduleCache = "scheduleCache"
        static let contactsCache = "contactsCache"
        static let coursesCache = "coursesCache"
        static let gradesCache = "gradesCache"
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
            return Localize.currentLanguage()
        }
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
    
    static let githubIssuesURL = "https://github.com/ORTUS-Plus/ORTUS-Plus-iOS/issues"
    static let privacyPolicyURL = "https://ortus.plus/privacypolicy/"
    static let telegramChatUsername = "ortusplus"
    static let telegramChatURL = "https://t.me/\(Self.telegramChatUsername)"
    static let telegramChatDeepURL = "tg://resolve?domain=\(Self.telegramChatUsername)"
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
