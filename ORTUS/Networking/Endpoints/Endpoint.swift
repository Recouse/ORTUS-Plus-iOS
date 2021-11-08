//
//  Endpoint.swift
//  ORTUS
//
//  Created by Firdavs on 01/11/2021.
//  Copyright © 2021 Firdavs. All rights reserved.
//

import Foundation
import Combine

struct Endpoint<Kind: EndpointKind, Response: Decodable> {
    var host: EndpointHost
    var path: String
    var method: HTTPMethod
    var parameters: Parameters = [:]
}

extension Endpoint {
    func makeRequest() -> URLRequest? {
        var components = URLComponents()
        components.scheme = "https"
        components.host = host.rawValue
        components.path = "/" + path
        
        if method == .get {
            let queryItems = parameters.toQueryItems()
            components.queryItems = queryItems.isEmpty ? nil : parameters.toQueryItems()
        }
        
        guard let url = components.url else {
            return nil
        }

        var request = URLRequest(url: url)
        request.httpMethod = method.rawValue
        
        request.setValue(
            ContentType.json.rawValue,
            forHTTPHeaderField: HTTPHeaderField.acceptType.rawValue
        )
        
        if method == .post || method == .put || method == .delete {
            request.setValue(
                ContentType.json.rawValue,
                forHTTPHeaderField: HTTPHeaderField.contentType.rawValue
            )
            
            request.httpBody = parameters.toJSON()
        }
        
        return request
    }
    
    static func buildParameters(for method: APIMethod) -> Parameters {
        var parameters: Parameters = [:]
        
        parameters["id"] = 1
        parameters["jsonrpc"] = 2.0
        parameters["method"] = method.rawValue
        parameters["params"] = method.parameters
        
        return parameters
    }
}

extension URLSession {
    func publisher<K, R>(
        for endpoint: Endpoint<K, R>,
        decoder: JSONDecoder = .init()
    ) -> AnyPublisher<R, Error> {
        guard let request = endpoint.makeRequest() else {
            return Fail(
                error: InvalidEndpointError(endpoint: endpoint)
            ).eraseToAnyPublisher()
        }

        return dataTaskPublisher(for: request)
            .map(\.data)
            .decode(type: R.self, decoder: decoder)
            .eraseToAnyPublisher()
    }
}
