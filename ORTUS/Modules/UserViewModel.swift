//
//  UserViewModel.swift
//  ORTUS
//
//  Created by Firdavs Khaydarov on 25/03/19.
//  Copyright © 2019 Firdavs. All rights reserved.
//

import UIKit

class UserViewModel {
    static var isLoggedIn: Bool {
        let keychain = Keychain.default
        
        return keychain[.accessToken] != nil
    }
    
    static func signOut() {
        let keychain = Keychain.default
        keychain[.accessToken] = nil
        keychain[.refreshToken] = nil
        keychain[.tokenExpiresOn] = nil
        keychain[.accessTokenEncrypted] = nil
        keychain[.ortusPinCode] = nil
        
        // App cache
        Cache.shared.clear()
        
        // App group cache
        let sharedCache = Cache(path: AppGroup.default.containerURL)
        sharedCache.clear()
        
        // Reset pin code suggestion
        UserDefaults.standard.set(false, for: .pinCodeSuggestion)
        
        Shortcut.deleteShortcuts {
            NotificationCenter.default.post(name: .userSignedOut, object: nil)
        }
    }
}
