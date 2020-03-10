//
//  Notification.swift
//  ORTUS
//
//  Created by Firdavs Khaydarov on 04/10/19.
//  Copyright © 2019 Firdavs. All rights reserved.
//

import Foundation

public typealias Notifications = [NotificationModel]
public typealias NotificationsResponse = Response<Notifications>

public struct NotificationModel: Codable {
    public let id: String
    public let date: Int
    public let title, link: String
    public let count: Int
}
