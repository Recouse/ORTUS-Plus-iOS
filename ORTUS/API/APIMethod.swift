//
//  APIMethod.swift
//  ORTUS
//
//  Created by Firdavs Khaydarov on 21/03/19.
//  Copyright © 2019 Firdavs. All rights reserved.
//

import Foundation
import Localize_Swift

enum APIMethod: String {
    case getPublicArticles
    
    var parameters: [String] {
        var values: [String] = []
        
        switch self {
        case .getPublicArticles:
            values.append(Global.clientID)
            values.append(Localize.currentLanguage())
        }
        
        return values
    }
}
