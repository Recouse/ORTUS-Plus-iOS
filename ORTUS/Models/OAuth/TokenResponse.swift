//
//  TokenResponse.swift
//  ORTUS
//
//  Created by Firdavs Khaydarov on 25/03/19.
//  Copyright © 2019 Firdavs. All rights reserved.
//

import Foundation

struct TokenResponse: Codable {
    let accessToken: String
    let refreshToken, scope, tokenType: String
    let expiresIn: Int

    enum CodingKeys: String, CodingKey {
        case accessToken = "access_token"
        case refreshToken = "refresh_token"
        case scope
        case tokenType = "token_type"
        case expiresIn = "expires_in"
    }
}

struct RefreshTokenResponse: Codable {
    let accessToken: String
    let accessTokenEncrypted: String
    let scope, tokenType: String
    let expiresIn: Int

    enum CodingKeys: String, CodingKey {
        case accessToken = "access_token"
        case accessTokenEncrypted = "access_token_encrypted"
        case scope
        case tokenType = "token_type"
        case expiresIn = "expires_in"
    }
}
