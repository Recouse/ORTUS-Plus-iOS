//
//  AppearanceSettingsRoute.swift
//  ORTUS
//
//  Created by Firdavs Khaydarov on 8/12/20.
//  Copyright © 2020 Firdavs. All rights reserved.
//

import UIKit

protocol AppearanceSettingsRoute: Route {
    func openAppearanceSettings()
}

extension AppearanceSettingsRoute where Self: RouterProtocol {
    func openAppearanceSettings() {
        let transition = self.transition
        let module = AppearanceSettingsModuleBuilder.build(with: nil, customTransition: transition)
        
        open(module, transition: transition, completion: nil)
    }
}

