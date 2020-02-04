//
//  GradesRoute.swift
//  ORTUS
//
//  Created by Firdavs Khaydarov on 04/02/20.
//  Copyright © 2020 Firdavs. All rights reserved.
//

import UIKit

protocol GradesRoute: Route {
    func openGrades()
}

extension GradesRoute where Self: RouterProtocol {
    func openGrades() {
        let transition = self.transition
        let module = GradesModuleBuilder.build(with: nil, customTransition: transition)
        
        open(module, transition: transition, completion: nil)
    }
}
