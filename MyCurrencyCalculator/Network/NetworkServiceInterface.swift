//
//  NetworkServiceInterface.swift
//  MyCurrencyCalculator
//
//  Created by Prof_K on 17/07/2023.
//

import Foundation
import Alamofire
import SwiftyJSON
import Combine

protocol ServiceProtocol {

    /// - Parameters:
    ///   - url: url for request
    ///   - method: methods for POST, GET, PUT and DELETE
    ///   - parameters: request body as dictionary or
    /// - Returns: returns AnyPublisher with the data response
    func requestWithParameter<Y: Encodable>(url :String,
                             method: HTTPMethod,
                             parameters: Y?) -> AnyPublisher<JSON, Error>
}

extension ServiceProtocol {
    func requestWithParameter<Y: Encodable>(
        url :String,
        method: HTTPMethod,
        parameters: Y?) -> AnyPublisher<JSON, Error> {
            return AF.request(url).publishData()
                .tryMap { response -> JSON in
                    let json = try JSON(data: response.data ?? Data())
                    return json
                }
                .mapError { error -> AFError in
                    if let afError = error as? AFError {
                        return afError
                    } else {
                        return AFError.responseSerializationFailed(reason: .customSerializationFailed(error: error))
                    }
                }
                .eraseToAnyPublisher()
        }
}
