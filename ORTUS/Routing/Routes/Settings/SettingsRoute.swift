//
//  SettingsRoute.swift
//  ORTUS
//
//  Created by Firdavs Khaydarov on 04/02/20.
//  Copyright © 2020 Firdavs. All rights reserved.
//

import UIKit

protocol SettingsRoute: Route {
    func openSettings()
}

extension SettingsRoute where Self: RouterProtocol {
    func openSettings() {
        let transition = self.transition
        let module = SettingsModuleBuilder.build(with: nil, customTransition: transition)
        module.hidesBottomBarWhenPushed = true
        
        open(module, transition: transition, completion: nil)
    }
}

