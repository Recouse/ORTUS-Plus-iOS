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
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd-MM-yyyy"
        let string = dateFormatter.string(from: self)
        
        return dateFormatter.date(from: string) ?? self
    }
}
