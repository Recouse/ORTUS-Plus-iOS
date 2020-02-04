//
//  GradesViewModel.swift
//  ORTUS
//
//  Created by Firdavs Khaydarov on 04/02/20.
//  Copyright (c) 2020 Firdavs. All rights reserved.
//

class GradesViewModel: ViewModel {
    let router: GradesRouter.Routes
    
    init(router: GradesRouter.Routes) {
        self.router = router
    }
}
