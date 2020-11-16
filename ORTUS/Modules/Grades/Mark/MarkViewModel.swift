//
//  MarkViewModel.swift
//  ORTUS
//
//  Created by Firdavs Khaydarov on 8/19/20.
//  Copyright (c) 2020 Firdavs. All rights reserved.
//

class MarkViewModel: ViewModel {
    let mark: Mark
    
    let router: MarkRouter.Routes
    
    init(mark: Mark, router: MarkRouter.Routes) {
        self.mark = mark
        self.router = router
    }
}
