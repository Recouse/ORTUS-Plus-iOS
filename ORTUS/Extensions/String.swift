//
//  String.swift
//  ORTUS
//
//  Created by Firdavs Khaydarov on 23/11/19.
//  Copyright © 2019 Firdavs. All rights reserved.
//

import Foundation
import KeychainAccess

extension String {
    func generatePinAuthURL() -> URL? {
        let keychain = Keychain()
        
        let queryItems = [
            URLQueryItem(name: "module", value: "PINAuth"),
            URLQueryItem(name: "locale", value: "en"),
            URLQueryItem(name: "token", value: keychain[Global.Key.accessTokenEncrypted]),
            URLQueryItem(name: "goto", value: self.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed))
        ]
        
        guard var urlComponents = URLComponents(string: Global.Server.pinAuthURL) else {
            return nil
        }
        
        urlComponents.queryItems = queryItems
        
        return urlComponents.url
    }
}
