//
//  Notification.swift
//  ORTUS
//
//  Created by Firdavs Khaydarov on 21/03/19.
//  Copyright © 2019 Firdavs. All rights reserved.
//

import Foundation

extension Notification.Name {
    static let scrollToTop = Notification.Name("scroll_to_top")
    static let authComplete = Notification.Name("auth_complete")
    static let authFailed = Notification.Name("auth_failed")
    static let userSignedOut = Notification.Name("user_signed_out")
    static let updatedNotificationsCount = Notification.Name("updated_notifications_count")
}
