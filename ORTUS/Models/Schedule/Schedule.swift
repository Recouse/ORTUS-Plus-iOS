//
//  Schedule.swift
//  ORTUS
//
//  Created by Firdavs Khaydarov on 10/10/19.
//  Copyright © 2019 Firdavs. All rights reserved.
//

import Foundation

public typealias ScheduleResponse = Response<[String: Schedule]>

public struct Schedule: Codable {
    public let events: Events
    public let lectures: Lectures
}

public struct ScheduleItem {
    public var item: Codable
    
    public var time: String = "00:00"
    
    public var timeDate: Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.setAPIDefaultFormat(to: .time)
        
        return dateFormatter.date(from: time)
    }
    
    public init<I: Codable>(_ item: I, time: String) {
        self.item = item
        self.time = time
    }
    
    @inlinable
    public func item<I>(as _: I.Type) -> I? {
        return item as? I
    }
}
