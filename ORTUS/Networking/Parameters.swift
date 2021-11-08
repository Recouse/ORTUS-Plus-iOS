//
//  Parameters.swift
//  ORTUS
//
//  Created by Firdavs on 02/11/2021.
//  Copyright © 2021 Firdavs. All rights reserved.
//

import Foundation

typealias Parameters = [String: Any]

extension Parameters {
    func toQueryItems() -> [URLQueryItem] {
        guard let parameters = self as? Dictionary<String, LosslessStringConvertible> else {
            return []
        }
        
        return parameters.map {
            URLQueryItem(name: $0.key, value: $0.value.description)
        }
    }
    
    func toJSON() -> Data? {
        try? JSONSerialization.data(withJSONObject: self, options: [])
    }
}
