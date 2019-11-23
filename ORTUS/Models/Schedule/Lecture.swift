//
//  Lecture.swift
//  ORTUS
//
//  Created by Firdavs Khaydarov on 12/10/19.
//  Copyright © 2019 Firdavs. All rights reserved.
//

import Foundation

typealias Lectures = [Lecture]

struct Lecture: Codable {
    let id, date, timeFrom, timeTill, name, type: String
    let lecturers: [Lecturer]
    let address: String
}

struct Lecturer: Codable {
    let displayName: String
}
