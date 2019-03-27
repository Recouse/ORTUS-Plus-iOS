//
//  OAuth.swift
//  ORTUS
//
//  Created by Firdavs Khaydarov on 23/03/19.
//  Copyright © 2019 Firdavs. All rights reserved.
//

import Foundation
import Alamofire
import Promises
import Localize_Swift
import KeychainAccess

class OAuth {
    static let redirectURI = "ortus://auth"
    
    class func buildAuthURL() -> URL? {
        let authUrlRequest = try? OAuthApi.auth.asURLRequest()
        
        return authUrlRequest?.url
    }
    
    class func resolve(_ url: URL) {
        let keychain = Keychain()
        
        let urlComponents = URLComponents(url: url, resolvingAgainstBaseURL: true)
        
        guard let code = urlComponents?.queryItems?.first(where: { $0.name == "code" })?.value else {
            return
        }
        
        OAuth.getAccessToken(from: code).then { response in
            keychain[Global.Key.accessToken] = response.accessToken
            keychain[Global.Key.refreshToken] = response.refreshToken
            keychain[Global.Key.tokenExpiresIn] = String(response.expiresIn)
            
            NotificationCenter.default.post(name: .authComplete, object: nil)
        }.catch { error in
            NotificationCenter.default.post(name: .authFailed, object: nil)
        }
    }
    
    class func getAccessToken(from code: String) -> Promise<TokenResponse> {
        return Promise { fulfill, reject in
            APIClient.postFormData(TokenResponse.self, route: OAuthApi.token(code: code)).then { response in
                fulfill(response)
            }.catch { error in
                reject(error)
            }
        }
    }
}
