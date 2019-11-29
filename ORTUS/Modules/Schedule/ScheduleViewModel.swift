//
//  ScheduleViewModel.swift
//  ORTUS
//
//  Created by Firdavs Khaydarov on 25/03/19.
//  Copyright (c) 2019 Firdavs. All rights reserved.
//

import Foundation
import Promises

enum ScheduleGrouping: String, CaseIterable {
    case today, tomorrow, week
}

class ScheduleViewModel: ViewModel {
    let router: ScheduleRouter.Routes
    
    var schedule: [(key: String, value: [ScheduleItem])] = []
    
    init(router: ScheduleRouter.Routes) {
        self.router = router
    }
    
    func loadSchedule() -> Promise<Bool> {
        let today = Date()
        var date = today
        
        if Calendar.current.component(.weekday, from: today) == 1 {
            date = Calendar.current.date(byAdding: .day, value: 1, to: today) ?? today
        }
        
        return Promise { fulfill, reject in
            APIClient.performRequest(
                ScheduleResponse.self,
                route: ScheduleApi.schedule(date: date)
            ).then { response in
                let sortedResponse = response.result.sorted(by: {
                    let dateFormatter = DateFormatter()
                    dateFormatter.dateFormat = "yyyy-MM-dd"
                    
                    guard let date0 = dateFormatter.date(from: $0.key),
                        let date1 = dateFormatter.date(from: $1.key) else {
                        return false
                    }
                    
                    return date0 < date1
                })
                
                var schedule: [(key: String, value: [ScheduleItem])] = []
                for pair in sortedResponse {
                    var items: [ScheduleItem] = []
                    pair.value.events.forEach { items.append(ScheduleItem($0, time: $0.time)) }
                    pair.value.lectures.forEach { items.append(ScheduleItem($0, time: $0.timeFrom)) }
                    items.sort(by: {
                        guard let firstDate = $0.timeDate, let secondDate = $1.timeDate else {
                            return false
                        }
                        
                        return firstDate < secondDate
                    })
                    schedule.append((key: pair.key, value: items))
                }
                
                self.schedule = schedule
                
                fulfill(true)
            }.catch { reject($0) }
        }
    }
}
