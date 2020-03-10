//
//  Bundle.swift
//  ORTUS
//
//  Created by Firdavs Khaydarov on 10/03/2020.
//  Copyright © 2020 Firdavs. All rights reserved.
//

import Foundation

extension Bundle {
    var versionNumber: String? {
        infoDictionary?["CFBundleShortVersionString"] as? String
    }
    
    var buildNumber: String? {
        infoDictionary?["CFBundleVersion"] as? String
    }
}
