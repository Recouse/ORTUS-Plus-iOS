//
//  ContactsApi.swift
//  ORTUS
//
//  Created by Firdavs Khaydarov on 4/5/20.
//  Copyright © 2020 Firdavs. All rights reserved.
//

import Alamofire

enum ContactsApi: API {
    case publicContacts
    
    var method: HTTPMethod {
        switch self {
        default:
            return .post
        }
    }
    
    var path: String {
        switch self {
        default:
            return "oauth/contacts"
        }
    }
    
    var parameters: Parameters? {
        switch self {
        case .publicContacts:
            return parameters(for: .getPublicContacts)
        }
    }
}
