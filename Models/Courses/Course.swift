//
//  Course.swift
//  ORTUS
//
//  Created by Firdavs Khaydarov on 02/10/19.
//  Copyright © 2019 Firdavs. All rights reserved.
//

import Foundation

public typealias Semesters = [Semester]
public typealias CoursesResponse = Response<Semesters>

public struct Semester: Codable {
    public let name: String?
    public let courses: [Course]
}

public struct Course: Codable, Hashable {
    public let id: String
    public let name: String
    public let link: String
}
