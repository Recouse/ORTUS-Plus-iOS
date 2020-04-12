//
//  ContactsRouter.swift
//  ORTUS
//
//  Created by Firdavs Khaydarov on 4/9/20.
//  Copyright (c) 2020 Firdavs. All rights reserved.
//

final class ContactsRouter: Router<ContactsViewController>, ContactRoute {
    typealias Routes = ContactRoute & Closable
    
    var transition: Transition {
        return PushTransition()
    }
}

