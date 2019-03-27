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
        decoder: JSONDecoder = JSONDecoder()
    ) -> Promise<T> {
        return Promise { fulfill, reject in
            AF.request(route).responseDecodable (decoder: decoder) { (response: DataResponse<T>) in
                switch response.result {
                case .success(let responseObject):
                    fulfill(responseObject)
                case .failure(let error):
                    reject(error)
                }
            }
        }
    }
    
    @discardableResult
    static func performRequest(route: API) -> Promise<Bool> {
        return Promise { fulfill, reject in
            AF.request(route).responseData { response in
                switch response.result {
                case .success:
                    fulfill(true)
                case .failure(let error):
                    reject(error)
                }
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
            }, with: route).responseDecodable { (response: DataResponse<T>) in
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
