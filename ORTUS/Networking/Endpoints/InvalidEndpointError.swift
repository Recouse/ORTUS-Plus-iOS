//
//  InvalidEndpointError.swift
//  ORTUS
//
//  Created by Firdavs on 02/11/2021.
//  Copyright © 2021 Firdavs. All rights reserved.
//

import Foundation

struct InvalidEndpointError<K: EndpointKind, R: Decodable>: Error {
    let endpoint: Endpoint<K, R>
}
