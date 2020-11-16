//
//  Lecture.swift
//  ORTUS
//
//  Created by Firdavs Khaydarov on 12/10/19.
//  Copyright © 2019 Firdavs. All rights reserved.
//

import Foundation

public typealias Lectures = [Lecture]

public struct Lecture: Codable {
    public let id, date, timeFrom, timeTill, name, type: String
    public let lecturers: [Lecturer]
    public let address: String
    
    public var timeFromParsed: String {
        let dateFormatter = DateFormatter()
        dateFormatter.timeZone = TimeZone(identifier: "Europe/Riga")
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm"
        
        if let timeFromDate = dateFormatter.date(from: "\(date) \(timeFrom)") {
            dateFormatter.dateFormat = "HH:mm"
            dateFormatter.timeZone = TimeZone.current
            return dateFormatter.string(from: timeFromDate)
        }
        
        return timeFrom
    }
    
    public var timeTillParsed: String {
        let dateFormatter = DateFormatter()
        dateFormatter.timeZone = TimeZone(identifier: "Europe/Riga")
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm"
        
        if let timeFromDate = dateFormatter.date(from: "\(date) \(timeTill)") {
            dateFormatter.dateFormat = "HH:mm"
            dateFormatter.timeZone = TimeZone.current
            return dateFormatter.string(from: timeFromDate)
        }
        
        return timeTill
    }
}

public struct Lecturer: Codable {
    public let displayName: String
}
