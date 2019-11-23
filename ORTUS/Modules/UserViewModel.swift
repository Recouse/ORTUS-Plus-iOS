//
//  UserViewModel.swift
//  ORTUS
//
//  Created by Firdavs Khaydarov on 25/03/19.
//  Copyright © 2019 Firdavs. All rights reserved.
//

import Foundation
import KeychainAccess

class UserViewModel {
    static var isLoggedIn: Bool {
        let keychain = Keychain()
        
        return keychain[Global.Key.accessToken] != nil
    }
    
    static func signOut() {
        let keychain = Keychain()
        keychain[Global.Key.accessToken] = nil
        keychain[Global.Key.refreshToken] = nil
        keychain[Global.Key.tokenExpiresOn] = nil
        
        NotificationCenter.default.post(name: .userSignedOut, object: nil)
    }
}
