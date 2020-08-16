//
//  Shortcut.swift
//  ORTUS
//
//  Created by Firdavs Khaydarov on 8/2/20.
//  Copyright © 2020 Firdavs. All rights reserved.
//

import Foundation
import CoreServices
import CoreSpotlight
import Intents

enum ActivityItem: String, CaseIterable {
    case news, grades, contacts, ortusWebsite
    case course
    
    var type: String {
        "me.recouse.ORTUS.ActivityType.\(rawValue)"
    }
    
    var title: String? {
        switch self {
        case .news:
            return "RTU news"
        case .grades:
            return "Grades"
        case .contacts:
            return "Contacts"
        case .ortusWebsite:
            return "ORTUS website"
        default:
            return nil
        }
    }
    
    var description: String? {
        switch self {
        case .news:
            return "Check recent news"
        case .grades:
            return "Check your grades"
        case .contacts:
            return "Find a contact"
        default:
            return nil
        }
    }
    
    var invocationPhrase: String? {
        switch self {
        case .news:
            return "Check news"
        case .grades:
            return "Check grades"
        case .contacts:
            return "Find a contact"
        case .ortusWebsite:
            return "ORTUS website"
        default:
            return nil
        }
    }
}

enum ActivityIdentifier: String {
    case app, student
    
    var value: String {
        "me.recouse.ORTUS.ActivityIdentifier.\(rawValue)"
    }
}

class Shortcut {
    let activity: NSUserActivity
    
    init(
        activity: ActivityItem,
        identifier: ActivityIdentifier = .app,
        title: String? = nil,
        description: String? = nil,
        userInfo: [AnyHashable: Any]? = nil
    ) {
        self.activity = NSUserActivity(activityType: activity.type)
        self.activity.isEligibleForSearch = true
        self.activity.title = title ?? activity.title
        self.activity.userInfo = userInfo
        
        let attributes = CSSearchableItemAttributeSet(itemContentType: kUTTypeItem as String)
        attributes.domainIdentifier = identifier.value
        attributes.contentDescription = description ?? activity.description
        
        self.activity.contentAttributeSet = attributes
        
        if #available(iOS 12.0, *) {
            self.activity.isEligibleForPrediction = true
            self.activity.suggestedInvocationPhrase = activity.invocationPhrase
        }
    }
    
    func donate() {
        activity.becomeCurrent()
    }
    
    static func deleteShortcuts(completion: @escaping () -> Void) {
        let group = DispatchGroup()
        
        let searchableIndex = CSSearchableIndex.default()
        
        group.enter()
        searchableIndex.deleteSearchableItems(
            withDomainIdentifiers: [ActivityIdentifier.student.value]
        ) { _ in
            group.leave()
        }
        
        if #available(iOS 12.0, *) {
            group.enter()
            NSUserActivity.deleteAllSavedUserActivities {
                group.leave()
            }
        }
        
        group.notify(queue: .main) {
            completion()
        }
    }
}
