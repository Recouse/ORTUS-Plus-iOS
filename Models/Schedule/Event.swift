//
//  Event.swift
//  ORTUS
//
//  Created by Firdavs Khaydarov on 10/10/19.
//  Copyright © 2019 Firdavs. All rights reserved.
//

import Foundation

public typealias Events = [Event]

public struct Event: Codable {
    public let datetime, title, link, description: String
    public let allDayEvent: Bool
    
    public init(datetime: String, title: String, link: String, description: String, allDayEvent: Bool) {
        self.datetime = datetime
        self.title = title
        self.link = link
        self.description = description
        self.allDayEvent = allDayEvent
    }
    
    public var time: String {
        let dateFormatter = DateFormatter()
        dateFormatter.setAPIDefaultFormat()
        
        guard let date = dateFormatter.date(from: datetime) else {
            return "00:00"
        }
        
        dateFormatter.dateFormat = "HH:mm"
        
        return dateFormatter.string(from: date)
    }
}

