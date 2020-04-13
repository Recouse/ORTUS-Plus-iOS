//
//  ContactsRoute.swift
//  ORTUS
//
//  Created by Firdavs Khaydarov on 4/9/20.
//  Copyright © 2020 Firdavs. All rights reserved.
//

import UIKit

protocol ContactsRoute: Route {
    func openContacts()
}

extension ContactsRoute where Self: RouterProtocol {
    func openContacts() {
        let transition = self.transition
        let module = ContactsModuleBuilder.build(with: nil, customTransition: transition)
        
        open(module, transition: transition, completion: nil)
    }
}
