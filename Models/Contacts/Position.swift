//
//  Position.swift
//  Models
//
//  Created by Firdavs Khaydarov on 4/9/20.
//  Copyright © 2020 Firdavs. All rights reserved.
//

import Foundation

public struct Position: Codable {
    public let address: String?
    public let department: String
    public let officeHours: String?
    public let phone: String?
    public let position: String
}
