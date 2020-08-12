//
//  AppearanceSettingsViewModel.swift
//  ORTUS
//
//  Created by Firdavs Khaydarov on 8/12/20.
//  Copyright (c) 2020 Firdavs. All rights reserved.
//

class AppearanceSettingsViewModel: ViewModel {
    let router: AppearanceSettingsRouter.Routes
    
    init(router: AppearanceSettingsRouter.Routes) {
        self.router = router
    }
}
