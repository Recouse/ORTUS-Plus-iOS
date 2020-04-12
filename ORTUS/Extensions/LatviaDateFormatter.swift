//
//  LatviaDateFormatter.swift
//  ORTUS
//
//  Created by Firdavs Khaydarov on 4/12/20.
//  Copyright © 2020 Firdavs. All rights reserved.
//

import Foundation

class LatviaDateFormatter: DateFormatter {
    override init() {
        super.init()
        
        locale = Locale(identifier: "en_LV")
        timeZone = TimeZone(identifier: "Europe/Riga")
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
