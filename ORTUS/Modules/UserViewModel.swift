//
//  UserViewModel.swift
//  ORTUS
//
//  Created by Firdavs Khaydarov on 25/03/19.
//  Copyright © 2019 Firdavs. All rights reserved.
//

import UIKit
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
        keychain[Global.Key.accessTokenEncrypted] = nil
        keychain[Global.Key.ortusPinCode] = nil
        
        // App cache
        Cache.shared.clear()
        
        // App group cache
        let sharedCache = Cache(path: AppGroup.default.containerURL)
        sharedCache.clear()
        
        // Reset pin code suggestion
        UserDefaults.standard.set(false, for: .pinCodeSuggestion)
        
        UIApplication.shared.setMinimumBackgroundFetchInterval(UIApplication.backgroundFetchIntervalNever)
        
        Shortcut.deleteShortcuts {
            NotificationCenter.default.post(name: .userSignedOut, object: nil)
        }
    }
}
