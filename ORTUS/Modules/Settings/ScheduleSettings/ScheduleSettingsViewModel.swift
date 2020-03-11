//
//  ScheduleSettingsViewModel.swift
//  ORTUS
//
//  Created by Firdavs Khaydarov on 06/02/20.
//  Copyright (c) 2020 Firdavs. All rights reserved.
//

import Foundation

class ScheduleSettingsViewModel: ViewModel {
    let router: ScheduleSettingsRouter.Routes
    
    let sharedUserDefaults = UserDefaults(suiteName: Global.Key.appGroup)
    
    init(router: ScheduleSettingsRouter.Routes) {
        self.router = router
    }
}
