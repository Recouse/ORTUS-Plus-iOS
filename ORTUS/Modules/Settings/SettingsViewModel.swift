//
//  SettingsViewModel.swift
//  ORTUS
//
//  Created by Firdavs Khaydarov on 21/03/19.
//  Copyright (c) 2019 Firdavs. All rights reserved.
//

class SettingsViewModel: ViewModel {
    let router: SettingsRouter.Routes
    
    init(router: SettingsRouter.Routes) {
        self.router = router
    }
}
