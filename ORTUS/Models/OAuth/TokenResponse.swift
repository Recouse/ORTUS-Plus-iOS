//
//  TokenResponse.swift
//  ORTUS
//
//  Created by Firdavs Khaydarov on 25/03/19.
//  Copyright © 2019 Firdavs. All rights reserved.
//

import Foundation

public struct TokenResponse: Codable {
    public let accessToken: String
    public let refreshToken, scope, tokenType: String
    public let expiresIn: Int

    enum CodingKeys: String, CodingKey {
        case accessToken = "access_token"
        case refreshToken = "refresh_token"
        case scope
        case tokenType = "token_type"
        case expiresIn = "expires_in"
    }
}

public struct RefreshTokenResponse: Codable {
    public let accessToken: String
    public let accessTokenEncrypted: String
    public let scope, tokenType: String
    public let expiresIn: Int

    enum CodingKeys: String, CodingKey {
        case accessToken = "access_token"
        case accessTokenEncrypted = "access_token_encrypted"
        case scope
        case tokenType = "token_type"
        case expiresIn = "expires_in"
    }
}
