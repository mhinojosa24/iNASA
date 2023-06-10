//
//  ApiRequest.swift
//  iNASA
//
//  Created by Maximo Hinojosa on 6/10/23.
//

import Foundation


enum HTTPMethod: String {
    case get = "GET"
    case post = "POST"
    case update = "UPDATE"
    case delete = "DELETE"
}

class ApiRequest<T> {
    private(set) var endpoint: Any
    private(set) var method: HTTPMethod
    private(set) var headers: [String: Any]
    private(set) var parameters: [String: Any]
    
    init(endpoint: Any, method: HTTPMethod, headers: [String : Any] = [:], parameters: [String : Any] = [:]) {
        self.endpoint = endpoint
        self.method = method
        self.headers = headers
        self.parameters = parameters
    }
}
