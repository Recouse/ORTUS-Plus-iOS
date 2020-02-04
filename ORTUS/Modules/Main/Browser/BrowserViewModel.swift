//
//  BrowserViewModel.swift
//  ORTUS
//
//  Created by Firdavs Khaydarov on 24/12/19.
//  Copyright (c) 2019 Firdavs. All rights reserved.
//

import Foundation
import KeychainAccess

class BrowserViewModel: ViewModel {
    let url: String
    
    let router: BrowserRouter.Routes
    
    let keychain = Keychain()
    
    init(url: String, router: BrowserRouter.Routes) {
        self.url = url
        self.router = router
    }
    
    func loadBrowserJS() -> String {
        guard let filepath = Bundle.main.path(forResource: "browser", ofType: "js") else {
            return ""
        }
        
        do {
            return try String(contentsOfFile: filepath)
        } catch {
            return ""
        }
    }
}
