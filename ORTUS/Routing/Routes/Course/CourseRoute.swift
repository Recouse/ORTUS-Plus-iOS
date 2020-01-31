//
//  CourseRoute.swift
//  ORTUS
//
//  Created by Firdavs Khaydarov on 24/12/19.
//  Copyright © 2019 Firdavs. All rights reserved.
//

import UIKit

protocol CourseRoute: Route {
    func openCourse(_ course: Course)
}

extension CourseRoute where Self: RouterProtocol {
    func openCourse(_ course: Course) {
        let transition = self.transition
        let module = CourseModuleBuilder.build(with: course, customTransition: transition)
        module.hidesBottomBarWhenPushed = true
        
        open(module, transition: transition, completion: nil)
    }
}
