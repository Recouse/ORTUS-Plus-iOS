//
//  FileManager.swift
//  Storage
//
//  Created by Firdavs Khaydarov on 08/03/2020.
//  Copyright © 2020 Firdavs. All rights reserved.
//

import Foundation

public extension FileManager {    
    static func sharedContainerURL() -> URL {
        return FileManager.default.containerURL(
            forSecurityApplicationGroupIdentifier: "group.me.recouse.ORTUS"
        )!
    }
}
