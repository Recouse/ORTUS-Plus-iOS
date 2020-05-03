//
//  API.swift
//  ORTUS
//
//  Created by Firdavs Khaydarov on 21/03/19.
//  Copyright © 2019 Firdavs. All rights reserved.
//

import Foundation
import Alamofire
import KeychainAccess
import Localize_Swift

protocol API: URLRequestConvertible {
    var method: HTTPMethod { get }
    var path: String { get }
    var parameters: Parameters? { get }
    var withGlobalApi: Bool { get }
}

extension API {
    var withGlobalApi: Bool {
        return true
    }
    
    func asURLRequest() throws -> URLRequest {        
        var urlRequest = URLRequest(url: try path.asURL())
        
        if withGlobalApi {
            let url = try Global.Server.baseURL.asURL()
            urlRequest = URLRequest(url: url.appendingPathComponent(path))
        }
        
        // HTTP Method
        urlRequest.httpMethod = method.rawValue
        
        urlRequest.setValue(CacheControl.noCache.rawValue,
                            forHTTPHeaderField: HTTPHeaderField.cacheControl.rawValue)
        urlRequest.setValue(ContentType.json.rawValue,
                            forHTTPHeaderField: HTTPHeaderField.acceptType.rawValue)
        urlRequest.setValue(ContentType.json.rawValue,
                            forHTTPHeaderField: HTTPHeaderField.contentType.rawValue)
        
        if method == .post || method == .put || method == .delete {
            return try JSONEncoding.default.encode(urlRequest, with: parameters)
        }
        
        return try URLEncoding.default.encode(urlRequest, with: parameters)
    }
    
    func parameters(for method: APIMethod) -> Parameters {
        var parameters: Parameters = [:]
        
        parameters["id"] = 1
        parameters["jsonrpc"] = 2.0
        parameters["method"] = method.rawValue
        parameters["params"] = method.parameters
        
        return parameters
    }
}
