//
//  Course.swift
//  ORTUS
//
//  Created by Firdavs Khaydarov on 02/10/19.
//  Copyright © 2019 Firdavs. All rights reserved.
//

import Foundation

typealias Semesters = [Semester]
typealias CoursesResponse = Response<Semesters>

struct Semester: Codable {
    let name: String?
    let courses: [Course]
}

struct Course: Codable {
    let id: String
    let name: String
    let link: String
}
