//
//  MarkSemester.swift
//  ORTUS
//
//  Created by Firdavs Khaydarov on 05/02/20.
//  Copyright © 2020 Firdavs. All rights reserved.
//

import Foundation

struct MarkSemester: Codable {
    let id: Int
    let shortName, fullName: String
    let marks: [Mark]
}
