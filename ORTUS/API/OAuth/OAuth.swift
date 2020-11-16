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
import KeychainAccess

final class OAuth {
    static let redirectURI = "ortus://auth"
    
    class func buildAuthURL() -> URL? {
        let authUrlRequest = try? OAuthApi.auth.asURLRequest()
        
        return authUrlRequest?.url
    }
    
    static func resolve(_ url: URL) {
        let urlComponents = URLComponents(url: url, resolvingAgainstBaseURL: true)
        
        guard let code = urlComponents?.queryItems?.first(where: { $0.name == "code" })?.value else {
            return
        }
        
        OAuth.getAccessToken(from: code).then { response in
            OAuth.storeTokenData(from: response)
            
            NotificationCenter.default.post(name: .authComplete, object: nil)
        }.catch { error in
            NotificationCenter.default.post(name: .authFailed, object: nil)
        }
    }
    
    static func getAccessToken(from code: String) -> Promise<TokenResponse> {
        return Promise { fulfill, reject in
            APIClient.postFormData(TokenResponse.self, route: OAuthApi.token(code: code)).then { response in
                fulfill(response)
            }.catch { error in
                reject(error)
            }
        }
    }
    
    static func refreshToken(forced: Bool = false) -> Promise<String> {
        let keychain = Keychain()
        let currentDate = Date()
        
        if !forced,
            let accessTokenEncrypted = keychain[Global.Key.accessTokenEncrypted],
            let expiresOn = keychain[Global.Key.tokenExpiresOn],
            let expiresOnDate = TimeInterval(expiresOn),
            currentDate.timeIntervalSince1970 < expiresOnDate  {
            return Promise(accessTokenEncrypted)
        }
        
        return Promise { fulfill, reject in
            APIClient.postFormData(
                RefreshTokenResponse.self,
                route: OAuthApi.refreshToken
            ).then { response in
                OAuth.updateTokenData(from: response)
                
                fulfill(response.accessTokenEncrypted)
            }.catch { reject($0) }
        }
    }
    
    fileprivate static func storeTokenData(from response: TokenResponse) {
        let keychain = Keychain()
        keychain[Global.Key.accessToken] = response.accessToken
        keychain[Global.Key.refreshToken] = response.refreshToken
        keychain[Global.Key.tokenExpiresOn] = expiresInToDate(response.expiresIn)
    }
    
    fileprivate static func updateTokenData(from response: RefreshTokenResponse) {
        let keychain = Keychain()
        keychain[Global.Key.accessToken] = response.accessToken
        keychain[Global.Key.accessTokenEncrypted] = response.accessTokenEncrypted
        keychain[Global.Key.tokenExpiresOn] = expiresInToDate(response.expiresIn)
    }
    
    fileprivate static func expiresInToDate(_ expiresIn: Int) -> String {
        let currentDate = Date()
        let expiresOn = Calendar.current.date(byAdding: .second, value: expiresIn, to: currentDate)
        
        return String(expiresOn?.timeIntervalSince1970 ?? currentDate.timeIntervalSince1970)
    }
}
