//
//  Rest.swift
//  GoRest
//
//  Created by Alexander Grishin on 29.01.2020.
//  Copyright © 2020 Alexander Grishin. All rights reserved.
//

import UIKit

public class Rest {
    
    
    public static let shared = Rest()

    private init() {
    }
    
    private let urlSession = URLSession(configuration: .default)
    
    private enum API {
         static let baseURL = "https://gorest.co.in/public-api/"
     }

    public enum HTTPMethod: String {
        case get = "GET", post = "POST", delete = "DELETE"
    }
    
    public typealias SuccessHandler<T> = (_ meta: Meta, _ data: T) -> Void

    public typealias FailureHandler = (_ error: Error) -> Void
    
    public func request <T: Codable>(_ endpoint: String,
                                        method: HTTPMethod = .get,
                                        parameters: Parameters = [:],
                                        success: SuccessHandler<T>?,
                                        failure: FailureHandler?) {

        let urlRequest = buildURLRequest(endpoint, method: method, parameters: parameters)

        urlSession.dataTask(with: urlRequest) { data, _, error in
            if let data = data {
                //print(NSString(data: data, encoding:String.Encoding.utf8.rawValue)!)
                DispatchQueue.global(qos: .utility).async {
                    do {
                        let jsonDecoder = JSONDecoder()
                        //jsonDecoder.keyDecodingStrategy = .convertFromSnakeCase
                        let object = try jsonDecoder.decode(RestResponse<T>.self, from: data)
                        let meta = object.meta
                        if let result = object.result  {
                            DispatchQueue.main.async {
                                success?(meta, result)
                            }
                        } else if let message = object.meta.message {
                            DispatchQueue.main.async {
                                print("******* message")
                                print(message)
                                //failure?(Error.invalidRequest(message: message))
                            }
                        }
                    } catch let error {
                        DispatchQueue.main.async {
                            print("******* error message")
                            failure?(error)
                            //failure?(Error.decoding(message: error.localizedDescription))
                        }
                    }
                }
            } else if let error = error {
                failure?(error)
            }
        }.resume()
        
    }
    

    
    private func buildURLRequest(_ endpoint: String, method: HTTPMethod, parameters: Parameters) -> URLRequest {
        let url = URL(string: API.baseURL + endpoint)!.appendingQueryParameters(["format": "json", "access-token": tokenRestAPI])

        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = method.rawValue

        switch method {
        case .get, .delete:
            urlRequest.url?.appendQueryParameters(parameters)
        case .post:
            urlRequest.httpBody = Data(parameters: parameters)
        }

        return urlRequest
    
    }

}
