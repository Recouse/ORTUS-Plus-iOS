//
//  NewsRoute.swift
//  ORTUS
//
//  Created by Firdavs Khaydarov on 04/02/20.
//  Copyright © 2020 Firdavs. All rights reserved.
//

import UIKit

protocol NewsRoute: Route {
    func openNews()
}

extension NewsRoute where Self: RouterProtocol {
    func openNews() {
        let transition = self.transition
        let module = NewsModuleBuilder.build(with: nil, customTransition: transition)
        
        open(module, transition: transition, completion: nil)
    }
}
