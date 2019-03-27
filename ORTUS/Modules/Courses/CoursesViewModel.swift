//
//  CoursesViewModel.swift
//  ORTUS
//
//  Created by Firdavs Khaydarov on 25/03/19.
//  Copyright (c) 2019 Firdavs. All rights reserved.
//

class CoursesViewModel: ViewModel {
    let router: CoursesRouter.Routes
    
    init(router: CoursesRouter.Routes) {
        self.router = router
    }
}
