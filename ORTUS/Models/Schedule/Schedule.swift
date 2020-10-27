//
//  Schedule.swift
//  ORTUS
//
//  Created by Firdavs Khaydarov on 10/10/19.
//  Copyright © 2019 Firdavs. All rights reserved.
//

import Foundation

public typealias ScheduleResponse = Response<[String: Schedule]>
public typealias SortedSchedule = [(key: String, value: [ScheduleItem])]

extension ScheduleResponse {
    func sorted() -> SortedSchedule {
        let sortedResponse = result.sorted(by: {
            let dateFormatter = LatviaDateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd"
            
            guard let date0 = dateFormatter.date(from: $0.key),
                let date1 = dateFormatter.date(from: $1.key) else {
                return false
            }
            
            return date0 < date1
        })
        
        let sharedUserDefaults = UserDefaults.standard
        
        var schedule: [(key: String, value: [ScheduleItem])] = []
        for pair in sortedResponse {
            var items: [ScheduleItem] = []
//            if sharedUserDefaults?.value(for: .showEvents) == true {
                pair.value.events.forEach { items.append(ScheduleItem(id: $0.title, item: $0, time: $0.timeParsed)) }
//            }
            
            pair.value.lectures.forEach { items.append(ScheduleItem(id: $0.id, item: $0, time: $0.timeFromParsed)) }
            items.sort(by: {
                guard let firstDate = $0.timeDate, let secondDate = $1.timeDate else {
                    return false
                }
                
                return firstDate < secondDate
            })
            
            if !items.isEmpty {
                schedule.append((key: pair.key, value: items))
            }
        }
        
        return schedule
    }
}

public struct Schedule: Codable {
    public let events: Events
    public let lectures: Lectures
}

public struct ScheduleItem: Identifiable {
    public var id: String
    
    public var item: Codable
    
    public var time: String = "00:00"
    
    public var timeDate: Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.setAPIDefaultFormat(to: .time)
        
        return dateFormatter.date(from: time)
    }
    
    public init<I: Codable>(id: String, item: I, time: String) {
        self.id = id
        self.item = item
        self.time = time
    }
    
    @inlinable
    public func item<I>(as _: I.Type) -> I? {
        return item as? I
    }
}
