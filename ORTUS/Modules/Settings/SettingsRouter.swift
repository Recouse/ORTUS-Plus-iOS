//
//  SettingsRouter.swift
//  ORTUS
//
//  Created by Firdavs Khaydarov on 21/03/19.
//  Copyright (c) 2019 Firdavs. All rights reserved.
//

final class SettingsRouter: Router<SettingsViewController>, LoginRoute, AppearanceSettingsRoute, PinSettingsRoute, ScheduleSettingsRoute {
    typealias Routes = LoginRoute & AppearanceSettingsRoute & PinSettingsRoute & ScheduleSettingsRoute & Closable
    
    var transition: Transition {
        return PushTransition()
    }
}
