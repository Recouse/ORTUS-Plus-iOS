//
//  ContactViewModel.swift
//  ORTUS
//
//  Created by Firdavs Khaydarov on 4/10/20.
//  Copyright (c) 2020 Firdavs. All rights reserved.
//

class ContactViewModel: ViewModel {
    let router: ContactRouter.Routes
    
    init(router: ContactRouter.Routes) {
        self.router = router
    }
}
