//
//  CoursesRouter.swift
//  ORTUS
//
//  Created by Firdavs Khaydarov on 25/03/19.
//  Copyright (c) 2019 Firdavs. All rights reserved.
//

final class CoursesRouter: Router<CoursesViewController>, BrowserRoute {
    typealias Routes = BrowserRoute & Closable
    
    var transition: Transition {
        return PushTransition()
    }
}
