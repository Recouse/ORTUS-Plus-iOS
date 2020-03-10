//
//  SemesterRoute.swift
//  ORTUS
//
//  Created by Firdavs Khaydarov on 04/02/20.
//  Copyright © 2020 Firdavs. All rights reserved.
//

import UIKit
import Models

protocol SemesterRoute: Route {
    func openSemester(_ semester: Semester)
}

extension SettingsRoute where Self: RouterProtocol {
    func openSemester(_ semester: Semester) {
        let transition = self.transition
        let module = SemesterModuleBuilder.build(with: semester, customTransition: transition)
        
        open(module, transition: transition, completion: nil)
    }
}
