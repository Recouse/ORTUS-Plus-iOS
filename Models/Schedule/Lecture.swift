//
//  Lecture.swift
//  ORTUS
//
//  Created by Firdavs Khaydarov on 12/10/19.
//  Copyright © 2019 Firdavs. All rights reserved.
//

import Foundation

public typealias Lectures = [Lecture]

public struct Lecture: Codable {
    public let id, date, timeFrom, timeTill, name, type: String
    public let lecturers: [Lecturer]
    public let address: String
}

public struct Lecturer: Codable {
    public let displayName: String
}
