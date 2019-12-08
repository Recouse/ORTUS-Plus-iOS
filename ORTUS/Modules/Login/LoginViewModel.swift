//
//  LoginViewModel.swift
//  ORTUS
//
//  Created by Firdavs Khaydarov on 07/12/19.
//  Copyright (c) 2019 Firdavs. All rights reserved.
//

class LoginViewModel: ViewModel {
    let router: LoginRouter.Routes
    
    init(router: LoginRouter.Routes) {
        self.router = router
    }
}
