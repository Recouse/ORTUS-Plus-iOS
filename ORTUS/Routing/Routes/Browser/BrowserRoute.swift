//
//  BrowserRoute.swift
//  ORTUS
//
//  Created by Firdavs Khaydarov on 24/12/19.
//  Copyright © 2019 Firdavs. All rights reserved.
//

import UIKit

protocol BrowserRoute: Route {
    func openBrowser(_ url: String)
}

extension BrowserRoute where Self: RouterProtocol {
    func openBrowser(_ url: String) {
        let transition = self.transition
        let module = BrowserModuleBuilder.build(with: url, customTransition: transition)
        module.hidesBottomBarWhenPushed = true
        
        open(module, transition: transition, completion: nil)
    }
}
