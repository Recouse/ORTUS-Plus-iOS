//
//  CourseViewModel.swift
//  ORTUS
//
//  Created by Firdavs Khaydarov on 24/12/19.
//  Copyright (c) 2019 Firdavs. All rights reserved.
//

import Foundation
import KeychainAccess

class CourseViewModel: ViewModel {
    let course: Course
    
    let router: CourseRouter.Routes
    
    let keychain = Keychain()
    
    init(course: Course, router: CourseRouter.Routes) {
        self.course = course
        self.router = router
    }
    
    func loadCourseJS() -> String {
        guard let filepath = Bundle.main.path(forResource: "course", ofType: "js") else {
            return ""
        }
        
        do {
            return try String(contentsOfFile: filepath)
        } catch {
            return ""
        }
    }
}
