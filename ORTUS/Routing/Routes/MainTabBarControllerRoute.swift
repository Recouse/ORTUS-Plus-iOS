//
//  MainTabBarControllerRoute.swift
//  ORTUS
//
//  Created by Firdavs Khaydarov on 08/12/19.
//  Copyright © 2019 Firdavs. All rights reserved.
//

import UIKit

protocol MainTabBarControllerRoute: Route {
    func openMainTabBarController()
    
}

extension MainTabBarControllerRoute where Self: RouterProtocol {
    var transition: Transition {
        return DefaultTransition()
    }
    
    func openMainTabBarController() {
        let mainTabBatController = MainTabBarController()
        
        let window = UIApplication.shared.keyWindow
        window?.setRootViewController(mainTabBatController)
    }
}
