//
//  ContactViewModel.swift
//  ORTUS
//
//  Created by Firdavs Khaydarov on 4/10/20.
//  Copyright (c) 2020 Firdavs. All rights reserved.
//

import Models

class ContactViewModel: ViewModel {
    let router: ContactRouter.Routes
    
    let contact: Contact
    
    init(contact: Contact, router: ContactRouter.Routes) {
        self.contact = contact
        self.router = router
    }
}
