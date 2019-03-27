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
    let expiresIn: Int
    let refreshToken, scope, tokenType: String

    enum CodingKeys: String, CodingKey {
        case accessToken = "access_token"
        case expiresIn = "expires_in"
        case refreshToken = "refresh_token"
        case scope
        case tokenType = "token_type"
    }
}
