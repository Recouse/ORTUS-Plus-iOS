//
//  NotificationsViewModel.swift
//  ORTUS
//
//  Created by Firdavs Khaydarov on 03/10/19.
//  Copyright (c) 2019 Firdavs. All rights reserved.
//

import Foundation
import Promises
import Storage

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
                
                Cache.shared.save(response.result, forKey: Global.Key.notificationsCache)
                
                UserDefaults.standard.set(response.result.count, for: .notificationsCount)
                
                NotificationCenter.default.post(
                    name: .updatedNotificationsCount,
                    object: nil
                )
                
                fulfill(true)
            }.catch { reject($0) }
        }
    }
    
    func loadCachedNotifications() -> Promise<Bool> {
        return Promise { fulfill, reject in
            do {
                let notifications = try Cache.shared.fetch(
                    Notifications.self,
                    forKey: Global.Key.notificationsCache
                )
                
                self.notifications = notifications
                
                fulfill(true)
            } catch StorageError.notFound {
                fulfill(true)
            } catch {
                reject(error)
            }
        }
    }
}
