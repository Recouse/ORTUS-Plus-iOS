//
//  DateFormatter.swift
//  Models
//
//  Created by Firdavs Khaydarov on 08/03/2020.
//  Copyright © 2020 Firdavs. All rights reserved.
//

import Foundation

public extension DateFormatter {
    enum APIDefaultFormat {
        case date, time
    }
    
    static let APIDefaultDateFormat = "yyyy-MM-dd'T'HH:mm"
    
    static let APIDefaultTimeFormat = "HH:mm"
    
    func setAPIDefaultFormat(to format: APIDefaultFormat = .date) {
        setLocalizedDateFormatFromTemplate("HH:mm")
        amSymbol = ""
        pmSymbol = ""
        locale = Locale(identifier: "en_LV")
        
        switch format {
        case .date:
            dateFormat = Self.APIDefaultDateFormat
        case .time:
            dateFormat = Self.APIDefaultTimeFormat
        }
        
    }
}
