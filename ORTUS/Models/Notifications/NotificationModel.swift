//
//  Notification.swift
//  ORTUS
//
//  Created by Firdavs Khaydarov on 04/10/19.
//  Copyright © 2019 Firdavs. All rights reserved.
//

import Foundation

typealias Notifications = [NotificationModel]
typealias NotificationsResponse = Response<Notifications>

struct NotificationModel: Codable {
    let id: String
    let date: Int
    let title, link: String
    let count: Int
}
