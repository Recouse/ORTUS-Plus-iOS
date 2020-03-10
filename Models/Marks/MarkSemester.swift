//
//  MarkSemester.swift
//  ORTUS
//
//  Created by Firdavs Khaydarov on 05/02/20.
//  Copyright © 2020 Firdavs. All rights reserved.
//

import Foundation

public struct MarkSemester: Codable {
    public let id: Int
    public let shortName, fullName: String
    public let marks: [Mark]
}
