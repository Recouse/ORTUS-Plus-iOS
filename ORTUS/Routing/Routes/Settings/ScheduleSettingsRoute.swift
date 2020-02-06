//
//  ScheduleSettingsRoute.swift
//  ORTUS
//
//  Created by Firdavs Khaydarov on 06/02/20.
//  Copyright © 2020 Firdavs. All rights reserved.
//

import UIKit

protocol ScheduleSettingsRoute: Route {
    func openScheduleSettings()
}

extension ScheduleSettingsRoute where Self: RouterProtocol {
    func openScheduleSettings() {
        let transition = self.transition
        let module = ScheduleSettingsModuleBuilder.build(with: nil, customTransition: transition)
        
        open(module, transition: transition, completion: nil)
    }
}
