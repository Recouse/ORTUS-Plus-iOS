//
//  ScheduleSettingsViewModel.swift
//  ORTUS
//
//  Created by Firdavs Khaydarov on 06/02/20.
//  Copyright (c) 2020 Firdavs. All rights reserved.
//

class ScheduleSettingsViewModel: ViewModel {
    let router: ScheduleSettingsRouter.Routes
    
    init(router: ScheduleSettingsRouter.Routes) {
        self.router = router
    }
}
