//
//  LoginRoute.swift
//  ORTUS
//
//  Created by Firdavs Khaydarov on 08/12/19.
//  Copyright © 2019 Firdavs. All rights reserved.
//

import UIKit

protocol LoginRoute: Route {
    func openLogin()
    
}

extension LoginRoute where Self: RouterProtocol {
    var transition: Transition {
        return DefaultTransition()
    }
    
    func openLogin() {
        let loginController = LoginModuleBuilder.build()
        
        let window = UIApplication.shared.keyWindow
        window?.setRootViewController(loginController)
    }
}
