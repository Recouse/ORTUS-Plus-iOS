//
//  GradesViewModel.swift
//  ORTUS
//
//  Created by Firdavs Khaydarov on 04/02/20.
//  Copyright (c) 2020 Firdavs. All rights reserved.
//

import Promises
import Models
import Storage

class GradesViewModel: ViewModel {
    let router: GradesRouter.Routes
    
    var studyPrograms: [StudyProgram] = []
        
    init(router: GradesRouter.Routes) {
        self.router = router
    }
    
    @discardableResult
    func loadMarks() -> Promise<Bool> {
        return Promise { fulfill, reject in
            APIClient.performRequest(StudyProgramsResponse.self, route: MarksApi.marks).then { response in
                self.studyPrograms = response.result
                
                Cache.shared.save(response, forKey: Global.Key.gradesCache)
                
                fulfill(true)
            }.catch { reject($0) }
        }
    }
    
    func loadCachedMarks() -> Promise<Bool> {
        return Promise { fulfill, reject in
            do {
                let response = try Cache.shared.fetch(
                    StudyProgramsResponse.self,
                    forKey: Global.Key.gradesCache
                )
                
                self.studyPrograms = response.result
                
                fulfill(true)
            } catch StorageError.notFound {
                fulfill(true)
            } catch {
                reject(error)
            }
        }
    }
}
