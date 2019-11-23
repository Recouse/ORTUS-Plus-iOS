//
//  InboxViewModel.swift
//  ORTUS
//
//  Created by Firdavs Khaydarov on 03/10/19.
//  Copyright (c) 2019 Firdavs. All rights reserved.
//

import Promises

class InboxViewModel: ViewModel {
    let router: InboxRouter.Routes
    
    var notifications: Notifications = []
    
    init(router: InboxRouter.Routes) {
        self.router = router
    }
    
    func loadNotifications() -> Promise<Bool> {
        return Promise { fulfill, reject in
            APIClient.performRequest(
                NotificationsResponse.self,
                route: NotificationsApi.notifications
            ).then { response in
                self.notifications = response.result
                
                fulfill(true)
            }.catch { reject($0) }
        }
    }
}
