//
//  AppGroup.swift
//  ORTUS
//
//  Created by Firdavs Khaydarov on 10/26/20.
//  Copyright © 2020 Firdavs. All rights reserved.
//

import Foundation

enum AppGroup: String {
    case `default` = "group.me.recouse.ORTUS"
    
    var containerURL: URL {
        switch self {
        case .default:
            return FileManager.default.containerURL(
                forSecurityApplicationGroupIdentifier: self.rawValue
            )!
        }
    }
}
