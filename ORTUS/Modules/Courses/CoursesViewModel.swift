//
//  CoursesViewModel.swift
//  ORTUS
//
//  Created by Firdavs Khaydarov on 25/03/19.
//  Copyright (c) 2019 Firdavs. All rights reserved.
//

import Promises

class CoursesViewModel: ViewModel {
    let router: CoursesRouter.Routes
        
    var semesters: Semesters = []
    
    init(router: CoursesRouter.Routes) {
        self.router = router
    }
    
    func loadCourses() -> Promise<Bool> {
        return Promise { fulfill, reject in
            APIClient.performRequest(
                CoursesResponse.self,
                route: CoursesApi.courses
            ).then { response in
                self.semesters = response.result
                
                fulfill(true)
            }.catch { reject($0) }
        }
    }
}
