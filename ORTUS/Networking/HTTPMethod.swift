//
//  HTTPMethod.swift
//  ORTUS
//
//  Created by Firdavs on 02/11/2021.
//  Copyright © 2021 Firdavs. All rights reserved.
//

import Foundation

struct HTTPMethod: RawRepresentable {
    let rawValue: String
    
    static let get = HTTPMethod(rawValue: "GET")
    
    static let post = HTTPMethod(rawValue: "POST")
    
    static let put = HTTPMethod(rawValue: "PUT")
    
    static let delete = HTTPMethod(rawValue: "DELETE")
}
