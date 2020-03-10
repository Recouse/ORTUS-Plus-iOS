//
//  GradesViewModel.swift
//  ORTUS
//
//  Created by Firdavs Khaydarov on 04/02/20.
//  Copyright (c) 2020 Firdavs. All rights reserved.
//

import Promises
import Models

class GradesViewModel: ViewModel {
    let router: GradesRouter.Routes
    
    var studyPrograms: [StudyProgram] = []
    
    init(router: GradesRouter.Routes) {
        self.router = router
    }
    
    func loadMarks() -> Promise<Bool> {
        return Promise { fulfill, reject in
            APIClient.performRequest(StudyProgramsResponse.self, route: MarksApi.marks).then { response in
                self.studyPrograms = response.result
                
                fulfill(true)
            }.catch { reject($0) }
        }
    }
}
