//
//  SettingsRouter.swift
//  ORTUS
//
//  Created by Firdavs Khaydarov on 21/03/19.
//  Copyright (c) 2019 Firdavs. All rights reserved.
//

final class SettingsRouter: Router<SettingsViewController>, LoginRoute {
    typealias Routes = LoginRoute & Closable
}
