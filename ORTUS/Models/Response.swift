//
//  Response.swift
//  ORTUS
//
//  Created by Firdavs Khaydarov on 21/03/19.
//  Copyright © 2019 Firdavs. All rights reserved.
//

import Foundation

struct Response<T: Codable>: Codable {
    let jsonrpc: String
    let id: Int
    let result: T
}
