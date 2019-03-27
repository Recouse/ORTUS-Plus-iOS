//
//  ScheduleViewModel.swift
//  ORTUS
//
//  Created by Firdavs Khaydarov on 25/03/19.
//  Copyright (c) 2019 Firdavs. All rights reserved.
//

class ScheduleViewModel: ViewModel {
    let router: ScheduleRouter.Routes
    
    init(router: ScheduleRouter.Routes) {
        self.router = router
    }
}
