//
//  ContactRoute.swift
//  ORTUS
//
//  Created by Firdavs Khaydarov on 4/10/20.
//  Copyright © 2020 Firdavs. All rights reserved.
//

import UIKit
import Models

protocol ContactRoute: Route {
    func openContact(_ contact: Contact)
}

extension ContactRoute where Self: RouterProtocol {
    func openContact(_ contact: Contact) {
        let transition = self.transition
        let module = ContactModuleBuilder.build(with: contact, customTransition: transition)
        
        open(module, transition: transition, completion: nil)
    }
}
