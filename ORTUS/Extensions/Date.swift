//
//  Date.swift
//  ORTUS
//
//  Created by Firdavs Khaydarov on 21/03/19.
//  Copyright © 2019 Firdavs. All rights reserved.
//

import Foundation

extension Date {
    var dayMonth: Date {
        let dateFormatter = LatviaDateFormatter()
        dateFormatter.dateFormat = "dd-MM-yyyy"
        let string = dateFormatter.string(from: self)
        
        return dateFormatter.date(from: string) ?? self
    }
    
    func formatted(_ dateFormat: String) -> String {
        let dateFormatter = LatviaDateFormatter()
        dateFormatter.dateFormat = dateFormat
        
        return dateFormatter.string(from: self)
    }
    
    var day: Int {
        Calendar.current.component(.day, from: self)
    }
}
