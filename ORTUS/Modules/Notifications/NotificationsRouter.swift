//
//  NotificationsRouter.swift
//  ORTUS
//
//  Created by Firdavs Khaydarov on 03/10/19.
//  Copyright (c) 2019 Firdavs. All rights reserved.
//

final class NotificationsRouter: Router<NotificationsViewController>, BrowserRoute {
    typealias Routes = BrowserRoute & Closable
    
    var transition: Transition {
        return PushTransition()
    }
}
