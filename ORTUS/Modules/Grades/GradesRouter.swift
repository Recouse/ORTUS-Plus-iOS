//
//  GradesRouter.swift
//  ORTUS
//
//  Created by Firdavs Khaydarov on 04/02/20.
//  Copyright (c) 2020 Firdavs. All rights reserved.
//

final class GradesRouter: Router<GradesViewController>, MarkRoute {
    typealias Routes = MarkRoute & Closable
    
    var transition: Transition {
        PushTransition()
    }
}

