//
//  EventLogger.swift
//  ORTUS
//
//  Created by Firdavs Khaydarov on 25/11/19.
//  Copyright © 2019 Firdavs. All rights reserved.
//

import Foundation
import YandexMobileMetrica

class EventLogger {
    enum EventType {
        case openedArticle(id: Int, title: String)
        case openedCourse(id: String, name: String)
        case openedEvent
        case signedOut
        
        var name: String {
            switch self {
            case .openedArticle:
                return "Opened Article"
            case .openedCourse:
                return "Opened Course"
            case .openedEvent:
                return "Opened Event"
            case .signedOut:
                return "Signed Out"
            }
        }
        
        var parameters: [AnyHashable: Any]? {
            switch self {
            case let .openedArticle(id, title):
                return [
                    "id": id,
                    "title": title
                ]
            case let .openedCourse(id, name):
                return [
                    "id": id,
                    "name": name
                ]
            default:
                return nil
            }
        }
    }
    
    class func log(_ type: EventType) {
        YMMYandexMetrica.reportEvent(type.name, parameters: type.parameters, onFailure: nil)
    }
}
