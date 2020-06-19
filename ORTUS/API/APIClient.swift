//
//  APIClient.swift
//  ORTUS
//
//  Created by Firdavs Khaydarov on 21/03/19.
//  Copyright © 2019 Firdavs. All rights reserved.
//

import Alamofire
import Promises
import UIKit
import KeychainAccess

class APIClient {
    @discardableResult
    static func performRequest<T: Decodable> (
        _ responseType: T.Type,
        route: API,
        isPublic: Bool = false,
        decoder: JSONDecoder = JSONDecoder()
    ) -> Promise<T> {
        return Promise { fulfill, reject in
            if isPublic {
                requestWithResponse(
                    ofType: responseType,
                    route: route,
                    decoder: decoder
                ).then { response in
                    fulfill(response)
                }.catch { reject($0) }
            } else {
                OAuth.refreshToken().then { _ in
                    requestWithResponse(ofType: responseType, route: route, decoder: decoder)
                }.then { response in
                    fulfill(response)
                }.catch { reject($0) }
            }
        }
    }
    
    @discardableResult
    static func postFormData<T: Decodable> (
        _ responseType: T.Type,
        route: API
    ) -> Promise<T> {
        return Promise { fulfill, reject in
            AF.upload(multipartFormData: {
                guard let parameters = route.parameters else { return }
                
                for (key, value) in parameters {
                    var parameter: String?
                    
                    if let string = value as? String {
                        parameter = string
                    } else if let int = value as? Int {
                        parameter = String(int)
                    }
                    
                    guard let parameterValue = parameter else { continue }
                    
                    $0.append(parameterValue.data(using: .utf8) ?? Data(), withName: key)
                }
            }, with: route).responseDecodable { (response: DataResponse<T, AFError>) in
                switch response.result {
                case .success(let responseObject):
                    fulfill(responseObject)
                case .failure(let error):
                    reject(error)
                }
            }
        }
    }
    
    fileprivate static func requestWithResponse<T: Decodable>(
        ofType type: T.Type,
        route: API,
        decoder: JSONDecoder = JSONDecoder()
    ) -> Promise<T> {
        return Promise { fulfill, reject in
            AF.request(route).responseDecodable (decoder: decoder) { (response: DataResponse<T, AFError>) in
                print(String(bytes: response.data ?? Data(), encoding: .utf8))
                switch response.result {
                case .success(let responseObject):
                    fulfill(responseObject)
                case .failure(let error):
                    reject(error)
                }
            }
        }
    }
}
