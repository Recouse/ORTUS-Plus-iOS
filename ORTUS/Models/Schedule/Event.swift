//
//  Event.swift
//  ORTUS
//
//  Created by Firdavs Khaydarov on 10/10/19.
//  Copyright © 2019 Firdavs. All rights reserved.
//

import Foundation

typealias Events = [Event]

struct Event: Codable {
    let datetime, title, link, description: String
    let allDayEvent: Bool
    
    var time: String {
        let dateFormatter = DateFormatter()
        dateFormatter.setAPIDefaultFormat()
        
        guard let date = dateFormatter.date(from: datetime) else {
            return "00:00"
        }
        
        dateFormatter.dateFormat = "HH:mm"
        
        return dateFormatter.string(from: date)
    }
}

