//
//  OAuthApi.swift
//  ORTUS
//
//  Created by Firdavs Khaydarov on 23/03/19.
//  Copyright © 2019 Firdavs. All rights reserved.
//

import Alamofire

enum OAuthApi: API {
    case auth
    case token(code: String)
    
    var method: HTTPMethod {
        switch self {
        case .auth:
            return .get
        case .token:
            return .post
        }
    }
    
    var path: String {
        switch self {
        case .auth:
            return "https://id2.rtu.lv/openam/oauth2/authorize"
        case let .token(code):
            return "https://id2.rtu.lv/openam/oauth2/access_token?client_id=\(Global.clientID)&client_secret=\(Global.clientSecret)&redirect_uri=\(OAuth.redirectURI)&grant_type=authorization_code&code=\(code)"
        }
    }
    
    var parameters: Parameters? {
        switch self {
        case .auth:
            var parameters: Parameters = [:]
            
            parameters["client_id"] = Global.clientID
            parameters["response_type"] = "code"
            parameters["redirect_uri"] = OAuth.redirectURI
            parameters["scope"] = "uid"
            parameters["locale"] = Global.Locale.current
            
            return parameters
        default:
            return nil
        }
    }
    
    var withGlobalApi: Bool {
        return false
    }
}
