//
//  SemesterViewModel.swift
//  ORTUS
//
//  Created by Firdavs Khaydarov on 04/02/20.
//  Copyright (c) 2020 Firdavs. All rights reserved.
//

import Models

class SemesterViewModel: ViewModel {
    let semester: Semester
    
    let router: SemesterRouter.Routes
    
    init(semester: Semester, router: SemesterRouter.Routes) {
        self.semester = semester
        self.router = router
    }
}
