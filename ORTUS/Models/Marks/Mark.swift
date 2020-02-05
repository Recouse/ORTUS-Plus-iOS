//
//  Mark.swift
//  ORTUS
//
//  Created by Firdavs Khaydarov on 05/02/20.
//  Copyright © 2020 Firdavs. All rights reserved.
//

import Foundation

struct Mark: Codable {
    let id: Int
    let courseShortName: String
    let courseFullName: String
    let creditPoints: String
    let lecturerFullName: String
    let mark: String
    let markType: String
    let date: String
}
