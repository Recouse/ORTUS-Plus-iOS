//
//  StudyProgram.swift
//  ORTUS
//
//  Created by Firdavs Khaydarov on 05/02/20.
//  Copyright © 2020 Firdavs. All rights reserved.
//

import Foundation

typealias StudyProgramsResponse = Response<[StudyProgram]>

struct StudyProgram: Codable {
    let id: Int
    let shortName, fullName: String
    let semesters: [MarkSemester]
}
