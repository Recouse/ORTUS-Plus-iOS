//
//  SemesterRouter.swift
//  ORTUS
//
//  Created by Firdavs Khaydarov on 04/02/20.
//  Copyright (c) 2020 Firdavs. All rights reserved.
//

final class SemesterRouter: Router<SemesterViewController>, BrowserRoute {
    typealias Routes = BrowserRoute & Closable
    
    var transition: Transition {
        return PushTransition()
    }
}

