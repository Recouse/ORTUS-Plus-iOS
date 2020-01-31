//
//  PinSettingsRoute.swift
//  ORTUS
//
//  Created by Firdavs Khaydarov on 31/01/20.
//  Copyright © 2020 Firdavs. All rights reserved.
//

import UIKit

protocol PinSettingsRoute: Route {
    func openPinSettings()
}

extension PinSettingsRoute where Self: RouterProtocol {
    func openPinSettings() {
        let transition = self.transition
        let module = PinSettingsModuleBuilder.build(with: nil, customTransition: transition)
        
        open(module, transition: transition, completion: nil)
    }
}
