//
//  ScheduleViewModel.swift
//  ORTUS
//
//  Created by Firdavs Khaydarov on 25/03/19.
//  Copyright (c) 2019 Firdavs. All rights reserved.
//

import UIKit
import Promises

enum ScheduleGrouping: String, CaseIterable {
    case today, tomorrow, week
}

class ScheduleViewModel: ViewModel {
    let router: ScheduleRouter.Routes
    
    var response: ScheduleResponse?
    
    var schedule: SortedSchedule = []
    
    let sharedUserDefaults = UserDefaults(suiteName: Global.Key.appGroup)
    
    let cache = Cache(path: AppGroup.default.containerURL)
    
    init(router: ScheduleRouter.Routes) {
        self.router = router
    }
    
    func loadCachedSchedule() -> Promise<Bool> {
        return Promise { fulfill, reject in
            do {
                let response = try self.cache.fetch(
                    ScheduleResponse.self,
                    forKey: .schedule
                )
                
                self.schedule = response.sorted()
                
                fulfill(true)
            } catch StorageError.notFound {
                fulfill(true)
            } catch {
                reject(error)
            }
        }
    }
    
    func loadSchedule(date: Date = Date()) -> Promise<Bool> {
        return Promise { fulfill, reject in
            APIClient.performRequest(
                ScheduleResponse.self,
                route: ScheduleApi.schedule(date: date)
            ).then { response in
                self.cacheResponse(response)
                
                self.response = response
                self.schedule = response.sorted()
                
                fulfill(true)
            }.catch { reject($0) }
        }
    }
    
    class func refreshSchedule(
        backgroundFetchCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void
    ) {
        let viewModel = ScheduleViewModel(router: ScheduleRouter())
        viewModel.loadSchedule().then { _ in
            completionHandler(.newData)
        }.catch { _ in
            completionHandler(.failed)
        }
    }
    
    private func cacheResponse(_ response: ScheduleResponse) {
        cache.save(response, forKey: .schedule)
    }
}
