//
//  MarkRoute.swift
//  ORTUS
//
//  Created by Firdavs Khaydarov on 8/19/20.
//  Copyright © 2020 Firdavs. All rights reserved.
//

import UIKit

protocol MarkRoute: Route {
    func openMark(_ mark: Mark)
}

extension MarkRoute where Self: RouterProtocol {
    func openMark(_ mark: Mark) {
        let transition = self.transition
        let module = MarkModuleBuilder.build(with: mark, customTransition: transition)
        
        open(module, transition: transition, completion: nil)
    }
}
