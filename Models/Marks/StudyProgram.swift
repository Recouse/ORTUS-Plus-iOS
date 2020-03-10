//
//  StudyProgram.swift
//  ORTUS
//
//  Created by Firdavs Khaydarov on 05/02/20.
//  Copyright © 2020 Firdavs. All rights reserved.
//

import Foundation

public typealias StudyProgramsResponse = Response<[StudyProgram]>

public struct StudyProgram: Codable {
    public let id: Int
    public let shortName, fullName: String
    public let semesters: [MarkSemester]
}
