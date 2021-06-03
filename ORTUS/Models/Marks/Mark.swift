//
//  Mark.swift
//  ORTUS
//
//  Created by Firdavs Khaydarov on 05/02/20.
//  Copyright © 2020 Firdavs. All rights reserved.
//

import Foundation

public struct Mark: Codable {
    public let id: Int
    public let courseShortName: String
    public let courseFullName: String
    public let creditPoints: String
    public let lecturerFullName: String
    public let mark: String?
    public let markType: String
    public let date: String?
}
