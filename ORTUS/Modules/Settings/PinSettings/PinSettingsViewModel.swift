//
//  PinSettingsViewModel.swift
//  ORTUS
//
//  Created by Firdavs Khaydarov on 31/01/20.
//  Copyright (c) 2020 Firdavs. All rights reserved.
//

class PinSettingsViewModel: ViewModel {
    let router: PinSettingsRouter.Routes
    
    let keychain = Keychain.default
    
    init(router: PinSettingsRouter.Routes) {
        self.router = router
    }
    
    func save(_ pin: String) {
        keychain[.ortusPinCode] = pin
    }
}
