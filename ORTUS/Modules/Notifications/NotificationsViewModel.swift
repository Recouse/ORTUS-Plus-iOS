//
//  NotificationsViewModel.swift
//  ORTUS
//
//  Created by Firdavs Khaydarov on 03/10/19.
//  Copyright (c) 2019 Firdavs. All rights reserved.
//

import Foundation
import Promises

class NotificationsViewModel: ViewModel {
    let router: NotificationsRouter.Routes
    
    var notifications: Notifications = []
    
    init(router: NotificationsRouter.Routes) {
        self.router = router
    }
    
    func loadNotifications() -> Promise<Bool> {
        return Promise { fulfill, reject in
            APIClient.performRequest(
                NotificationsResponse.self,
                route: NotificationsApi.notifications
            ).then { response in
                self.notifications = response.result
                
                NotificationCenter.default.post(
                    name: .updatedNotificationsCount,
                    object: nil,
                    userInfo: ["count": response.result.count])
                
                fulfill(true)
            }.catch { reject($0) }
        }
    }
}
